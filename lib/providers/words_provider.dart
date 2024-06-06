import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';

enum TtsState { playing, stopped }

class WordsProvider with ChangeNotifier {
  List<Map<String, String>> _translations = [];
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _ttsState = TtsState.stopped;
  String _currentWord = '';
  String _currentInput = '';
  String _translation = '';
  String _fromLanguage = 'en';
  String _toLanguage = 'ar';
  String _fromLanguageDisplay = 'English';
  String _toLanguageDisplay = 'Arabic';
  TextEditingController _textController = TextEditingController();
  final _formKeyGlobal = GlobalKey<FormState>();

  WordsProvider() {
    _loadWords();
    _initializeTts();
  }

  List<Map<String, String>> get translations => _translations;
  TtsState get ttsState => _ttsState;
  String get currentWord => _currentWord;
  String get translation => _translation;
  String get fromLanguage => _fromLanguage;
  String get toLanguage => _toLanguage;
  String get fromLanguageDisplay => _fromLanguageDisplay;
  String get toLanguageDisplay => _toLanguageDisplay;
  TextEditingController get textController => _textController;
  GlobalKey<FormState> get formKeyGlobal => _formKeyGlobal;
  List<dynamic> allSounds = [];

  Future<void> _initializeTts() async {
    _flutterTts.setStartHandler(() {
      _ttsState = TtsState.playing;
      notifyListeners();
    });

    _flutterTts.setCompletionHandler(() {
      _ttsState = TtsState.stopped;
      notifyListeners();
    });

    _flutterTts.setErrorHandler((msg) {
      _ttsState = TtsState.stopped;
      notifyListeners();
    });

    _flutterTts.getVoices.then((voices) {
      allSounds = voices.where((voice) => voice['locale'] == 'en-US').toList();
      notifyListeners();
    });
  }

  Future<void> _loadWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedTranslations = prefs.getStringList('savedTranslations');
    if (savedTranslations != null) {
      _translations = savedTranslations
          .map((t) => Map<String, String>.from(jsonDecode(t)))
          .toList();
    }
    notifyListeners();
  }

  void _saveWords() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('savedTranslations',
          _translations.map((t) => jsonEncode(t)).toList());
    });
  }

  Future<void> stopCurrentPlaying() async {
    if (_ttsState == TtsState.playing) {
      await _flutterTts.stop();
      _ttsState = TtsState.stopped;
      _currentWord = '';
      notifyListeners();
    }
  }

  Future<void> speak(String word) async {
    if (_ttsState == TtsState.stopped) {
      _currentWord = word;
      await _flutterTts.speak(word);
      _ttsState = TtsState.playing;
    } else if (_ttsState == TtsState.playing && _currentWord == word) {
      await _flutterTts.stop();
      _ttsState = TtsState.stopped;
    } else if (_ttsState == TtsState.playing && _currentWord != word) {
      await _flutterTts.stop();
      _ttsState = TtsState.stopped;
      _currentWord = word;
      await _flutterTts.speak(word);
      _ttsState = TtsState.playing;
    }
    notifyListeners();
  }

  void addWord(String word) {
    if (!_translations.any((element) => element['output'] == word)) {
      _translations.add({'input': _textController.text, 'output': word});
      _saveWords();
      notifyListeners();
    }
  }

  void deleteWord(int index) {
    if (index >= 0 && index < _translations.length) {
      _translations.removeAt(index);
      _saveWords();
      notifyListeners();
    } else {
      print('Invalid index: $index');
    }
  }

  bool isPlaying(String word) {
    return _ttsState == TtsState.playing && _currentWord == word;
  }

  void setFromLanguage(String code, String display) {
    _fromLanguage = code;
    _fromLanguageDisplay = display;
    notifyListeners();
  }

  void setToLanguage(String code, String display) {
    _toLanguage = code;
    _toLanguageDisplay = display;
    notifyListeners();
  }

  void switchLanguages() {
    final tempCode = _fromLanguage;
    final tempDisplay = _fromLanguageDisplay;
    setFromLanguage(_toLanguage, _toLanguageDisplay);
    setToLanguage(tempCode, tempDisplay);
    resetFields();
  }

  String detectLanguage(String text) {
    final arabicPattern = RegExp(r'[\u0600-\u06FF]');
    final englishPattern = RegExp(r'[A-Za-z]');
    if (arabicPattern.hasMatch(text)) {
      return 'ar';
    } else if (englishPattern.hasMatch(text)) {
      return 'en';
    } else {
      return 'unknown';
    }
  }

  bool isTranslationCompatible(String text, String fromLanguage) {
    String detectedLanguage = detectLanguage(text);
    return detectedLanguage == fromLanguage;
  }

  Future<void> translate(BuildContext context) async {
    if (_formKeyGlobal.currentState?.validate() ?? false) {
      if (_textController.text != _currentInput) {
        if (isTranslationCompatible(_textController.text, _fromLanguage)) {
          _currentInput = _textController.text;
          try {
            final translation = await GoogleTranslator().translate(
              _textController.text,
              from: _fromLanguage,
              to: _toLanguage,
            );
            _translation = translation.text;
            if (!_translations.any((element) =>
                element['input'] == _textController.text &&
                element['output'] == _translation)) {
              _translations.add({
                'input': _textController.text,
                'output': _translation,
              });
              _saveWords();
              speak(_translation);
            }
            notifyListeners();
          } on SocketException {
            _translation = 'Failed to connect. Check your internet connection.';
            notifyListeners();
          } catch (e) {
            _translation = 'Error occurred during translation.';
            notifyListeners();
          }
        } else {
          _showIncompatibleLanguageDialog(context);
        }
      } else {
        _translation = 'Translation already provided for this input.';
        notifyListeners();
      }
    }
  }

  void _showIncompatibleLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incompatible Language'),
          content: Text(
              'The entered text language does not match the selected translation direction.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetFields();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetFields() {
    _textController.clear();
    _translation = '';
    _currentInput = '';
    notifyListeners();
  }
}
