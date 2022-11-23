import 'package:flutter/material.dart';

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          const Expanded(
            child: TextField(),
          ),
          IconButton(
            onPressed: () {
              // TODO: 音声読み上げ機能を実装
            },
            icon: const Icon(
              Icons.headphones_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: 音声入力機能を実装
            },
            icon: const Icon(
              Icons.mic_none,
            ),
          ),
        ],
      ),
    );
  }
}
