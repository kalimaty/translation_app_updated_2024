import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/presentation/note_translation_page.dart';
import '../providers/words_provider.dart';
import 'widgets/language_dropdown.dart';
import 'widgets/translation_button.dart';
import 'widgets/translation_out_put.dart';
import 'widgets/translation_text_field.dart';

class TranslatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordsProvider = Provider.of<WordsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteTranslationPage(),
                ),
              ).then((_) {
                wordsProvider.resetFields();
                wordsProvider.stopCurrentPlaying();
              });
            },
            icon: Icon(
              Icons.list,
              color: Colors.white,
            )),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 20, 180, 250),
          ),
        ),
        title: const Text(
          'Translator App',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            LanguageSelector(
              title: 'From',
              value: wordsProvider.fromLanguageDisplay,
              onChanged: (lang, code) {
                wordsProvider.setFromLanguage(code, lang);
              },
            ),
            TextInputField(),
            LanguageSelector(
              title: 'To',
              value: wordsProvider.toLanguageDisplay,
              onChanged: (lang, code) {
                wordsProvider.setToLanguage(code, lang);
              },
            ),
            TranslationOutput(),
            TranslationButton(
              onPressed: () {
                wordsProvider.translate(context);
              },
              text: 'Translate',
              color: Colors.indigo.shade900,
            ),
            const SizedBox(height: 20),
            TranslationButton(
              onPressed: wordsProvider.resetFields,
              text: 'Clear Fields',
              color: Colors.red.shade900,
            ),
            const SizedBox(height: 20),
            TranslationButton(
              onPressed: () {
                wordsProvider.switchLanguages();
              },
              text: 'Switch Languages',
              color: Colors.blue.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
