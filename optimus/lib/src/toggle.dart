import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

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
  bool _isTapped = false;

  bool get _isEnabled => widget.onChanged != null;

  Color get _iconColor => _isEnabled
      ? context.tokens.textStaticInverse
      : context.tokens.textDisabled;

  Widget get _spacer => const SizedBox(width: spacing50);
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
      : _isTapped
          ? _tappedColor
          : _isHovered
              ? _hoveredColor
              : _defaultColor;

  Widget get _onIcon => widget.onIcon != null
      ? Opacity(
          opacity: widget.isChecked ? 0 : 1,
          child: Icon(widget.onIcon, size: _iconSize, color: _iconColor),
        )
      : const SizedBox(width: _iconSize);

  Widget get _offIcon => widget.offIcon != null
      ? Opacity(
          opacity: widget.isChecked ? 1 : 0,
          child: Icon(widget.offIcon, size: _iconSize, color: _iconColor),
        )
      : const SizedBox(width: _iconSize);

  @override
  Widget build(BuildContext context) {
    final leftIcon = widget.offIcon;
    final rightIcon = widget.onIcon;

    return IgnorePointer(
      ignoring: !_isEnabled,
      child: MouseRegion(
        onEnter: (event) => setState(() => _isHovered = true),
        onExit: (event) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: (details) => setState(() => _isTapped = true),
          onTapUp: (details) => setState(() => _isTapped = false),
          onTap: () => widget.onChanged?.call(!widget.isChecked),
          child: AnimatedContainer(
            width: _toggleWidth,
            height: _toggleHeight,
            duration: _animationDuration,
            padding: const EdgeInsets.all(spacing50),
            decoration: ShapeDecoration(
              color: _color,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(56)),
              ),
            ),
            child: Stack(
              children: [
                if (leftIcon != null || rightIcon != null)
                  Row(children: [_offIcon, _spacer, _onIcon]),
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
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob();

  @override
  Widget build(BuildContext context) => SizedBox(
        width: _iconSize,
        height: _iconSize,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: context.tokens.backgroundStaticFlat,
            shape: const OvalBorder(),
          ),
        ),
      );
}

const Duration _animationDuration = Duration(milliseconds: 200);
const Curve _animationCurve = Curves.fastOutSlowIn;
const double _iconSize = 16;
const double _toggleWidth = 44;
const double _toggleHeight = 24;
