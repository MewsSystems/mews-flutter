import 'package:flutter/material.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/text_scaling.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus_icons/optimus_icons.dart';

class CheckboxTick extends StatefulWidget {
  const CheckboxTick({
    super.key,
    required this.onChanged,
    required this.onTap,
    this.isChecked,
    this.isError = false,
    this.isEnabled = true,
  });

  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final bool? isChecked;
  final bool isError;
  final VoidCallback onTap;

  @override
  State<CheckboxTick> createState() => _CheckboxTickState();
}

class _CheckboxTickState extends State<CheckboxTick> with ThemeGetter {
  late final WidgetStatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController()
      ..update(WidgetState.disabled, !widget.isEnabled)
      ..update(WidgetState.error, widget.isError);
  }

  @override
  void didUpdateWidget(CheckboxTick oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isEnabled != widget.isEnabled) {
      _controller.update(WidgetState.disabled, !widget.isEnabled);
    }
    if (oldWidget.isError != widget.isError) {
      _controller.update(WidgetState.error, widget.isError);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _TickState get _state => widget.isChecked.toState();

  WidgetStateColor get _fillColor =>
      _state.isUnchecked ? _fillColorUnchecked : _fillColorChecked;

  WidgetStateColor get _fillColorUnchecked => WidgetStateColor.fromMap({
    WidgetState.disabled: Colors.transparent,
    WidgetState.pressed: tokens.backgroundInteractiveNeutralSubtleActive,
    WidgetState.hovered: tokens.backgroundInteractiveNeutralSubtleHover,
    ~WidgetState.disabled: Colors.transparent,
  });

  WidgetStateColor get _fillColorChecked => WidgetStateColor.fromMap({
    WidgetState.disabled: tokens.backgroundDisabled,
    WidgetState.pressed & WidgetState.error:
        tokens.backgroundInteractiveDangerActive,
    WidgetState.pressed: tokens.backgroundInteractivePrimaryActive,
    WidgetState.hovered & WidgetState.error:
        tokens.backgroundInteractiveDangerHover,
    WidgetState.hovered: tokens.backgroundInteractivePrimaryHover,
    WidgetState.error: tokens.backgroundInteractiveDangerDefault,
    ~WidgetState.disabled: tokens.backgroundInteractivePrimaryDefault,
  });

  WidgetStateColor get _borderColor => WidgetStateColor.fromMap({
    WidgetState.disabled: tokens.borderDisabled,
    WidgetState.error: tokens.borderAlertDanger,
    WidgetState.pressed: tokens.borderInteractiveInputActive,
    WidgetState.hovered: tokens.borderInteractiveInputHover,
    ~WidgetState.disabled: tokens.borderInteractiveInputDefault,
  });

  @override
  Widget build(BuildContext context) {
    final size = tokens.sizing200.toScaled(context);

    return ListenableBuilder(
      listenable: _controller,
      builder: (context, child) => GestureWrapper(
        onHoverChanged: (isHovered) =>
            _controller.update(WidgetState.hovered, isHovered),
        onPressedChanged: (isPressed) =>
            _controller.update(WidgetState.pressed, isPressed),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: _fillColor.resolve(_controller.value),
            border: _state.isUnchecked
                ? Border.all(
                    color: _borderColor.resolve(_controller.value),
                    width: tokens.borderWidth100,
                  )
                : null,
            borderRadius: BorderRadius.all(tokens.borderRadius25),
          ),
          width: size,
          height: size,
          child: _CheckboxIcon(
            icon: _state.icon,
            isEnabled: widget.isEnabled,
            isError: widget.isError,
          ),
        ),
      ),
    );
  }
}

class _CheckboxIcon extends StatelessWidget {
  const _CheckboxIcon({
    this.icon,
    required this.isEnabled,
    required this.isError,
  });

  final IconData? icon;
  final bool isEnabled;
  final bool isError;

  @override
  Widget build(BuildContext context) => icon == null
      ? const SizedBox.shrink()
      : Center(
          child: Icon(
            icon,
            size: context.tokens.sizing100.toScaled(context),
            color: isEnabled
                ? context.tokens.textStaticInverse
                : context.tokens.textDisabled,
          ),
        );
}

enum _TickState { checked, unchecked, undetermined }

extension on _TickState {
  IconData? get icon => switch (this) {
    _TickState.checked => OptimusIcons.done,
    _TickState.unchecked => null,
    _TickState.undetermined => OptimusIcons.minus_simple,
  };

  bool get isUnchecked => this == _TickState.unchecked;
}

extension on bool? {
  _TickState toState() => switch (this) {
    true => _TickState.checked,
    false => _TickState.unchecked,
    null => _TickState.undetermined,
  };
}
