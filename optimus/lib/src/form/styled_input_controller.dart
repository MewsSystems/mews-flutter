import 'package:flutter/widgets.dart';

/// Controller for highlighting the user input inside the
/// text input field.
class StyledInputController extends TextEditingController {
  StyledInputController({
    required String text,
    required TextStyle inputStyle,
    required TextStyle placeholderStyle,
  }) : _inputStyle = inputStyle,
       _placeholderStyle = placeholderStyle,
       super.fromValue(
         // workaround for the issue with the cursor position on Android
         TextEditingValue(
           text: text,
           selection: TextSelection.collapsed(offset: text.length),
         ),
       );

  TextStyle _inputStyle;
  TextStyle _placeholderStyle;

  set inputStyle(TextStyle value) {
    if (value == _inputStyle) return;

    _inputStyle = value;
    notifyListeners();
  }

  set placeholderStyle(TextStyle value) {
    if (value == _placeholderStyle) return;

    _placeholderStyle = value;
    notifyListeners();
  }

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
        children.add(TextSpan(style: _inputStyle, text: textParts[i]));
      } else if (_maskRegExp.hasMatch(textParts[i])) {
        children.add(TextSpan(style: _placeholderStyle, text: textParts[i]));
      } else {
        final style = children.isEmpty
            ? _placeholderStyle
            : children.last.style;
        children.add(TextSpan(style: style, text: textParts[i]));
      }
    }

    return TextSpan(children: children.reversed.toList(), style: style);
  }

  bool get isInputComplete => !_maskRegExp.hasMatch(text);
}

final RegExp _maskRegExp = RegExp('[a-zA-z]');
final RegExp _allowedDigits = RegExp('[0-9]');
