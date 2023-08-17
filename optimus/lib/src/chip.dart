import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Chips are a visual representation of a keyword or phrase that the user has
/// used for purposes of filtering the scope of content displayed in the
/// application interface at any given time.
class OptimusChip extends StatefulWidget {
  const OptimusChip({
    super.key,
    required this.child,
    required this.onRemoved,
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

  @override
  State<OptimusChip> createState() => _OptimusChipState();
}

class _OptimusChipState extends State<OptimusChip> with ThemeGetter {
  bool _isHovered = false;
  bool _isTapped = false;

  Color get _backgroundColor => !widget.isEnabled
      ? theme.tokens.backgroundDisabled
      : widget.hasError
          ? theme.tokens.backgroundAlertDangerSecondary
          : _isTapped
              ? theme.tokens.backgroundInteractiveNeutralActive
              : _isHovered
                  ? theme.tokens.backgroundInteractiveNeutralHover
                  : theme.tokens.backgroundInteractiveNeutralDefault;

  Color get _foregroundColor => !widget.isEnabled
      ? theme.tokens.textDisabled
      : widget.hasError
          ? theme.tokens.textAlertDanger
          : theme.tokens.textStaticPrimary;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: !widget.isEnabled,
        child: MouseRegion(
          onEnter: (event) => setState(() => _isHovered = true),
          onExit: (event) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _isTapped = true),
            onTapUp: (_) => setState(() => _isTapped = false),
            onTapCancel: () => setState(() => _isTapped = false),
            child: SizedBox(
              height: _height,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(borderRadius100),
                  color: _backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: spacing50),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: spacing50),
                        child: DefaultTextStyle.merge(
                          style: preset200r.copyWith(color: _foregroundColor),
                          child: widget.child,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onRemoved,
                        child: Icon(
                          OptimusIcons.cross_close,
                          size: 16,
                          color: _foregroundColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

const _height = 24.0;
