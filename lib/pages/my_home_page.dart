import 'package:flutter/material.dart';
import 'package:mobile_translation_app/text_field_item_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TextFieldItemView(language: Language.english),
            IconButton(
              onPressed: () {},
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
            const TextFieldItemView(language: Language.japanese),
          ],
        ),
      ),
    );
  }
}
