import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/text_scaling.dart';

/// When you don’t have enough space for regular buttons, or the action is
/// clear enough, you can use an icon button without text.
class OptimusIconButton extends StatefulWidget {
  const OptimusIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.primary,
    this.semanticLabel,
    this.semanticOnTapHint,
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

  /// A label for the button used by assistive technologies. We recommend using
  /// a concise description of the action that will be performed when the button
  /// is activated.
  final String? semanticLabel;

  /// A hint for assistive technologies that describes the action that will
  /// be performed when the button is tapped.
  final String? semanticOnTapHint;

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
  BaseButtonVariant get _variant => widget.variant.toBaseVariant();

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.variant.toBaseVariant().getBorderColor(
      tokens,
      isEnabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );
    final isEnabled = widget.onPressed != null;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: MergeSemantics(
        child: Semantics(
          label: widget.semanticLabel,
          button: true,
          enabled: _isEnabled,
          onTap: widget.onPressed,
          onTapHint: widget.semanticOnTapHint,
          child: GestureWrapper(
            onHoverChanged: _handleHoverChanged,
            onPressedChanged: _handlePressedChanged,
            onTap: widget.onPressed,
            child: AnimatedContainer(
              height: context.getContainerSize(widget.size),
              width: context.getContainerSize(widget.size),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: _variant.getBackgroundColor(
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
                  color: _variant.getForegroundColor(
                    tokens,
                    isEnabled: _isEnabled,
                    isPressed: _isPressed,
                    isHovered: _isHovered,
                  ),
                  size: context.getIconSize(widget.size),
                ),
                child: widget.icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on BuildContext {
  double getContainerSize(OptimusWidgetSize size) => switch (size) {
    OptimusWidgetSize.small => tokens.sizing400,
    OptimusWidgetSize.medium => tokens.sizing500,
    OptimusWidgetSize.large => tokens.sizing600,
    OptimusWidgetSize.extraLarge => tokens.sizing700,
  }.toScaled(this);

  double getIconSize(OptimusWidgetSize size) =>
      size == OptimusWidgetSize.small ? tokens.sizing200 : tokens.sizing300;
}
