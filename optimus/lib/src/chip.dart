import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';

/// Chips are a visual representation of a keyword or phrase that the user has
/// used for purposes of filtering the scope of content displayed in the
/// application interface at any given time.
class OptimusChip extends StatefulWidget {
  const OptimusChip({
    super.key,
    required this.child,
    required this.onRemoved,
    this.onTap,
    this.hasError = false,
    this.isEnabled = true,
  });

  /// The child of the chip. Typically a [Text] widget.
  final Widget child;

  /// Whether the chip has an error.
  final bool hasError;

  /// Defines if the chip is enabled for the interaction.
  final bool isEnabled;

  /// Callback to be called on the chip remove.
  final VoidCallback? onRemoved;

  /// Callback to be called on the chip body tap.
  final VoidCallback? onTap;

  @override
  State<OptimusChip> createState() => _OptimusChipState();
}

class _OptimusChipState extends State<OptimusChip> with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  Color get _backgroundColor => !widget.isEnabled
      ? theme.tokens.backgroundDisabled
      : widget.hasError
          ? theme.tokens.backgroundAlertDangerSecondary
          : _isPressed
              ? theme.tokens.backgroundInteractiveNeutralActive
              : _isHovered
                  ? theme.tokens.backgroundInteractiveNeutralHover
                  : theme.tokens.backgroundInteractiveNeutralDefault;

  Color get _foregroundColor => !widget.isEnabled
      ? theme.tokens.textDisabled
      : widget.hasError
          ? theme.tokens.textAlertDanger
          : theme.tokens.textStaticPrimary;

  void _handleHoverChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: !widget.isEnabled,
        child: GestureWrapper(
          onHoverChanged: _handleHoverChanged,
          onPressedChanged: _handlePressedChanged,
          onTap: widget.onTap,
          child: SizedBox(
            height: tokens.sizing300,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(context.tokens.borderRadius100),
                color: _backgroundColor,
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.tokens.spacing50),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.tokens.spacing50,
                      ),
                      child: DefaultTextStyle.merge(
                        style:
                            tokens.bodyMedium.copyWith(color: _foregroundColor),
                        child: widget.child,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onRemoved,
                      child: Icon(
                        OptimusIcons.cross_close,
                        size: tokens.sizing200,
                        color: _foregroundColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
