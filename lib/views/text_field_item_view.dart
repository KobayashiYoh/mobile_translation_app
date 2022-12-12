import 'package:flutter/material.dart';
import 'package:mobile_translation_app/models/language.dart';

class TextFieldItemView extends StatelessWidget {
  const TextFieldItemView({
    Key? key,
    required this.translate,
    required this.onPressedSuffixButton,
    required this.onPressedPlayButton,
    required this.onPressedCopyButton,
    required this.textEditingController,
    required this.language,
  }) : super(key: key);
  final void Function(String)? translate;
  final void Function()? onPressedSuffixButton;
  final void Function()? onPressedCopyButton;
  final void Function()? onPressedPlayButton;
  final TextEditingController textEditingController;
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
            height: 20.0,
            child: Text(language.text),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  keyboardType: language.textInputType,
                  minLines: 1,
                  maxLines: 10,
                  onChanged: translate,
                  onSubmitted: translate,
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
                onPressed: onPressedCopyButton,
                icon: const Icon(
                  Icons.copy_outlined,
                ),
              ),
              IconButton(
                onPressed: onPressedPlayButton,
                icon: const Icon(
                  Icons.play_circle_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
