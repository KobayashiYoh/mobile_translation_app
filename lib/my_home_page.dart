import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_translation_app/language.dart';
import 'package:mobile_translation_app/text_field_item_view.dart';
import 'package:translator/translator.dart';

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

  void _translate({
    required String sourceText, // TextFieldに入力されたテキスト
    required String to, // 翻訳後の言語を指定（英語: en, 日本語: ja）
    required bool isTopField, // 上側のTextFieldか下側のTextFieldか判別
  }) async {
    if (sourceText.isEmpty) {
      return;
    }
    final translator = GoogleTranslator();
    // sourceTextを言語toに翻訳
    final translation = await translator.translate(
      sourceText,
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

  void _speak({required String language, required String speakText}) async {
    if (speakText.isEmpty) {
      return;
    }
    FlutterTts flutterTts = FlutterTts();
    // 読み上げる言語を設定（英語: en-US, 日本語: ja-JP）
    await flutterTts.setLanguage(language);
    // 読み上げる速度を設定（0.0〜1.0）
    await flutterTts.setSpeechRate(1.5);
    // speakTextを読み上げ
    await flutterTts.speak(speakText);
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
                translate: (value) => _translate(
                  sourceText: value,
                  to: _bottomLanguage.translatorLabel,
                  isTopField: true,
                ),
                onPressedSuffixButton: _resetTextField,
                onPressedCopyButton: () => _copyClipBoard(_topController),
                onPressedPlayButton: () => _speak(
                  language: _topLanguage.speakingLabel,
                  speakText: _topController.text,
                ),
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
                translate: (value) => _translate(
                  sourceText: value,
                  to: _topLanguage.translatorLabel,
                  isTopField: false,
                ),
                onPressedSuffixButton: _resetTextField,
                onPressedCopyButton: () => _copyClipBoard(_bottomController),
                onPressedPlayButton: () => _speak(
                  language: _bottomLanguage.speakingLabel,
                  speakText: _bottomController.text,
                ),
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
