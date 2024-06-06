import 'package:flutter/material.dart';

class TranslationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const TranslationButton({
    required this.onPressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(color),
        fixedSize: const MaterialStatePropertyAll(Size(300, 45)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
