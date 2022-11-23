import 'package:flutter/material.dart';
import 'package:mobile_translation_app/text_field_item_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _enableEditingController = TextEditingController();
  TextEditingController _disableEditingController = TextEditingController();
  Language _enableLanguage = Language.english;
  Language _disableLanguage = Language.japanese;

  void _onPressedSwapTextFieldButton() {
    final String enableEditingControllerText = _enableEditingController.text;
    final String disableEditingControllerText = _disableEditingController.text;
    _enableEditingController = TextEditingController(
      text: disableEditingControllerText,
    );
    _disableEditingController = TextEditingController(
      text: enableEditingControllerText,
    );
    final enableLanguage = _enableLanguage;
    final disableLanguage = _disableLanguage;
    _enableLanguage = disableLanguage;
    _disableLanguage = enableLanguage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFieldItemView(
              textEditingController: _disableEditingController,
              language: _disableLanguage,
              enable: false,
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
              textEditingController: _enableEditingController,
              language: _enableLanguage,
              enable: true,
            ),
          ],
        ),
      ),
    );
  }
}
