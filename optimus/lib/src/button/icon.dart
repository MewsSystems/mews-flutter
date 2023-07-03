import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';

/// When you don’t have enough space for regular buttons, or the action is
/// clear enough, you can use an icon button without text.
class OptimusIconButton extends StatefulWidget {
  const OptimusIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.primary,
  });

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Typically [Icon] widget.
  final Widget icon;

  /// Button size.
  final OptimusWidgetSize size;

  /// Button type.
  final OptimusButtonVariant variant;

  @override
  State<OptimusIconButton> createState() => _OptimusIconButtonState();
}

class _OptimusIconButtonState extends State<OptimusIconButton>
    with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  void _onHoverChanged(bool isHovering) =>
      setState(() => _isHovered = isHovering);

  bool get _isEnabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.variant.borderColor(
      tokens,
      isEnabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );
    final isEnabled = widget.onPressed != null;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: MouseRegion(
        onEnter: (_) => _onHoverChanged(true),
        onExit: (_) => _onHoverChanged(false),
        child: GestureDetector(
          onTap: widget.onPressed,
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: AnimatedContainer(
            height: widget.size.containerSize,
            width: widget.size.containerSize,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: widget.variant.backgroundColor(
                tokens,
                isEnabled: _isEnabled,
                isPressed: _isPressed,
                isHovered: _isHovered,
              ),
              border: borderColor != null
                  ? Border.all(color: borderColor, width: 1)
                  : null,
              borderRadius: const BorderRadius.all(borderRadius50),
            ),
            duration: buttonAnimationDuration,
            child: IconTheme.merge(
              data: IconThemeData(
                color: widget.variant.foregroundColor(
                  tokens,
                  isEnabled: _isEnabled,
                  isPressed: _isPressed,
                  isHovered: _isHovered,
                ),
                size: widget.size.iconSize,
              ),
              child: widget.icon,
            ),
          ),
        ),
      ),
    );
  }
}

extension on OptimusWidgetSize {
  double get containerSize => switch (this) {
        OptimusWidgetSize.small => 32,
        OptimusWidgetSize.medium => 40,
        OptimusWidgetSize.large => 48,
      };

  double get iconSize => switch (this) {
        OptimusWidgetSize.small => 16,
        OptimusWidgetSize.medium || OptimusWidgetSize.large => 24,
      };
}
