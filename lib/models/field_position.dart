enum FieldPosition {
  top,
  bottom,
}

extension TextFieldPositionExtension on FieldPosition {
  bool get isTop => this == FieldPosition.top;
}
