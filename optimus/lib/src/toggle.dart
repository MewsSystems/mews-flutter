import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/semantics.dart';
import 'package:optimus/src/common/text_scaling.dart';

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
    this.semanticLabel,
    this.semanticOnTapHint,
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

  /// The semantic label used for the screen reader. We recommend using
  /// localized strings for better accessibility.
  final String? semanticLabel;

  /// The semantic hint for the toggle. It is used to provide additional
  /// semantic info. For example, if [semanticOnTapHint]
  /// is provided, instead of saying `Tap to activate`, the screen reader
  /// will say `Tap to <onTapHint>`.
  final String? semanticOnTapHint;

  @override
  State<OptimusToggle> createState() => _OptimusToggleState();
}

class _OptimusToggleState extends State<OptimusToggle> with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isEnabled => widget.onChanged != null;

  double get _leftPadding => widget.isChecked ? 20 : 0;

  Color get _tappedColor => widget.isChecked
      ? tokens.backgroundInteractivePrimaryActive
      : tokens.backgroundInteractiveNeutralBoldActive;

  Color get _hoveredColor => widget.isChecked
      ? tokens.backgroundInteractivePrimaryHover
      : tokens.backgroundInteractiveNeutralBoldHover;

  Color get _defaultColor => widget.isChecked
      ? tokens.backgroundInteractivePrimaryDefault
      : tokens.backgroundInteractiveNeutralBoldDefault;

  Color get _color => switch ((_isEnabled, _isPressed, _isHovered)) {
    (false, _, _) => tokens.backgroundDisabled,
    (true, true, _) => _tappedColor,
    (true, false, true) => _hoveredColor,
    (true, false, false) => _defaultColor,
  };

  void _handleHoveredChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  void _handleTap() => widget.onChanged?.call(!widget.isChecked);

  @override
  Widget build(BuildContext context) => IgnorePointer(
    ignoring: !_isEnabled,
    child: Semantics(
      label: widget.semanticLabel,
      toggled: widget.isChecked,
      onTapHint: widget.semanticOnTapHint,
      onTap: _handleTap,
      child: GestureWrapper(
        onHoverChanged: _handleHoveredChanged,
        onPressedChanged: _handlePressedChanged,
        onTap: _handleTap,
        child: AnimatedContainer(
          width: tokens.sizing550.toScaled(context),
          height: tokens.sizing300.toScaled(context),
          duration: _animationDuration,
          padding: EdgeInsets.all(tokens.spacing50.toScaled(context)),
          decoration: ShapeDecoration(
            color: _color,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(56),
              ), // TODO(witwash): replace with tokens
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
                    SizedBox(width: tokens.spacing50).excludeSemantics(),
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
                left: _leftPadding.toScaled(context),
                child: const _Knob(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Knob extends StatelessWidget {
  const _Knob();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final knobSize = tokens.sizing200.toScaled(context);

    return SizedBox.square(
      dimension: knobSize,
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
