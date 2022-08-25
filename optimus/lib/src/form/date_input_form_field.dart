import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/date_formatter.dart';
import 'package:optimus/src/form/form_style.dart';

typedef _SymbolConverter = String Function(_SupportedSymbol symbol);

/// A [FormField] meant to be used for the user to enter a date.
///
/// The input is defined by the mask. If no [customFormat] is provided, the mask
/// and placeholder will be generated from the [format].
class OptimusDateInputFormField extends StatefulWidget {
  const OptimusDateInputFormField({
    Key? key,
    required this.onSubmitted,
    required this.format,
    this.label,
    this.error,
    this.caption,
    this.secondaryCaption,
    this.keyboardType,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.customFormat,
    this.initialValue,
    this.isClearEnabled = false,
    this.allowedDigits,
    this.allowedLetters,
  }) : super(key: key);

  /// Format of the date. It will define the placeholder and the separator.
  final DateFormat format;

  /// Function to be called when the user submits the form.
  final ValueChanged<DateTime?> onSubmitted;

  /// The custom format for the output. See [OptimusCustomFormat] for more
  /// details.
  ///
  /// If [customFormat] is not provided, the visual representation of the date
  /// will be generated from the [format].
  final OptimusCustomFormat? customFormat;

  /// The keyboard type for the input. If not provided, the keyboard will be set
  /// to [TextInputType.number].
  final TextInputType? keyboardType;

  /// The initial value of the input.
  final DateTime? initialValue;

  /// The widget size. By default [OptimusWidgetSize.large].
  final OptimusWidgetSize size;

  /// The [RegExp] for the digits. Will define allowed characters for the places
  /// with '#' symbol. By default will be set to [RegExp(r'[0-9]')].
  final RegExp? allowedDigits;

  /// The [RegExp] for the letters. Will define allowed characters for the
  /// places with 'A' symbol. By default will be set to [RegExp(r'[A-Za-z]')].
  final RegExp? allowedLetters;

  final String? label;
  final String? error;
  final Widget? caption;
  final Widget? secondaryCaption;
  final bool isEnabled;
  final bool isClearEnabled;

  @override
  State<OptimusDateInputFormField> createState() =>
      _OptimusDateInputFormFieldState();
}

class _OptimusDateInputFormFieldState extends State<OptimusDateInputFormField>
    with ThemeGetter {
  late _StyledInputController _styleController;
  final List<int> _userInput = <int>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.initialValue != null) {
      _userInput.clear();
      for (int i = 0; i < _placeholder.length; i++) {
        _userInput.add(i);
      }
    }

    _styleController = _StyledInputController(
      text: _initialText,
      defaultStyle: getPlaceholderTextStyle(theme, widget.size),
      matchStyle: getTextStyle(theme, widget.size),
      userInput: _userInput,
    );
  }

  @override
  void didUpdateWidget(covariant OptimusDateInputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.format.pattern != widget.format.pattern ||
        oldWidget.format.locale != widget.format.locale) {
      final inputDate = _getDateTime(oldWidget.format, _styleController.text);
      _userInput.clear();
      if (inputDate != null) {
        final placeholderValue = _formatOutput(inputDate);
        for (int i = 0; i < placeholderValue.length; i++) {
          _userInput.add(i);
        }
        _styleController.text = placeholderValue;
      } else {
        _styleController.text = '';
      }
    }
  }

  DateTime? _getDateTime(DateFormat format, String value) {
    if (value.isEmpty) return null;

    DateTime? result;
    try {
      result = format.parse(value);
    } on FormatException catch (_) {
      result = null;
    }

    return result;
  }

  String? get _initialText {
    final value = widget.initialValue;
    if (value != null) {
      return _formatOutput(value);
    }
  }

  String _formatOutput(DateTime value) {
    final formatted = _placeholderFormat.format(value).toString();
    final customFormat = widget.customFormat;
    final limit = customFormat != null
        ? math.min(customFormat.placeholder.length, formatted.length)
        : formatted.length;

    return formatted.substring(0, limit);
  }

  String _replaceSupported(
    String? value,
    _SymbolConverter input,
    _SymbolConverter output,
  ) {
    String result = value ?? '';
    if (value != null && value.isNotEmpty) {
      for (final _SupportedSymbol symbol in _SupportedSymbol.values) {
        final int index = result.indexOf(input(symbol));
        if (index != -1) {
          final indexEnd = result.lastIndexOf(symbol.pattern);
          result = result.replaceRange(
            index,
            indexEnd + 1 > result.length ? null : indexEnd + 1,
            output(symbol),
          );
        }
      }
    }

    return result;
  }

  /// Morph pattern to the more user-friendly format.
  ///
  /// For example, the pattern "d/M/y" will be transformed to "DD/MM/YYYY".
  String get _formattedPlaceholder => _replaceSupported(
        widget.format.pattern,
        (symbol) => symbol.pattern,
        (symbol) => symbol.placeholder,
      );

  /// Retrieve the format of the pattern that was generated for the placeholder.
  ///
  /// Fof example, the pattern "DD/MM/YYYY" will be transformed to "dd/MM/yyyy".
  DateFormat get _placeholderFormat => DateFormat(
        _replaceSupported(
          widget.format.pattern,
          (symbol) => symbol.pattern,
          (symbol) => symbol.format,
        ),
      );

  /// Create the mask from the pattern.
  ///
  /// For example "dd/MM/yyyy" will be transformed to "##/##/####".
  String get _formattedMask => _replaceSupported(
        widget.format.pattern,
        (symbol) => symbol.pattern,
        (symbol) => symbol.mask,
      );

  String get _placeholder =>
      widget.customFormat?.placeholder ?? _formattedPlaceholder;

  String get _mask => widget.customFormat?.mask ?? _formattedMask;

  @override
  Widget build(BuildContext context) => FormField<String>(
        enabled: widget.isEnabled,
        builder: (FormFieldState<String> field) => OptimusInputField(
          label: widget.label,
          caption: widget.caption,
          isEnabled: widget.isEnabled,
          isClearEnabled: widget.isClearEnabled,
          secondaryCaption: widget.secondaryCaption,
          placeholder: _placeholder,
          controller: _styleController,
          error: widget.error,
          onSubmitted: (value) =>
              widget.onSubmitted(_getDateTime(widget.format, value)),
          keyboardType: widget.keyboardType ?? TextInputType.number,
          inputFormatters: [
            DateFormatter(
              mask: _mask,
              placeholder: _placeholder,
              initValue: _initialText,
              userInput: _userInput,
            )
          ],
        ),
      );

  @override
  void dispose() {
    _styleController.dispose();
    super.dispose();
  }
}

/// The custom mask and placeholder for the input.
///
/// Mask will define where the input should be placed. Placeholder will define
/// the visual hint for the input. For the [mask] construction use '#' for
/// digits and 'A' for letters. [mask] and the [placeholder] must have the
/// same length. Number of available positions must be greater than 0.
class OptimusCustomFormat {
  OptimusCustomFormat({required this.mask, required this.placeholder})
      : assert(
          mask.length == placeholder.length,
          'Mask and placeholder must have the same length',
        ),
        assert(
          mask.contains('#') || mask.contains('A'),
          'Mask must contain either a digit or a letter position',
        );

  final String mask;
  final String placeholder;
}

/// Controller for highlighting the user input inside the
/// text input field.
class _StyledInputController extends TextEditingController {
  _StyledInputController({
    String? text,
    required this.matchStyle,
    required this.defaultStyle,
    required this.userInput,
  }) : super(text: text);

  /// The style to use for the user entered part.
  final TextStyle matchStyle;

  /// The style to use for the rest.
  final TextStyle defaultStyle;

  /// List with positions, that were filled-in by the user.
  final List<int> userInput;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final List<TextSpan> children = [];
    for (int i = 0; i < text.length; i++) {
      children.add(
        TextSpan(
          style: userInput.contains(i) ? matchStyle : defaultStyle,
          text: text[i],
        ),
      );
    }

    return TextSpan(children: children, style: style);
  }

  @override
  void clear() {
    userInput.clear();
    super.clear();
  }
}

/// Most common types are supported with this converter. For more refined access
/// use [OptimusCustomFormat].
enum _SupportedSymbol {
  day,
  month,
  year,
  hour,
  minute,
  second,
}

extension on _SupportedSymbol {
  String get pattern {
    switch (this) {
      case _SupportedSymbol.day:
        return 'd';
      case _SupportedSymbol.month:
        return 'M';
      case _SupportedSymbol.year:
        return 'y';
      case _SupportedSymbol.hour:
        return 'H';
      case _SupportedSymbol.minute:
        return 'm';
      case _SupportedSymbol.second:
        return 's';
    }
  }

  String get format {
    switch (this) {
      case _SupportedSymbol.day:
        return 'dd';
      case _SupportedSymbol.month:
        return 'MM';
      case _SupportedSymbol.year:
        return 'yyyy';
      case _SupportedSymbol.hour:
        return 'HH';
      case _SupportedSymbol.minute:
        return 'mm';
      case _SupportedSymbol.second:
        return 'ss';
    }
  }

  String get placeholder {
    switch (this) {
      case _SupportedSymbol.day:
        return 'DD';
      case _SupportedSymbol.month:
        return 'MM';
      case _SupportedSymbol.year:
        return 'YYYY';
      case _SupportedSymbol.hour:
        return 'HH';
      case _SupportedSymbol.minute:
        return 'mm';
      case _SupportedSymbol.second:
        return 'ss';
    }
  }

  String get mask {
    switch (this) {
      case _SupportedSymbol.year:
        return '####';
      case _SupportedSymbol.hour:
      case _SupportedSymbol.minute:
      case _SupportedSymbol.second:
      case _SupportedSymbol.day:
      case _SupportedSymbol.month:
        return '##';
    }
  }
}
