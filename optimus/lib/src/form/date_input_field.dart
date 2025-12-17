import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/date_formatter.dart';
import 'package:optimus/src/form/form_style.dart';
import 'package:optimus/src/form/styled_input_controller.dart';

typedef _SymbolConverter = String Function(_SupportedSymbol symbol);

/// A [TextField] meant to be used for the user to enter a date.
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
    this.helperMessage,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.value,
    this.isClearAllEnabled = false,
    this.onChanged,
    this.textInputAction,
    this.isRequired = false,
    this.focusNode,
    this.onTap,
  });

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
  final Widget? helperMessage;
  final bool isEnabled;
  final bool isClearAllEnabled;

  @override
  State<OptimusDateInputField> createState() => _OptimusDateInputFieldState();
}

class _OptimusDateInputFieldState extends State<OptimusDateInputField>
    with ThemeGetter {
  StyledInputController? _styleController;
  String _previousValue = '';

  StyledInputController get _controller =>
      _styleController ??= StyledInputController(
        text: _formatValue(widget.value),
        inputStyle: _inputStyle,
        placeholderStyle: _placeholderStyle,
      );

  TextStyle get _placeholderStyle =>
      theme.getPlaceholderStyle(isEnabled: widget.isEnabled);

  TextStyle get _inputStyle =>
      theme.getTextInputStyle(isEnabled: widget.isEnabled);

  @override
  void didUpdateWidget(covariant OptimusDateInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isEnabled != oldWidget.isEnabled) {
      _updateControllerStyle();
    }

    if (oldWidget.value != widget.value) {
      _updateControllerValue(widget.value);
    } else if (oldWidget.format.pattern != widget.format.pattern ||
        oldWidget.format.locale != widget.format.locale) {
      final oldDate = _getDateTime(oldWidget.format, _controller.text);
      _updateControllerValue(oldDate);
    }
  }

  @override
  void didChangeDependencies() {
    _updateControllerStyle();
    super.didChangeDependencies();
  }

  void _updateControllerStyle() {
    _controller
      ..inputStyle = _inputStyle
      ..placeholderStyle = _placeholderStyle;
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

  String _handleChanged(String value) {
    if (_previousValue != value || value.isEmpty) {
      final result = _controller.isInputComplete
          ? _getDateTime(widget.format, value)
          : null;
      widget.onChanged?.call(result);
      _previousValue = value;
    }

    return value;
  }

  String _formatOutput(DateTime value) => _placeholderFormat.format(value);

  void _handleSubmitted(String value) {
    final onSubmitted = widget.onSubmitted;
    if (onSubmitted != null) {
      onSubmitted(_getDateTime(widget.format, value));
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
  DateFormat get _placeholderFormat => .new(
    _replaceSupported(
      widget.format.pattern,
      (symbol) => symbol.pattern,
      (symbol) => symbol.format,
    ),
  );

  @override
  void dispose() {
    _styleController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
    label: widget.label,
    caption: widget.caption,
    isEnabled: widget.isEnabled,
    isClearEnabled: widget.isClearAllEnabled,
    textInputAction: widget.textInputAction,
    helperMessage: widget.helperMessage,
    placeholder: _placeholder,
    controller: _controller,
    error: widget.error,
    onSubmitted: _handleSubmitted,
    onChanged: _handleChanged,
    keyboardType: .number,
    isRequired: widget.isRequired,
    onTap: widget.onTap,
    focusNode: widget.focusNode,
    inputFormatters: [DateFormatter(placeholder: _placeholder)],
  );
}

enum _SupportedSymbol { day, month, year, hour, minute, second }

extension on _SupportedSymbol {
  String get pattern => switch (this) {
    .day => 'd',
    .month => 'M',
    .year => 'y',
    .hour => 'H',
    .minute => 'm',
    .second => 's',
  };

  String get format => switch (this) {
    .day => 'dd',
    .month => 'MM',
    .year => 'yyyy',
    .hour => 'HH',
    .minute => 'mm',
    .second => 'ss',
  };

  String get placeholder => switch (this) {
    .day => 'DD',
    .month => 'MM',
    .year => 'YYYY',
    .hour => 'HH',
    .minute => 'mm',
    .second => 'ss',
  };
}
