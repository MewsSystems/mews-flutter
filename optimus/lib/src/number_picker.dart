import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/constants.dart';

class OptimusNumberPicker extends StatefulWidget {
  const OptimusNumberPicker({
    Key key,
    this.value,
    @required this.onChanged,
    this.defaultValue = 0,
    this.min = 0,
    this.max = 100,
    this.focusNode,
    this.isEnabled = true,
    this.error,
  })  : assert(min != null, 'min should not be null'),
        assert(max != null, 'max should not be null'),
        assert(onChanged != null, 'onChanged should not be null'),
        assert(isEnabled != null, 'isEnabled should not be null'),
        assert(defaultValue != null, 'defaultValue should not be null'),
        assert(
          min <= defaultValue && defaultValue <= max,
          'default value should be in [min, max] range',
        ),
        assert(
          value == null || min <= value && value <= max,
          'value should either be null or in [min, max] range',
        ),
        super(key: key);

  final int value;
  final int defaultValue;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final FocusNode focusNode;
  final bool isEnabled;
  final String error;

  @override
  _OptimusNumberPickerState createState() => _OptimusNumberPickerState();
}

class _OptimusNumberPickerState extends State<OptimusNumberPicker> {
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void didUpdateWidget(OptimusNumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _updateInputValue(widget.value);
    }
  }

  @override
  void initState() {
    super.initState();
    _updateInputValue(widget.value);
  }

  void _updateInputValue(int value) {
    _controller.value = _controller.value.copyWith(text: _format(value));
  }

  void _onMinusTap() {
    widget.onChanged(_safeValue - 1);
  }

  void _onPlusTap() {
    widget.onChanged(_safeValue + 1);
  }

  int get _safeValue => widget.value ?? widget.defaultValue;

  bool get _canAdd => _isInRange(_safeValue + 1);

  bool get _canSubtract => _isInRange(_safeValue - 1);

  bool _isInRange(int value) =>
      value == null || widget.min <= value && value <= widget.max;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 134),
        child: OptimusInputField(
          textAlign: TextAlign.center,
          error: widget.error,
          isEnabled: widget.isEnabled,
          keyboardType: TextInputType.number,
          controller: _controller,
          prefix: _IconButton(
            iconData: OptimusIcons.minus_simple,
            onPressed: _canSubtract ? _onMinusTap : null,
          ),
          suffix: _IconButton(
            iconData: OptimusIcons.plus_simple,
            onPressed: _canAdd ? _onPlusTap : null,
          ),
          focusNode: _effectiveFocusNode,
          onChanged: (v) {
            final newValue = int.tryParse(v);
            if (_isInRange(newValue)) {
              widget.onChanged(newValue);
            } else {
              _updateInputValue(widget.value);
            }
          },
          placeholder: widget.defaultValue.toString(),
        ),
      );
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    Key key,
    @required this.iconData,
    @required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPressed;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: _isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
        child: GestureDetector(
          onTap: onPressed,
          child: Icon(
            iconData,
            color: OptimusColors.basic900t64,
            size: 24,
          ),
        ),
      );
}

String _format(int value) => value?.toString() ?? '';
