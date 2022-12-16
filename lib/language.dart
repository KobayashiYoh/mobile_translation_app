import 'package:flutter/cupertino.dart';

enum Language {
  english,
  japanese,
}

extension LanguageExtension on Language {
  // 画面に表示するテキスト
  String get viewText {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.japanese:
        return '日本語';
    }
  }

  // translatorで翻訳言語を指定するラベル
  String get translatorLabel {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.japanese:
        return 'ja';
    }
  }

  // flutter_ttsで言語を指定するラベル
  String get speakingLabel {
    switch (this) {
      case Language.english:
        return 'en-US';
      case Language.japanese:
        return 'ja-JP';
    }
  }

  // 言語によってキーボードの種類を変える
  TextInputType get textInputType {
    switch (this) {
      case Language.japanese:
        return TextInputType.text;
      default:
        return TextInputType.emailAddress;
    }
  }
}
