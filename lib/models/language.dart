import 'package:flutter/material.dart';

enum Language {
  english,
  japanese,
}

extension LanguageExtension on Language {
  String get text {
    switch (this) {
      case Language.english:
        return 'English';
      case Language.japanese:
        return '日本語';
    }
  }

  String get translatorLabel {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.japanese:
        return 'ja';
    }
  }

  String get speakingLabel {
    switch (this) {
      case Language.english:
        return 'en-US';
      case Language.japanese:
        return 'ja-JP';
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
