import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusNumberInput extends StatefulWidget {
  const OptimusNumberInput({
    super.key,
    this.allowNegate = false,
    this.isEnabled = true,
    this.error,
    this.hasFixedDecimalScale = true,
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
    this.thousandSeparator = OptimusNumberSeparatorVariant.comma,
    this.decimalSeparator = OptimusNumberSeparatorVariant.stop,
    this.size = OptimusWidgetSize.large,
    this.suffix,
    required this.onChanged,
    this.focusNode,
    this.controller,
    this.step = 1,
    this.initialValue = 1.0,
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
        );

  /// Whether negative values are allowed.
  final bool allowNegate;

  /// Whether the input is enabled.
  final bool isEnabled;

  /// Error message to be displayed.
  final String? error;

  /// Whether the decimal scale is fixed.
  final bool hasFixedDecimalScale;

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

  /// Thousand separator variant.
  final OptimusNumberSeparatorVariant thousandSeparator;

  /// Decimal separator variant.
  final OptimusNumberSeparatorVariant decimalSeparator;

  /// Size of the input widget.
  final OptimusWidgetSize size;

  /// Suffix widget to be displayed after the input.
  final Widget? suffix;

  final ValueChanged<String> onChanged;

  final FocusNode? focusNode;

  final TextEditingController? controller;

  final double step;

  final double initialValue;

  @override
  State<OptimusNumberInput> createState() => _OptimusNumberInputState();
}

class _OptimusNumberInputState extends State<OptimusNumberInput> {
  late final _formatter = const _NumberInputFormatter();

  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _effectiveController.text = widget.initialValue.toString();
  }

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

  double get _currentValue => double.parse(_effectiveController.text);

  void _updateCurrentValue(double value) {
    setState(() => _effectiveController.text = value.toString());
    widget.onChanged(value.toString());
  }

  @override
  void didUpdateWidget(OptimusNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.min != widget.min && _currentValue < widget.min) {
      _effectiveController.text = widget.min.toString();
      widget.onChanged(_currentValue.toString());
    } else if (oldWidget.max != widget.max && _currentValue > widget.max) {
      _effectiveController.text = widget.max.toString();
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
        width: 1.5,
        child: isEnabled
            ? ColoredBox(color: context.tokens.borderStaticSecondary)
            : null,
      );
}

class _NumberInputFormatter extends TextInputFormatter {
  const _NumberInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // TODO(witwash): implement formatEditUpdate
    throw UnimplementedError();
  }
}

enum OptimusNumberSeparatorVariant { comma, stop, none, empty }
