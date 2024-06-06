import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/words_provider.dart';

class TranslationResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WordsProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SelectableText(
          provider.translation,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
