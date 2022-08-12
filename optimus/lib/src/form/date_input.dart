import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/form_style.dart';

/// A [FormField] meant to be used for the user to enter a date.
///
/// The date format is determined by the placeholder parameter and will default
/// to DD/MM/YYYY and '/' as a separator.
class OptimusDateInputFormField extends StatefulWidget {
  const OptimusDateInputFormField({
    Key? key,
    required this.onSaved,
    required this.validator,
    this.onSubmitted,
    this.label,
    this.error,
    this.caption,
    this.secondaryCaption,
    this.keyboardType,
    this.autovalidateMode,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.placeholder = 'DD/MM/YYYY',
    this.separator = '/',
    this.isClearEnabled = false,
  }) : super(key: key);

  /// Placeholder text for the date input.
  ///
  /// It will be displayed as a hint, until the whole date is entered.
  final String placeholder;

  /// Separator between the date parts.
  final String separator;

  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onSubmitted;

  final String? label;
  final String? error;
  final Widget? caption;
  final Widget? secondaryCaption;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final bool isEnabled;
  final bool isClearEnabled;
  final OptimusWidgetSize size;

  @override
  State<OptimusDateInputFormField> createState() =>
      _OptimusDateInputFormFieldState();
}

class _OptimusDateInputFormFieldState extends State<OptimusDateInputFormField>
    with ThemeGetter {
  late final _StyledPatternController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = _StyledPatternController(
      defaultStyle: getPlaceholderTextStyle(theme, widget.size),
      matchStyle: getTextStyle(theme, widget.size),
      pattern: RegExp('[0-9]'),
    );
  }

  @override
  Widget build(BuildContext context) => FormField(
        onSaved: widget.onSaved,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        enabled: widget.isEnabled,
        builder: (FormFieldState<String> field) => OptimusInputField(
          label: widget.label,
          caption: widget.caption,
          isEnabled: widget.isEnabled,
          isClearEnabled: widget.isClearEnabled,
          secondaryCaption: widget.secondaryCaption,
          placeholder: widget.placeholder,
          controller: _controller,
          error: widget.error,
          onSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType ?? TextInputType.number,
          inputFormatters: [
            _DateFormatter(
              placeholder: widget.placeholder,
              separator: widget.separator,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _StyledPatternController extends TextEditingController {
  _StyledPatternController({
    String? text,
    required this.pattern,
    required this.matchStyle,
    required this.defaultStyle,
  }) : super(text: text);

  final RegExp pattern;
  final TextStyle matchStyle;
  final TextStyle defaultStyle;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];

    text.splitMapJoin(
      pattern,
      onMatch: (Match m) {
        children.add(
          TextSpan(
            style: matchStyle,
            text: m[0],
          ),
        );

        return m[0] ?? '';
      },
      onNonMatch: (String value) {
        children.add(
          TextSpan(
            style: defaultStyle,
            text: value,
          ),
        );

        return value;
      },
    );

    return TextSpan(children: children, style: style);
  }
}

class _DateFormatter extends TextInputFormatter {
  _DateFormatter({
    required this.placeholder,
    required this.separator,
  });

  final String placeholder;
  final String separator;

  bool _isValidInput(String value) => value.isDigit;

  bool _isComplete(String value) =>
      _getCleanInput(value).length ==
      placeholder.replaceAll(separator, '').length;

  String _getCleanInput(String value) => value.replaceAll(RegExp('[^0-9]'), '');

  String _replaceCharAt(String value, int index, String replacement) =>
      value.substring(0, index) +
      replacement +
      (index == value.length - replacement.length
          ? ''
          : value.substring(index + replacement.length));

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldClean = _getCleanInput(oldValue.text);
    final newClean = _getCleanInput(newValue.text);

    if (oldValue.text.isEmpty && _isValidInput(newValue.text[0])) {
      return TextEditingValue(
        text: _replaceCharAt(
          placeholder,
          0,
          newValue.text[0],
        ),
        selection: newValue.selection,
      );
    }

    if (newClean.length > oldClean.length) {
      if (_isComplete(oldValue.text) ||
          newValue.selection.start >= newValue.text.length ||
          newValue.text[newValue.selection.start] == separator ||
          _isValidInput(newValue.text[newValue.selection.start]) ||
          !_isValidInput(newValue.text[newValue.selection.start - 1])) {
        return oldValue;
      }

      final offset = newValue.selection.start + 1 < newValue.text.length &&
              newValue.text[newValue.selection.start + 1] == separator
          ? newValue.selection.start + 1
          : newValue.selection.start;

      return TextEditingValue(
        text: _replaceCharAt(
          oldValue.text,
          oldValue.selection.start,
          newValue.text[oldValue.selection.start],
        ),
        selection: TextSelection.collapsed(offset: offset),
      );
    } else if (newClean.length < oldClean.length) {
      if (_isValidInput(oldValue.text[newValue.selection.start])) {
        final start = oldValue.selection.start == oldValue.selection.end
            ? newValue.selection.start
            : oldValue.selection.start;
        final end = oldValue.selection.start == oldValue.selection.end
            ? newValue.selection.start + 1
            : oldValue.selection.end;

        return TextEditingValue(
          text: _replaceCharAt(
            oldValue.text,
            newValue.selection.start,
            placeholder.substring(
              start,
              end,
            ),
          ),
          selection: TextSelection.collapsed(offset: newValue.selection.start),
        );
      } else {
        return oldValue;
      }
    } else {
      return newValue.text.length > oldValue.text.length
          ? oldValue
          : TextEditingValue(
              text: oldValue.text,
              selection: newValue.selection,
            );
    }
  }
}

extension on String {
  bool get isDigit => int.tryParse(this) != null;
}
