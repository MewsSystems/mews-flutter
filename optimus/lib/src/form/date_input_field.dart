import 'package:flutter/material.dart';
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
    Key? key,
    this.onSubmitted,
    required this.format,
    this.label,
    this.error,
    this.caption,
    this.secondaryCaption,
    this.size = OptimusWidgetSize.large,
    this.isEnabled = true,
    this.initialValue,
    this.isClearAllEnabled = false,
    this.onChanged,
    this.showCursor = false,
    this.isRequired = false,
    this.focusNode,
    this.onTap,
  }) : super(key: key);

  /// Format of the date. It will define the placeholder and the separator.
  final DateFormat format;

  /// Function to be called when the user submits the form.
  final ValueChanged<DateTime?>? onSubmitted;

  /// The initial value of the input.
  final DateTime? initialValue;

  /// The widget size. By default [OptimusWidgetSize.large].
  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<DateTime?>? onChanged;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  final VoidCallback? onTap;

  final bool? showCursor;
  final bool isRequired;
  final String? label;
  final String? error;
  final Widget? caption;
  final Widget? secondaryCaption;
  final bool isEnabled;
  final bool isClearAllEnabled;

  @override
  State<OptimusDateInputField> createState() => _OptimusDateInputFieldState();
}

class _OptimusDateInputFieldState extends State<OptimusDateInputField>
    with ThemeGetter {
  late _StyledInputController _styleController;
  final List<int> _userInput = <int>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userInput.clear();
    if (widget.initialValue != null) {
      for (int i = 0; i < _placeholder.length; i++) {
        _userInput.add(i);
      }
    }

    _styleController = _StyledInputController(
      text: _initialText,
      placeholderStyle: theme.getPlaceholderStyle(widget.size),
      inputStyle: theme.getTextInputStyle(widget.size),
      userInput: _userInput,
    );
  }

  @override
  void didUpdateWidget(covariant OptimusDateInputField oldWidget) {
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

  /// Create the mask from the pattern.
  ///
  /// For example "dd/MM/yyyy" will be transformed to "##/##/####".
  String get _mask => _replaceSupported(
        widget.format.pattern,
        (symbol) => symbol.pattern,
        (symbol) => symbol.mask,
      );

  bool get _showClearAll => widget.isClearAllEnabled && _userInput.isNotEmpty;

  @override
  void dispose() {
    _styleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
        label: widget.label,
        caption: widget.caption,
        isEnabled: widget.isEnabled,
        isClearEnabled: _showClearAll,
        secondaryCaption: widget.secondaryCaption,
        placeholder: _placeholder,
        controller: _styleController,
        error: widget.error,
        onSubmitted: _handleSubmitted,
        keyboardType: TextInputType.number,
        showCursor: widget.showCursor,
        isRequired: widget.isRequired,
        onTap: widget.onTap,
        focusNode: widget.focusNode,
        inputFormatters: [
          DateFormatter(
            mask: _mask,
            placeholder: _placeholder,
            initValue: _initialText,
            userInput: _userInput,
            allowedDigits: widget.format.digitMatcher,
            onUserInputChanged: () => setState(() {}),
          )
        ],
      );
}

/// Controller for highlighting the user input inside the
/// text input field.
class _StyledInputController extends TextEditingController {
  _StyledInputController({
    String? text,
    required this.inputStyle,
    required this.placeholderStyle,
    required this.userInput,
  }) : super(text: text);

  /// The style to use for the user entered part.
  final TextStyle inputStyle;

  /// The style to use for the rest.
  final TextStyle placeholderStyle;

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
          style: userInput.contains(i) ? inputStyle : placeholderStyle,
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
