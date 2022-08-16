import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/form_style.dart';

/// A [FormField] meant to be used for the user to enter a date.
///
/// The date format is determined by the placeholder parameter and will default
/// to [OptimusDateInputFormat.ddmmyyyy]. The input is limited to digits only.
/// If [keyboardType] value is not provided, the keyboard will be set to
/// [TextInputType.number].
class OptimusDateInputFormField extends StatefulWidget {
  const OptimusDateInputFormField({
    Key? key,
    required this.onSubmitted,
    this.label,
    this.error,
    this.caption,
    this.secondaryCaption,
    this.keyboardType,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.format = OptimusDateInputFormat.ddmmyyyy,
    this.isClearEnabled = false,
  }) : super(key: key);

  /// Format of the date. It will define the placeholder and the separator.
  final OptimusDateInputFormat format;

  final ValueChanged<DateTime?> onSubmitted;

  final String? label;
  final String? error;
  final Widget? caption;
  final Widget? secondaryCaption;
  final TextInputType? keyboardType;
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
      pattern: widget.format.allowed,
    );
  }

  DateTime? _getDateTime(String value) {
    widget.onSubmitted.call(widget.format.toDateTime(value));
  }

  @override
  Widget build(BuildContext context) => FormField(
        enabled: widget.isEnabled,
        builder: (FormFieldState<DateTime?> field) => OptimusInputField(
          label: widget.label,
          caption: widget.caption,
          isEnabled: widget.isEnabled,
          isClearEnabled: widget.isClearEnabled,
          secondaryCaption: widget.secondaryCaption,
          placeholder: widget.format.placeholder,
          controller: _controller,
          error: widget.error,
          onSubmitted: _getDateTime,
          keyboardType: widget.keyboardType ?? TextInputType.number,
          inputFormatters: [
            _DateFormatter(format: widget.format),
          ],
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

enum OptimusDateInputFormat { ddmmyyyy, mmddyyyy }

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
  _DateFormatter({required this.format});

  final OptimusDateInputFormat format;

  String get placeholder => format.placeholder;

  String get separator => format.separator;

  bool _isValidInput(String value) => value.isDigit;

  bool _isComplete(String value) =>
      _getCleanInput(value).length ==
      placeholder.replaceAll(separator, '').length;

  String _getCleanInput(String value) =>
      value.replaceAll(format.restricted, '');

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

extension on OptimusDateInputFormat {
  String get placeholder {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return 'DD/MM/YYYY';
      case OptimusDateInputFormat.mmddyyyy:
        return 'MM/DD/YYYY';
    }
  }

  String get separator {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return '/';
      case OptimusDateInputFormat.mmddyyyy:
        return '/';
    }
  }

  int get monthPosition {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return 1;
      case OptimusDateInputFormat.mmddyyyy:
        return 0;
    }
  }

  int get dayPosition {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return 0;
      case OptimusDateInputFormat.mmddyyyy:
        return 1;
    }
  }

  int get yearPosition {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return 2;
      case OptimusDateInputFormat.mmddyyyy:
        return 2;
    }
  }

  RegExp get allowed {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return RegExp('[0-9]');
      case OptimusDateInputFormat.mmddyyyy:
        return RegExp('[0-9]');
    }
  }

  RegExp get restricted {
    switch (this) {
      case OptimusDateInputFormat.ddmmyyyy:
        return RegExp('[^0-9]');
      case OptimusDateInputFormat.mmddyyyy:
        return RegExp('[^0-9]');
    }
  }

  int getMonth(String value) => int.parse(value.split('/')[monthPosition]);

  int getDay(String value) => int.parse(value.split('/')[dayPosition]);

  int getYear(String value) => int.parse(value.split('/')[yearPosition]);

  DateTime? toDateTime(String value) {
    if (value.isEmpty) return null;

    return DateTime(getYear(value), getMonth(value), getDay(value));
  }
}
