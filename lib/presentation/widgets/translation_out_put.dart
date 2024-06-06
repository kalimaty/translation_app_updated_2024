import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/words_provider.dart';

class TranslationOutput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordsProvider = Provider.of<WordsProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 50, 46, 165),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
      ),
      child: Center(
        child: SelectableText(
          wordsProvider.translation,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
