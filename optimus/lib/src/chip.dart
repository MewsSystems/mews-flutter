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
    this.onRemoved,
    this.onTap,
    this.hasError = false,
    this.isEnabled = true,
    this.semanticOnTapHint,
    this.semanticLabel,
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

  /// The semantic label for the chip. This will be read out by screen readers.
  final String? semanticLabel;

  /// The semantic hint for the chip. It is used to provide additional
  /// semantic info. For example, if [semanticOnTapHint]
  /// is provided, instead of saying `Tap to activate`, the screen reader
  /// will say `Tap to <onTapHint>`.
  final String? semanticOnTapHint;

  @override
  State<OptimusChip> createState() => _OptimusChipState();
}

class _OptimusChipState extends State<OptimusChip> with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  Color get _backgroundColor => switch ((
    widget.isEnabled,
    widget.hasError,
    _isPressed,
    _isHovered,
  )) {
    (false, _, _, _) => tokens.backgroundDisabled,
    (true, true, _, _) => tokens.backgroundAlertDangerSecondary,
    (true, false, true, _) => theme.tokens.backgroundInteractiveNeutralActive,
    (true, false, false, true) => tokens.backgroundInteractiveNeutralHover,
    (_) => tokens.backgroundInteractiveNeutralDefault,
  };

  Color get _foregroundColor => switch ((widget.isEnabled, widget.hasError)) {
    (false, _) => tokens.textDisabled,
    (true, true) => tokens.textAlertDanger,
    (true, false) => tokens.textStaticPrimary,
  };

  void _handleHoverChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  @override
  Widget build(BuildContext context) => Semantics(
    onTap: widget.onTap,
    onTapHint: widget.semanticOnTapHint,
    label: widget.semanticLabel,
    enabled: widget.isEnabled,
    child: IgnorePointer(
      ignoring: !widget.isEnabled,
      child: GestureWrapper(
        onHoverChanged: _handleHoverChanged,
        onPressedChanged: _handlePressedChanged,
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(tokens.borderRadius100),
            color: _backgroundColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing50),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: tokens.spacing50),
                  child: DefaultTextStyle.merge(
                    style: tokens.bodyMedium.copyWith(color: _foregroundColor),
                    child: widget.child,
                  ),
                ),
                if (widget.onRemoved != null)
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
