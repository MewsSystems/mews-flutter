import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/number_input/filtering_input_formatter.dart';
import 'package:optimus/src/form/number_input/string_formatter.dart';

class OptimusNumberInput extends StatefulWidget {
  const OptimusNumberInput({
    super.key,
    this.allowNegate = false,
    this.isEnabled = true,
    this.error,
    this.helperMessage,
    this.isInlined = false,
    required this.label,
    this.showLoader = false,
    this.max = 12,
    this.min = 0,
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
    this.isReadOnly = false,
    this.onSubmitted,
    this.decreaseSemanticLabel,
    this.increaseSemanticLabel,
  }) : assert(
         (min < 0 && allowNegate) || min >= 0,
         'Negative values should be allowed if the minimum is less than 0',
       ),
       assert(
         min < max,
         'The minimal allowed value should be lesser then max value',
       ),
       assert(precision >= 0, 'Precision can\'t be negative');

  /// Whether negative values are allowed. Disabled by default.
  final bool allowNegate;

  /// Whether the input is enabled.
  final bool isEnabled;

  /// Error message to be displayed.
  final String? error;

  /// Helper widget to be displayed below the input.
  final Widget? helperMessage;

  /// Whether the input is inlined.
  final bool isInlined;

  /// Label widget to be displayed above the input.
  final String? label;

  /// Whether a loading indicator is displayed.
  final bool showLoader;

  /// Maximum value allowed.
  final double max;

  /// Minimum value allowed. In case of an error, the input will be set to this
  /// value. Default is 0.
  final double min;

  /// Placeholder text to be displayed when the input is empty.
  final String? placeholder;

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

  /// Whether the input is read-only.
  final bool isReadOnly;

  /// Callback that is called when the input is submitted.
  final ValueChanged<String>? onSubmitted;

  /// Semantic label for marking the button as a decrease function button.
  /// This will enrich component for the screen reader.
  final String? decreaseSemanticLabel;

  /// Semantic label for marking the button as an increase function button.
  /// This will enrich component for the screen reader.
  final String? increaseSemanticLabel;

  @override
  State<OptimusNumberInput> createState() => _OptimusNumberInputState();
}

class _OptimusNumberInputState extends State<OptimusNumberInput> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode {
    if (widget.focusNode case final focusNode?) return focusNode;

    return _focusNode ??= FocusNode();
  }

  TextEditingController get _effectiveController {
    if (widget.controller case final controller?) return controller;

    return _controller ??= TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusLost);
  }

  void _handleIncrease() => _updateCurrentValue(_increasedValue);

  void _handleDecrease() => _updateCurrentValue(_decreasedValue);

  double get _currentValue => _effectiveController.text.isEmpty
      ? widget.min
      : _effectiveController.text.toDouble(
          widget.separatorVariant,
          widget.precision,
        );

  double get _increasedValue =>
      (_currentValue - widget.step).clamp(widget.min, widget.max);

  double get _decreasedValue =>
      (_currentValue + widget.step).clamp(widget.min, widget.max);

  void _updateCurrentValue(double value) {
    _effectiveController.text = value.toFormattedString(
      precision: widget.precision,
      separatorVariant: widget.separatorVariant,
    );

    widget.onChanged(value.toString());
  }

  @override
  void didUpdateWidget(OptimusNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    String formattedValue = _effectiveController.text;
    if (oldWidget.min != widget.min || oldWidget.max != widget.max) {
      formattedValue = _currentValue
          .clamp(widget.min, widget.max)
          .toFormattedString(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          );
    } else if (oldWidget.precision != widget.precision ||
        oldWidget.separatorVariant != widget.separatorVariant ||
        (oldWidget.allowNegate != widget.allowNegate)) {
      final doubleValue = formattedValue.isNotEmpty
          ? formattedValue.toDouble(
              oldWidget.separatorVariant,
              oldWidget.precision,
            )
          : widget.min;
      formattedValue = doubleValue.toFormattedString(
        precision: widget.precision,
        separatorVariant: widget.separatorVariant,
      );
    }

    if (formattedValue != _effectiveController.text) {
      _effectiveController.text = formattedValue;
      widget.onChanged(formattedValue);
    }
  }

  void _handleFocusLost() {
    if (!_effectiveFocusNode.hasFocus) {
      _handleFormat();
    }
  }

  void _handleFormat() {
    final text = _effectiveController.text;
    final number =
        double.tryParse(text)?.clamp(widget.min, widget.max) ?? widget.min;
    final formatted = number.toFormattedString(
      precision: widget.precision,
      separatorVariant: widget.separatorVariant,
    );
    if (text != formatted) {
      _effectiveController.text = formatted;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusLost);
    _controller?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      value: _currentValue.toString(),
      decreasedValue: _decreasedValue.toString(),
      increasedValue: _increasedValue.toString(),
      onIncrease: _handleIncrease,
      onDecrease: _handleDecrease,

      child: OptimusInputField(
        placeholder: widget.placeholder,
        prefix: widget.prefix,
        onChanged: widget.onChanged,
        isEnabled: widget.isEnabled,
        isInlined: widget.isInlined,
        showLoader: widget.showLoader,
        isRequired: widget.isRequired,
        controller: _effectiveController,
        size: widget.size,
        label: widget.label,
        helperMessage: widget.helperMessage,
        error: widget.error,
        inputFormatters: [
          NumberInputFilteringTextInputFormatter(
            precision: widget.precision,
            separatorVariant: widget.separatorVariant,
          ),
        ],
        keyboardType: TextInputType.numberWithOptions(
          signed: widget.allowNegate,
          decimal: widget.precision > 0,
        ),
        isReadOnly: widget.isReadOnly,
        onSubmitted: (value) {
          _handleFormat();
          widget.onSubmitted?.call(_effectiveController.text);
        },
        suffix: Row(
          children: [
            if (widget.suffix case final suffix?)
              Padding(
                padding: EdgeInsets.only(right: tokens.spacing150),
                child: suffix,
              ),
            Padding(
              padding: EdgeInsets.only(right: tokens.spacing100),
              child: Semantics(
                label: widget.decreaseSemanticLabel,
                child: GestureDetector(
                  onTap: _handleDecrease,
                  child: const OptimusIcon(
                    iconData: OptimusIcons.minus_simple,
                    colorOption: OptimusIconColorOption.basic,
                  ),
                ),
              ),
            ),
            _Divider(isEnabled: widget.isEnabled),
            Padding(
              padding: EdgeInsets.only(left: tokens.spacing100),
              child: Semantics(
                label: widget.increaseSemanticLabel,
                child: GestureDetector(
                  onTap: _handleIncrease,
                  child: const OptimusIcon(
                    iconData: OptimusIcons.plus_simple,
                    colorOption: OptimusIconColorOption.basic,
                  ),
                ),
              ),
            ),
          ],
        ),
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
    width: context.tokens.borderWidth200,
    child: isEnabled
        ? ColoredBox(color: context.tokens.borderStaticSecondary)
        : null,
  );
}

/// The separator variant to be used in the number input.
///
/// The default value is [OptimusNumberSeparatorVariant.commaAndStop].
/// [OptimusNumberSeparatorVariant.commaAndStop] - uses comma as a group separator
/// and stop as a decimal separator. For example, 1,000.00.
/// [OptimusNumberSeparatorVariant.stopAndComma] - uses stop as a group separator
/// and comma as a decimal separator. For example, 1.000,00.
/// [OptimusNumberSeparatorVariant.spaceAndComma] - uses space as a group separator
/// and comma as a decimal separator. For example, 1 000,00.
/// [OptimusNumberSeparatorVariant.spaceAndStop] - uses space as a group separator
/// and stop as a decimal separator. For example, 1 000.00.
/// [OptimusNumberSeparatorVariant.emptyAndComma] - uses empty string as a group separator
/// and comma as a decimal separator. For example, 1000,00.
/// [OptimusNumberSeparatorVariant.emptyAndStop] - uses empty string as a group separator
/// and stop as a decimal separator. For example, 1000.00.
enum OptimusNumberSeparatorVariant {
  commaAndStop(_commaSeparator, _stopSeparator),
  stopAndComma(_stopSeparator, _commaSeparator),
  spaceAndComma(_spaceSeparator, _commaSeparator),
  spaceAndStop(_spaceSeparator, _stopSeparator),
  emptyAndComma(_emptySeparator, _commaSeparator),
  emptyAndStop(_emptySeparator, _stopSeparator);

  const OptimusNumberSeparatorVariant(
    this.groupSeparator,
    this.decimalSeparator,
  );

  final String groupSeparator;
  final String decimalSeparator;
}

extension on double {
  String toFormattedString({
    required int precision,
    required OptimusNumberSeparatorVariant separatorVariant,
  }) => toString().format(
    precision: precision,
    separatorVariant: separatorVariant,
  );
}

extension on String {
  double toDouble(
    OptimusNumberSeparatorVariant separatorVariant,
    int precision,
  ) {
    String cleanedText = replaceAll(separatorVariant.groupSeparator, '');
    if (precision > 0) {
      cleanedText = cleanedText.replaceAll(
        separatorVariant.decimalSeparator,
        _stopSeparator,
      );
    }

    return double.parse(cleanedText);
  }
}

const _commaSeparator = ',';
const _stopSeparator = '.';
const _emptySeparator = '';
const _spaceSeparator = ' ';
