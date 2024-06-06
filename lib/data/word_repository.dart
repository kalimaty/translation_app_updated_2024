// import 'package:shared_preferences/shared_preferences.dart';

// class WordRepository {
//   static const String _wordsKey = 'saved_words';

//   Future<List<String>> loadWords() async {
//     final prefs = await SharedPreferences.getInstance();
//     final words = prefs.getStringList(_wordsKey) ?? [];
//     return words;
//   }

//   Future<void> saveWords(List<String> words) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setStringList(_wordsKey, words);
//   }
// }
