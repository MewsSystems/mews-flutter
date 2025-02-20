import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusNumberInput extends StatefulWidget {
  const OptimusNumberInput({
    super.key,
    this.allowNegate = false,
    this.isEnabled = true,
    this.error,
    this.helper,
    this.isInlined = false,
    required this.label,
    this.isLoading = false,
    this.max = 12,
    this.min = -12,
    required this.placeholder,
    this.precision = 2,
    this.prefix,
    this.isRequired = false,
    this.separatorVariant = OptimusNumberSeparatorVariant.commaAndStop,
    this.size = OptimusWidgetSize.large,
    this.suffix,
    required this.onChanged,
    this.controller,
    this.focusNode,
    this.step = 1,
  })  : assert(
          (min < 0 && allowNegate) || min >= 0,
          'Negative values should be allowed if the minimum is less than 0',
        ),
        assert(
          ((min < 0 || max < 0) && allowNegate) || (max > 0 && min >= 0),
          'Negative values should be allowed if min or max are less than 0',
        ),
        assert(
          min < max,
          'The minimal allowed value should be lesser then max value',
        ),
        assert(precision >= 0, 'Precision can be negative');

  /// Whether negative values are allowed.
  final bool allowNegate;

  /// Whether the input is enabled.
  final bool isEnabled;

  /// Error message to be displayed.
  final String? error;

  /// Helper widget to be displayed below the input.
  final Widget? helper;

  /// Whether the input is inlined.
  final bool isInlined;

  /// Label widget to be displayed above the input.
  final String label;

  /// Whether a loading indicator is displayed.
  final bool isLoading;

  /// Maximum value allowed.
  final double max;

  /// Minimum value allowed.
  final double min;

  /// Placeholder text to be displayed when the input is empty.
  final String placeholder;

  /// Number of decimal places allowed.
  final int precision;

  /// Prefix widget to be displayed before the input.
  final Widget? prefix;

  /// Whether the input is required.
  final bool isRequired;

  /// Separator variant to be used.
  /// Default is [OptimusNumberSeparatorVariant.commaAndStop].
  final OptimusNumberSeparatorVariant separatorVariant;

  /// Size of the input widget.
  final OptimusWidgetSize size;

  /// Suffix widget to be displayed after the input.
  final Widget? suffix;

  /// Callback that is called when the value changes.
  final ValueChanged<String> onChanged;

  /// An optional focus node to be used.
  final FocusNode? focusNode;

  /// An optional controller to be used.
  final TextEditingController? controller;

  /// The step by which the value is increased or decreased.
  final double step;

  @override
  State<OptimusNumberInput> createState() => _OptimusNumberInputState();
}

class _OptimusNumberInputState extends State<OptimusNumberInput> {
  late final _formatter = _NumberInputFormatter(
    precision: widget.precision,
    separatorVariant: widget.separatorVariant,
  );

  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  void _handleIncrease() {
    final newValue = _currentValue + widget.step;
    final result = newValue > widget.max ? widget.max : newValue;
    _updateCurrentValue(result);
  }

  void _handleDecrease() {
    final newValue = _currentValue - widget.step;
    final double result = newValue < widget.min
        ? widget.min
        : (newValue < 0 && !widget.allowNegate)
            ? 0
            : newValue;
    _updateCurrentValue(result);
  }

  double get _currentValue {
    final text = _effectiveController.text.isNotEmpty
        ? _effectiveController.text
        : _initialValue.format(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          );
    String cleanedText = text;

    if (widget.precision > 0) {
      cleanedText = cleanedText.replaceAll(
        widget.separatorVariant.decimalSeparator,
        _stopSeparator,
      );
    }

    cleanedText =
        cleanedText.replaceAll(widget.separatorVariant.groupSeparator, '');

    return double.parse(cleanedText);
  }

  void _updateCurrentValue(double value) {
    setState(
      () => _effectiveController.text = value.toString().format(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          ),
    );
    widget.onChanged(value.toString());
  }

  @override
  void didUpdateWidget(OptimusNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.min != widget.min && _currentValue < widget.min) {
      _effectiveController.text = widget.min.toString().format(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          );
      widget.onChanged(_currentValue.toString());
    } else if (oldWidget.max != widget.max && _currentValue > widget.max) {
      _effectiveController.text = widget.max.toString().format(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          );
      widget.onChanged(_currentValue.toString());
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return OptimusInputField(
      placeholder: widget.placeholder,
      prefix: widget.prefix,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly, _formatter],
      onChanged: widget.onChanged,
      isEnabled: widget.isEnabled,
      isInlined: widget.isInlined,
      showLoader: widget.isLoading,
      isRequired: widget.isRequired,
      controller: _effectiveController,
      size: widget.size,
      label: widget.label,
      helperMessage: widget.helper,
      error: widget.error,
      keyboardType: TextInputType.number,
      isReadOnly: true,
      suffix: Row(
        children: [
          if (widget.suffix case final suffix?)
            Padding(
              padding: EdgeInsets.only(right: tokens.spacing150),
              child: suffix,
            ),
          Padding(
            padding: EdgeInsets.only(right: tokens.spacing100),
            child: GestureDetector(
              onTap: _handleDecrease,
              child: const OptimusIcon(
                iconData: OptimusIcons.minus_simple,
                colorOption: OptimusIconColorOption.basic,
              ),
            ),
          ),
          _Divider(isEnabled: widget.isEnabled),
          Padding(
            padding: EdgeInsets.only(left: tokens.spacing100),
            child: GestureDetector(
              onTap: _handleIncrease,
              child: const OptimusIcon(
                iconData: OptimusIcons.plus_simple,
                colorOption: OptimusIconColorOption.basic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.isEnabled});

  final bool isEnabled;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: context.tokens.sizing200,
        width: context.tokens.borderWidth150,
        child: isEnabled
            ? ColoredBox(color: context.tokens.borderStaticSecondary)
            : null,
      );
}

class _NumberInputFormatter extends TextInputFormatter {
  const _NumberInputFormatter({
    required this.precision,
    required this.separatorVariant,
  });

  final int precision;
  final OptimusNumberSeparatorVariant separatorVariant;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    final newTextNumber = newText.format(
      precision: precision,
      separatorVariant: separatorVariant,
    );

    return newValue.copyWith(text: newTextNumber);
  }
}

/// The separator variant to be used in the number input.
///
/// The default value is [OptimusNumberSeparatorVariant.commaAndStop].
/// [OptimusNumberSeparatorVariant.commaAndStop] - uses comma as a group separator
/// and stop as a decimal separator. For example, 1,000.00.
/// [OptimusNumberSeparatorVariant.stopAndComma] - uses stop as a group separator
/// and comma as a decimal separator. For example, 1.000,00.
/// [OptimusNumberSeparatorVariant.noneAndComma] - uses space as a group separator
/// and comma as a decimal separator. For example, 1 000,00.
/// [OptimusNumberSeparatorVariant.noneAndStop] - uses space as a group separator
/// and stop as a decimal separator. For example, 1 000.00.
/// [OptimusNumberSeparatorVariant.emptyAndComma] - uses empty string as a group separator
/// and comma as a decimal separator. For example, 1000,00.
/// [OptimusNumberSeparatorVariant.emptyAndStop] - uses empty string as a group separator
/// and stop as a decimal separator. For example, 1000.00.
enum OptimusNumberSeparatorVariant {
  commaAndStop(_commaSeparator, _stopSeparator),
  stopAndComma(_stopSeparator, _commaSeparator),
  noneAndComma(_spaceSeparator, _commaSeparator),
  noneAndStop(_spaceSeparator, _stopSeparator),
  emptyAndComma(_emptySeparator, _commaSeparator),
  emptyAndStop(_emptySeparator, _stopSeparator);

  const OptimusNumberSeparatorVariant(
    this.groupSeparator,
    this.decimalSeparator,
  );

  final String groupSeparator;
  final String decimalSeparator;
}

extension on String {
  String format({
    required int precision,
    required OptimusNumberSeparatorVariant separatorVariant,
  }) {
    final fixedLength = num.parse(this).toStringAsFixed(precision);
    final parts = fixedLength.split('.');
    final wholePart = parts.first;
    final decimalPart = parts.length > 1 ? parts.last : '';

    final buffer = StringBuffer();
    for (int i = 0; i < wholePart.length; i++) {
      if (i > 0 && (wholePart.length - i) % 3 == 0) {
        buffer.write(separatorVariant.groupSeparator);
      }
      buffer.write(wholePart[i]);
    }

    if (decimalPart.isNotEmpty) {
      buffer
        ..write(separatorVariant.decimalSeparator)
        ..write(decimalPart);
    }

    return buffer.toString();
  }
}

const _initialValue = '0';
const _commaSeparator = ',';
const _stopSeparator = '.';
const _emptySeparator = '';
const _spaceSeparator = ' ';
