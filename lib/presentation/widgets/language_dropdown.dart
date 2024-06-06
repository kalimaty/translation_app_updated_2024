import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/words_provider.dart';

class LanguageSelector extends StatelessWidget {
  final String title;
  final String value;
  final void Function(String lang, String code) onChanged;

  const LanguageSelector({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final wordsProvider = Provider.of<WordsProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 20, 180, 250),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          const SizedBox(width: 100),
          DropdownButton(
            value: value,
            focusColor: Colors.transparent,
            items: [
              DropdownMenuItem(
                value: 'English',
                child: const Text('English'),
                // onTap: () => onChanged('English', 'en'),
              ),
              DropdownMenuItem(
                value: 'Arabic',
                child: const Text('Arabic'),
                // onTap: () => onChanged('Arabic', 'ar'),
              ),
            ],
            onChanged: (value) {
              wordsProvider.switchLanguages();
              wordsProvider.resetFields();
            },
          ),
        ],
      ),
    );
  }
}

// class LanguageDropdown extends StatelessWidget {
//   final String label;
//   final List<String> languages;
//   final String selectedValue;
//   final bool isFromLanguage;

//   const LanguageDropdown({
//     required this.label,
//     required this.languages,
//     required this.selectedValue,
//     required this.isFromLanguage,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//             items: languages.map((lang) {
//               return DropdownMenuItem(
//                 value: lang,
//                 child: Text(lang),
//               );
//             }).toList(),
//             onChanged: (value) {
//               final provider =
//                   Provider.of<WordsProvider>(context, listen: false);
//               if (isFromLanguage) {
//                 provider.setFromLanguage(
//                     value!, languages[languages.indexOf(value)]);
//               } else {
//                 provider.setToLanguage(
//                     value!, languages[languages.indexOf(value)]);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
