import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/date_formatter.dart';
import 'package:optimus/src/form/form_style.dart';

typedef _SymbolConverter = String Function(_SupportedSymbol symbol);

/// A [FormField] meant to be used for the user to enter a date.
///
/// The input is defined by the mask. The mask
/// and placeholder will be generated from the [format]. Input is limited to
/// digits only, which are retrieved from the [format].
class OptimusDateInputField extends StatefulWidget {
  const OptimusDateInputField({
    super.key,
    this.onSubmitted,
    required this.format,
    this.label,
    this.error,
    this.caption,
    this.secondaryCaption,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.value,
    this.isClearAllEnabled = false,
    this.onChanged,
    this.textInputAction,
    this.isRequired = false,
    this.focusNode,
    this.onTap,
  })  : customBuilder = null,
        inputStyle = null,
        placeholderStyle = null;

  /// Allows to leverage the logic of the masked input and build a custom
  /// Widget around it.
  const OptimusDateInputField.custom({
    super.key,
    this.value,
    this.onChanged,
    this.onSubmitted,
    required this.format,
    required TextStyle this.inputStyle,
    required TextStyle this.placeholderStyle,
    required OptimusHelperBuilder builder,
  })  : customBuilder = builder,
        label = null,
        error = null,
        caption = null,
        secondaryCaption = null,
        size = OptimusWidgetSize.large,
        isEnabled = true,
        isClearAllEnabled = false,
        textInputAction = null,
        isRequired = false,
        focusNode = null,
        onTap = null;

  /// Format of the date. It will define the placeholder and the separator.
  final DateFormat format;

  /// Function to be called when the user submits the form.
  final ValueChanged<DateTime?>? onSubmitted;

  /// The value of the input.
  final DateTime? value;

  /// The widget size. By default [OptimusWidgetSize.large].
  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<DateTime?>? onChanged;

  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final VoidCallback? onTap;

  final bool isRequired;
  final String? label;
  final String? error;
  final Widget? caption;
  final Widget? secondaryCaption;
  final bool isEnabled;
  final bool isClearAllEnabled;
  final OptimusHelperBuilder? customBuilder;
  final TextStyle? inputStyle;
  final TextStyle? placeholderStyle;

  @override
  State<OptimusDateInputField> createState() => _OptimusDateInputFieldState();
}

class _OptimusDateInputFieldState extends State<OptimusDateInputField>
    with ThemeGetter {
  StyledInputController? _ownController;
  String _previousValue = '';

  StyledInputController get _controller =>
      _ownController ??= StyledInputController(
        text: _formatValue(widget.value),
        inputStyle: widget.inputStyle ?? _inputStyle,
        placeholderStyle: widget.placeholderStyle ?? _placeholderStyle,
      );

  TextStyle get _placeholderStyle => theme.getPlaceholderStyle(widget.size);

  TextStyle get _inputStyle => theme.getTextInputStyle(widget.size);

  @override
  void didUpdateWidget(covariant OptimusDateInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateControllerValue(widget.value);
    } else if (oldWidget.format.pattern != widget.format.pattern ||
        oldWidget.format.locale != widget.format.locale) {
      final oldDate = _getDateTime(oldWidget.format, _controller.text);
      _updateControllerValue(oldDate);
    }
  }

  void _updateControllerValue(DateTime? newValue) {
    final formattedValue = _formatValue(newValue);
    _controller
      ..text = formattedValue
      ..selection = TextSelection.collapsed(offset: formattedValue.length);
    _previousValue = _controller.text;
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

  String _formatValue(DateTime? value) =>
      value != null ? _formatOutput(value) : '';

  String _onChanged(String value) {
    if (_previousValue != value || value.isEmpty) {
      final result = _controller.isInputComplete
          ? _getDateTime(widget.format, value)
          : null;
      widget.onChanged?.call(result);
      _previousValue = value;
    }

    return value;
  }

  String _formatOutput(DateTime value) =>
      _placeholderFormat.format(value).toString();

  void _handleSubmitted(String value) {
    final onSubmitted = widget.onSubmitted;
    if (onSubmitted != null) {
      onSubmitted.call(_getDateTime(widget.format, value));
    }
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
  String get _placeholder => _replaceSupported(
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

  @override
  void dispose() {
    _ownController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      widget.customBuilder?.let(
        (builder) => builder(
          onChanged: _onChanged,
          onSubmitted: _handleSubmitted,
          placeholder: _placeholder,
          controller: _controller,
          inputFormatters: [DateFormatter(placeholder: _placeholder)],
        ),
      ) ??
      OptimusInputField(
        label: widget.label,
        caption: widget.caption,
        isEnabled: widget.isEnabled,
        isClearEnabled: widget.isClearAllEnabled,
        textInputAction: widget.textInputAction,
        secondaryCaption: widget.secondaryCaption,
        placeholder: _placeholder,
        controller: _controller,
        error: widget.error,
        onSubmitted: _handleSubmitted,
        onChanged: _onChanged,
        keyboardType: TextInputType.number,
        isRequired: widget.isRequired,
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        inputFormatters: [DateFormatter(placeholder: _placeholder)],
      );
}

/// Builds a custom Widget that should have a masked input from
/// [OptimusDateInputField].
///
/// All parameters of this function must be passed to the custom text field.
typedef OptimusHelperBuilder = Widget Function({
  required String Function(String) onChanged,
  required void Function(String value) onSubmitted,
  required String placeholder,
  required StyledInputController controller,
  required List<TextInputFormatter> inputFormatters,
});

enum _SupportedSymbol { day, month, year, hour, minute, second }

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
}
