import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  TextInputType get textInputType {
    switch (this) {
      case Language.japanese:
        return TextInputType.text;
      default:
        return TextInputType.emailAddress;
    }
  }
}

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView({
    Key? key,
    required this.onPressedSuffixButton,
    required this.textEditingController,
    required this.language,
  }) : super(key: key);
  final void Function()? onPressedSuffixButton;
  final TextEditingController textEditingController;
  final Language language;

  void _copyClipBoard() {
    Clipboard.setData(
      ClipboardData(
        text: textEditingController.text,
      ),
    );
  }

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
            height: 20.0,
            child: Text(language.languageLabel),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  keyboardType: language.textInputType,
                  onChanged: (value) {
                    // TODO: 翻訳機能の実装
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: onPressedSuffixButton,
                      iconSize: 20.0,
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _copyClipBoard,
                icon: const Icon(
                  Icons.copy_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
