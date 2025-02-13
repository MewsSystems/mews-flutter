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
    this.allowInput = true,
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
  });

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

  /// Whether input is allowed.
  final bool allowInput;

  /// Label widget to be displayed above the input.
  final String label;

  /// Whether a loading indicator is displayed.
  final bool isLoading;

  /// Maximum value allowed.
  final int max;

  /// Minimum value allowed.
  final int min;

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

  final num step;

  @override
  State<OptimusNumberInput> createState() => _OptimusNumberInputState();
}

class _OptimusNumberInputState extends State<OptimusNumberInput> {
  late final _formatter = const _NumberInputFormatter();

  late TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  void _handleIncrease() {
    final value = num.parse(_effectiveController.text);
    widget.onChanged((value + widget.step).toString());
  }

  void _handleDecrease() {
    final value = num.parse(_effectiveController.text);
    final result = ((value - widget.step) < 0 && !widget.allowNegate)
        ? 0
        : value - widget.step;
    widget.onChanged(result.toString());
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
      inputFormatters: [_formatter],
      onChanged: widget.onChanged,
      isEnabled: widget.isEnabled,
      isInlined: widget.isInlined,
      showLoader: widget.isLoading,
      label: widget.label,
      helperMessage: widget.helper,
      error: widget.error,
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
