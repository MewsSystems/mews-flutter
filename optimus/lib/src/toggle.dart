import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';

/// The toggle component serves as a visual representation of a binary choice,
/// providing users with a clear way to control settings, preferences, or switch
/// between different views. With its ability to instantly communicate changes
/// and offer immediate feedback, the toggle component greatly enhances
/// usability and interactivity.
class OptimusToggle extends StatefulWidget {
  const OptimusToggle({
    super.key,
    this.offIcon,
    this.onIcon,
    this.isChecked = false,
    required this.onChanged,
  });

  /// An optional icon for the off state.
  final IconData? offIcon;

  /// An optional icon for the on state.
  final IconData? onIcon;

  /// Whether the toggle is checked. The state of the toggle is managed in the
  /// parent widget.
  final bool isChecked;

  /// The callback on the toggle state change. If not provided, the toggle will
  /// be disabled.
  final ValueChanged<bool>? onChanged;

  @override
  State<OptimusToggle> createState() => _OptimusToggleState();
}

class _OptimusToggleState extends State<OptimusToggle> with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isEnabled => widget.onChanged != null;

  double get _leftPadding => widget.isChecked ? 20 : 0;

  Color get _tappedColor => widget.isChecked
      ? context.tokens.backgroundInteractivePrimaryActive
      : context.tokens.backgroundInteractiveNeutralBoldActive;

  Color get _hoveredColor => widget.isChecked
      ? context.tokens.backgroundInteractivePrimaryHover
      : context.tokens.backgroundInteractiveNeutralBoldHover;

  Color get _defaultColor => widget.isChecked
      ? context.tokens.backgroundInteractivePrimaryDefault
      : context.tokens.backgroundInteractiveNeutralBoldDefault;

  Color get _color => !_isEnabled
      ? context.tokens.backgroundDisabled
      : _isPressed
          ? _tappedColor
          : _isHovered
              ? _hoveredColor
              : _defaultColor;

  void _handleHoveredChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return IgnorePointer(
      ignoring: !_isEnabled,
      child: GestureWrapper(
        onHoverChanged: _handleHoveredChanged,
        onPressedChanged: _handlePressedChanged,
        onTap: () => widget.onChanged?.call(!widget.isChecked),
        child: AnimatedContainer(
          width: tokens.sizing550,
          height: tokens.sizing300,
          duration: _animationDuration,
          padding: EdgeInsets.all(tokens.spacing50),
          decoration: ShapeDecoration(
            color: _color,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(56)),
            ),
          ),
          child: Stack(
            children: [
              if (widget.offIcon != null || widget.onChanged != null)
                Row(
                  children: [
                    _Icon(
                      icon: widget.offIcon,
                      isVisible: widget.isChecked,
                      isEnabled: _isEnabled,
                    ),
                    SizedBox(width: tokens.spacing50),
                    _Icon(
                      icon: widget.onIcon,
                      isVisible: !widget.isChecked,
                      isEnabled: _isEnabled,
                    ),
                  ],
                ),
              AnimatedPositioned(
                duration: _animationDuration,
                curve: _animationCurve,
                left: _leftPadding,
                child: const _Knob(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final knobSize = tokens.sizing200;

    return SizedBox(
      width: knobSize,
      height: knobSize,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: tokens.backgroundStaticFlat,
          shape: const OvalBorder(),
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({this.isVisible = false, this.isEnabled = true, this.icon});

  final bool isVisible;
  final bool isEnabled;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Opacity(
      opacity: isVisible ? 1 : 0,
      child: Icon(
        icon,
        size: tokens.sizing200,
        color: isEnabled ? tokens.textStaticInverse : tokens.textDisabled,
      ),
    );
  }
}

const Duration _animationDuration = Duration(milliseconds: 200);
const Curve _animationCurve = Curves.fastOutSlowIn;
