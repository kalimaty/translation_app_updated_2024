import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/words_provider.dart';

class TextInputField extends StatelessWidget {
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
      child: Form(
        key: wordsProvider.formKeyGlobal,
        child: TextFormField(
          controller: wordsProvider.textController,
          maxLines: null,
          minLines: null,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            errorStyle: TextStyle(color: Colors.white),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}





// class TranslationTextField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<WordsProvider>(context);
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Form(
//         key: provider.formKeyGlobal,
//         child: TextFormField(
//           controller: provider.textController,
//           maxLines: null,
//           minLines: null,
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter some text' : null,
//           decoration: const InputDecoration(
//             enabledBorder: InputBorder.none,
//             border: InputBorder.none,
//             errorBorder: InputBorder.none,
//             errorStyle: TextStyle(color: Colors.white),
//           ),
//           style: const TextStyle(
//               color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
