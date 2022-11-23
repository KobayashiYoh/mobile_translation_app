import 'package:flutter/material.dart';

enum Language {
  english,
  japanese,
}

extension LanguageExtension on Language {
  String get languageLabel {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.japanese:
        return '日本語';
    }
  }
}

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView({Key? key, required this.language}) : super(key: key);
  final Language language;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(language.languageLabel),
          ),
          Row(
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
        ],
      ),
    );
  }
}
