// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:translator/translator.dart';
// import 'data/translation_repository.dart';
// import 'presentation/note_translation_page.dart';

// void main() {
//   runApp(MaterialApp(
//     home: TranslatorApp(),
//   ));
// }

// class TranslatorApp extends StatefulWidget {
//   const TranslatorApp({super.key});

//   @override
//   State<TranslatorApp> createState() => _TranslatorAppState();
// }

// class _TranslatorAppState extends State<TranslatorApp> {
//   final List<String> languages = ['English', 'Arabic'];
//   final List<String> languageCodes = ['en', 'ar'];
//   final GoogleTranslator translator = GoogleTranslator();
//   final TranslationRepository translationRepository = TranslationRepository();
//   final FlutterTts flutterTts = FlutterTts();
//   void resetFilled() {
//     setState(() {
//       translatedText = '';
//       controller.clear();
//     });
//   }

//   @override
//   void initState() {
//     resetFilled();
//     // TODO: implement initState
//     super.initState();
//   }

//   String from = 'en';
//   String to = 'ar';
//   String translatedText = '';
//   String selectedValueFrom = 'English';
//   String selectedValueTo = 'Arabic';
//   TextEditingController controller = TextEditingController();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   bool isLoading = false;

//   Future<void> translate() async {
//     if (formKey.currentState!.validate()) {
//       try {
//         final translation =
//             await translator.translate(controller.text, from: from, to: to);
//         translatedText = translation.text;
//         await translationRepository.saveTranslation(translatedText);
//         await _speak(translatedText);
//         setState(() {
//           isLoading = false;
//         });
//       } on SocketException catch (_) {
//         _showErrorSnackbar('Internet not connected');
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   Future<void> _speak(String text) async {
//     await flutterTts.setLanguage(to);
//     await flutterTts.speak(text);
//   }

//   void _showErrorSnackbar(String message) {
//     final snackbar = SnackBar(
//       content: Text(message),
//       backgroundColor: Colors.red,
//       duration: Duration(seconds: 5),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackbar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Translator App',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.list),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => NoteTranslationPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       backgroundColor: const Color.fromARGB(255, 87, 104, 254),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 30),
//             _buildDropdownButton('From', languages, selectedValueFrom,
//                 (String? value) {
//               setState(() {
//                 selectedValueFrom = value!;
//                 from = languageCodes[languages.indexOf(value)];
//                 translatedText = '';
//                 controller.clear();
//               });
//             }),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 key: formKey,
//                 child: TextFormField(
//                   controller: controller,
//                   maxLines: null,
//                   minLines: null,
//                   validator: (value) =>
//                       value!.isEmpty ? 'Please enter some text' : null,
//                   decoration: const InputDecoration(
//                     enabledBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     errorStyle: TextStyle(color: Colors.white),
//                   ),
//                   style: const TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18),
//                 ),
//               ),
//             ),
//             _buildDropdownButton('To', languages, selectedValueTo,
//                 (String? value) {
//               setState(() {
//                 selectedValueTo = value!;
//                 to = languageCodes[languages.indexOf(value)];
//                 translatedText = '';
//                 controller.clear();
//               });
//             }),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Center(
//                 child: SelectableText(
//                   translatedText,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Future.delayed(const Duration(seconds: 4)).then((val) {
//                   resetFilled();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => NoteTranslationPage()),
//                   );
//                 });
//                 isLoading ? null : translate();
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStatePropertyAll(Colors.indigo.shade900),
//                 fixedSize: const MaterialStatePropertyAll(Size(300, 45)),
//               ),
//               child: isLoading
//                   ? const SizedBox.square(
//                       dimension: 20,
//                       child: CircularProgressIndicator(color: Colors.white),
//                     )
//                   : const Text('Translate'),
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 resetFilled();
//               },
//               style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStatePropertyAll(Colors.amber.shade100),
//                 fixedSize: const MaterialStatePropertyAll(Size(300, 45)),
//               ),
//               child: isLoading
//                   ? const SizedBox.square(
//                       dimension: 25,
//                       child: CircularProgressIndicator(color: Colors.white),
//                     )
//                   : const Text('Resset'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdownButton(String label, List<String> items,
//       String selectedValue, ValueChanged<String?> onChanged) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 40),
//       decoration: BoxDecoration(
//           color: Colors.indigo.shade100,
//           borderRadius: BorderRadius.circular(10)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(label),
//           const SizedBox(width: 100),
//           DropdownButton<String>(
//             value: selectedValue,
//             focusColor: Colors.transparent,
//             items: items.map((lang) {
//               return DropdownMenuItem(
//                 value: lang,
//                 child: Text(lang),
//               );
//             }).toList(),
//             onChanged: (value) {
//               controller.clear();
//               translatedText = '';
//               setState(() {
//                 selectedValueFrom = value.toString();
//                 from = value == 'English' ? 'en' : 'ar';
//                 // Automatically switch "To" language
//                 selectedValueTo = value == 'English' ? 'Arabic' : 'English';
//                 to = value == 'English' ? 'ar' : 'en';
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'providers/words_provider.dart';
// import 'presentation/translator_page.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => WordsProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Translator App',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//       ),
//       home: TranslatorPage(),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:translation_app/presentation/translator_page.dart';
// import 'providers/words_provider.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => WordsProvider(),
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Translator App',
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//         ),
//         home: TranslatorPage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/presentation/translator_page.dart';
import 'providers/words_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WordsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: TranslatorPage(),
    );
  }
}
