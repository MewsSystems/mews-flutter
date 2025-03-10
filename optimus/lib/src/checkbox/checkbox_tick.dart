import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus_icons/optimus_icons.dart';

class CheckboxTick extends StatefulWidget {
  const CheckboxTick({
    super.key,
    required this.isEnabled,
    required this.onChanged,
    required this.onTap,
    this.isChecked,
    this.isError = false,
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
  bool _isHovering = false;
  bool _isPressed = false;

  _TickState get _state => widget.isChecked.toState;

  _InteractionState get _interactionState {
    if (!widget.isEnabled) return _InteractionState.disabled;
    if (_isPressed) return _InteractionState.active;
    if (_isHovering) return _InteractionState.hover;

    return _InteractionState.basic;
  }

  void _handleHoverChanged(bool isHovered) =>
      setState(() => _isHovering = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  @override
  Widget build(BuildContext context) => GestureWrapper(
    onHoverChanged: _handleHoverChanged,
    onPressedChanged: _handlePressedChanged,
    onTap: widget.onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: _interactionState.fillColor(
          tokens: tokens,
          state: _state,
          isError: widget.isError,
        ),
        border:
            _state.isUnchecked
                ? Border.all(
                  color: _interactionState.borderColor(
                    tokens: tokens,
                    isError: widget.isError,
                  ),
                  width: tokens.borderWidth150,
                )
                : null,
        borderRadius: BorderRadius.all(tokens.borderRadius25),
      ),
      width: tokens.sizing200,
      height: tokens.sizing200,
      child: _CheckboxIcon(
        icon: _state.icon,
        isEnabled: widget.isEnabled,
        isError: widget.isError,
      ),
    ),
  );
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
  Widget build(BuildContext context) =>
      icon == null
          ? const SizedBox.shrink()
          : Center(
            child: Icon(
              icon,
              size: context.tokens.sizing100,
              color:
                  isEnabled
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

enum _InteractionState { basic, hover, active, disabled }

extension on _InteractionState {
  Color? fillColor({
    required OptimusTokens tokens,
    required _TickState state,
    required bool isError,
  }) => switch (this) {
    _InteractionState.basic =>
      state.isUnchecked
          ? null
          : isError
          ? tokens.backgroundInteractiveDangerDefault
          : tokens.backgroundInteractivePrimaryDefault,
    _InteractionState.hover =>
      state.isUnchecked
          ? tokens.backgroundInteractiveNeutralSubtleHover
          : isError
          ? tokens.backgroundInteractiveDangerHover
          : tokens.backgroundInteractivePrimaryHover,
    _InteractionState.active =>
      state.isUnchecked
          ? tokens.backgroundInteractiveNeutralSubtleActive
          : isError
          ? tokens.backgroundInteractiveDangerActive
          : tokens.backgroundInteractivePrimaryActive,
    _InteractionState.disabled =>
      state.isUnchecked ? null : tokens.backgroundDisabled,
  };

  Color borderColor({required OptimusTokens tokens, required bool isError}) =>
      (isError && this != _InteractionState.disabled)
          ? tokens.borderAlertDanger
          : switch (this) {
            _InteractionState.basic => tokens.borderInteractiveSecondaryDefault,
            _InteractionState.hover => tokens.borderInteractiveSecondaryHover,
            _InteractionState.active => tokens.borderInteractiveSecondaryActive,
            _InteractionState.disabled => tokens.borderDisabled,
          };
}

extension on bool? {
  _TickState get toState => switch (this) {
    true => _TickState.checked,
    false => _TickState.unchecked,
    null => _TickState.undetermined,
  };
}
