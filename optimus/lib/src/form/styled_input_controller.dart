import 'package:flutter/widgets.dart';

/// Controller for highlighting the user input inside the
/// text input field.
class StyledInputController extends TextEditingController {
  StyledInputController({
    required String text,
    required this.inputStyle,
    required this.placeholderStyle,
  }) : super.fromValue(
          // workaround for the issue with the cursor position on Android
          TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          ),
        );

  /// The style to use for the user entered part.
  final TextStyle inputStyle;

  /// The style to use for the rest.
  final TextStyle placeholderStyle;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    final textParts = text.split('');

    for (int i = textParts.length - 1; i >= 0; i--) {
      if (_allowedDigits.hasMatch(textParts[i])) {
        children.add(TextSpan(style: inputStyle, text: textParts[i]));
      } else if (_maskRegExp.hasMatch(textParts[i])) {
        children.add(TextSpan(style: placeholderStyle, text: textParts[i]));
      } else {
        final style = children.isEmpty ? placeholderStyle : children.last.style;
        children.add(TextSpan(style: style, text: textParts[i]));
      }
    }

    return TextSpan(children: children.reversed.toList(), style: style);
  }

  bool get isInputComplete => !_maskRegExp.hasMatch(text);
}

final RegExp _maskRegExp = RegExp('[a-zA-z]');
final RegExp _allowedDigits = RegExp('[0-9]');
