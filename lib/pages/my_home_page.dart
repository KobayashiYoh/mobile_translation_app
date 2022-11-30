import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mobile_translation_app/models/language.dart';
import 'package:mobile_translation_app/views/text_field_item_view.dart';
import 'package:translator/translator.dart';

enum TextFieldPosition {
  top,
  bottom,
}

extension TextFieldPositionExtension on TextFieldPosition {
  bool get isTop => this == TextFieldPosition.top;
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

  void _translate(String inputText, TextFieldPosition position) async {
    if (inputText.isEmpty) {
      return;
    }
    final translator = GoogleTranslator();
    final String from = position.isTop
        ? _bottomLanguage.translatorLabel
        : _topLanguage.translatorLabel;
    final String to = position.isTop
        ? _bottomLanguage.translatorLabel
        : _topLanguage.translatorLabel;
    final translation = await translator.translate(
      inputText,
      from: from,
      to: to,
    );
    if (position.isTop) {
      _topController.text = translation.text;
    } else {
      _bottomController.text = translation.text;
    }
    setState(() {});
  }

  void _resetTextField() {
    setState(() {
      _topController = TextEditingController();
      _bottomController = TextEditingController();
    });
  }

  void _speak(TextFieldPosition position) async {
    FlutterTts flutterTts = FlutterTts();
    final language =
        position == TextFieldPosition.top ? _topLanguage : _bottomLanguage;
    final controller =
        position == TextFieldPosition.top ? _topController : _bottomController;
    await flutterTts.setLanguage(language.speakingLabel);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextFieldItemView(
                onChanged: (value) => _translate(
                  value,
                  TextFieldPosition.top,
                ),
                onPressedSuffixButton: _resetTextField,
                onPressedPlayButton: () => _speak(TextFieldPosition.top),
                textEditingController: _topController,
                language: _topLanguage,
              ),
              IconButton(
                onPressed: _onPressedSwapTextFieldButton,
                icon: const RotatedBox(
                  quarterTurns: 1,
                  child: SizedBox(
                    height: 32.0,
                    child: Icon(
                      Icons.compare_arrows_outlined,
                    ),
                  ),
                ),
              ),
              TextFieldItemView(
                onChanged: (value) => _translate(
                  value,
                  TextFieldPosition.bottom,
                ),
                onPressedSuffixButton: _resetTextField,
                onPressedPlayButton: () => _speak(TextFieldPosition.bottom),
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
