import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_translation_app/views/text_field_item_view.dart';
import 'package:translator/translator.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _topController = TextEditingController();
  TextEditingController _bottomController = TextEditingController();
  Language _topLanguage = Language.english;
  Language _bottomLanguage = Language.japanese;

  void _onPressedSwapTextFieldButton() {
    final String topText = _topController.text;
    final String bottomText = _bottomController.text;
    _topController.text = bottomText;
    _bottomController.text = topText;
    final topLanguage = _topLanguage;
    final bottomLanguage = _bottomLanguage;
    _topLanguage = bottomLanguage;
    _bottomLanguage = topLanguage;
    setState(() {});
  }

  // 翻訳を行うメソッド
  // 引数isTopFieldで上側のTextFieldか下側のTextFieldか判別
  void _translate(String inputText, {required bool isTopField}) async {
    if (inputText.isEmpty) {
      return;
    }
    final translator = GoogleTranslator();
    // 翻訳後の言語を指定
    final String to = isTopField
        ? _bottomLanguage.translatorLabel
        : _topLanguage.translatorLabel;
    // 入力されたテキストinputTextを言語toに翻訳
    final translation = await translator.translate(
      inputText,
      to: to,
    );
    // 翻訳結果をUIに反映
    if (isTopField) {
      _bottomController.text = translation.text;
    } else {
      _topController.text = translation.text;
    }
    setState(() {});
  }

  void _resetTextField() {
    setState(() {
      _topController = TextEditingController();
      _bottomController = TextEditingController();
    });
  }

  void _copyClipBoard(TextEditingController controller) {
    if (controller.text.isEmpty) {
      return;
    }
    // textをクリップボードにコピー
    Clipboard.setData(
      ClipboardData(
        text: controller.text,
      ),
    );
    // トーストを表示
    Fluttertoast.showToast(msg: 'コピーしました');
  }

  void _speak({required bool isTopField}) async {
    final language = isTopField ? _topLanguage : _bottomLanguage;
    final controller = isTopField ? _topController : _bottomController;
    if (controller.text.isEmpty) {
      return;
    }
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage(language.speakingLabel);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ListView(
            children: [
              const SizedBox(height: 16.0),
              TextFieldItemView(
                translate: (value) => _translate(value, isTopField: true),
                onPressedSuffixButton: _resetTextField,
                onPressedCopyButton: () => _copyClipBoard(_topController),
                onPressedPlayButton: () => _speak(isTopField: true),
                textEditingController: _topController,
                language: _topLanguage,
              ),
              GestureDetector(
                onTap: _onPressedSwapTextFieldButton,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const RotatedBox(
                    quarterTurns: 1,
                    child: SizedBox(
                      height: 32.0,
                      child: Icon(
                        Icons.compare_arrows_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              TextFieldItemView(
                translate: (value) => _translate(value, isTopField: false),
                onPressedSuffixButton: _resetTextField,
                onPressedCopyButton: () => _copyClipBoard(_bottomController),
                onPressedPlayButton: () => _speak(isTopField: false),
                textEditingController: _bottomController,
                language: _bottomLanguage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
