import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:translation_app/providers/words_provider.dart';

class NoteTranslationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordsProvider = Provider.of<WordsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Translations'),
      ),
      body: ListView.builder(
        itemCount: wordsProvider.translations.length,
        itemBuilder: (context, index) {
          final translation = wordsProvider.translations[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              margin: EdgeInsets.all(5),
              color: Color.fromARGB(255, 20, 180, 250),
              child: ListTile(
                title: Text(
                  'Original: ${translation['input']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Translation: ${translation['output']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer<WordsProvider>(
                      builder: (context, ttsProvider, _) {
                        return IconButton(
                          onPressed: () {
                            ttsProvider.speak(translation['output']!);
                          },
                          icon: Icon(
                            size: 50,
                            color: Colors.white,
                            ttsProvider.isPlaying(translation['output']!)
                                ? Icons.pause
                                : IconlyLight.play,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        wordsProvider.deleteWord(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
