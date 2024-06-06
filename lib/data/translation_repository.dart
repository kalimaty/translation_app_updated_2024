//  import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class TranslationRepository {
  // Future<void> saveTranslation(String text) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? translations = prefs.getStringList('translations');
  //   translations = translations ?? [];
  //   translations.add(text);
  //   await prefs.setStringList('translations', translations);
  // }

  // Future<List<String>> getTranslations() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getStringList('translations') ?? [];
  // }
  // List<Map<String, String>> _translations = [];
  // Future<void> _loadWords() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? savedTranslations = prefs.getStringList('savedTranslations');
  //   if (savedTranslations != null) {
  //     _translations = savedTranslations
  //         .map((t) => Map<String, String>.from(jsonDecode(t)))
  //         .toList();
  //   }
  //   // notifyListeners();
  // }
// }

