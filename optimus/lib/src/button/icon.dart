import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';

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

  /// {@macro optimus.button.variant}
  final OptimusButtonVariant variant;

  @override
  State<OptimusIconButton> createState() => _OptimusIconButtonState();
}

class _OptimusIconButtonState extends State<OptimusIconButton>
    with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  void _handleHoverChanged(bool isHovering) =>
      setState(() => _isHovered = isHovering);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  bool get _isEnabled => widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final borderColor = widget.variant.borderColor(
      tokens,
      isEnabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );
    final isEnabled = widget.onPressed != null;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: GestureWrapper(
        onHoverChanged: _handleHoverChanged,
        onPressedChanged: _handlePressedChanged,
        onTap: widget.onPressed,
        child: AnimatedContainer(
          height: widget.size.getContainerSize(tokens),
          width: widget.size.getContainerSize(tokens),
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: widget.variant.backgroundColor(
              tokens,
              isEnabled: _isEnabled,
              isPressed: _isPressed,
              isHovered: _isHovered,
            ),
            border: borderColor != null
                ? Border.all(
                    color: borderColor,
                    width: tokens.borderWidth150,
                  )
                : null,
            borderRadius: BorderRadius.all(tokens.borderRadius100),
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
              size: widget.size.getIconSize(tokens),
            ),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}

extension on OptimusWidgetSize {
  double getContainerSize(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.sizing400,
        OptimusWidgetSize.medium => tokens.sizing500,
        OptimusWidgetSize.large => tokens.sizing600,
        OptimusWidgetSize.extraLarge => tokens.sizing700,
      };

  double getIconSize(OptimusTokens tokens) =>
      this == OptimusWidgetSize.small ? tokens.sizing200 : tokens.sizing300;
}
