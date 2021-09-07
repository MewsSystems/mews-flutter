import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusIconButtonVariant {
  /// Used in most scenarios when there is no prior action necessary.
  defaultButton,

  /// Used for main actions with prior actions on the same page or module.
  primary,

  /// Used for non-crucial, complementary, or tertiary actions.
  text,

  /// Used to confirm destructive actions the user can’t take back,
  /// like deletion.
  destructive,

  /// Used for quick actions. The float variant is always above other content
  /// and visible in the current viewport.
  ///
  /// Usually placed in the bottom-right corner and useful for small screens.
  float,

  /// The Bare Icon button is a stripped-down version of the Icon button.
  ///
  /// Used in components like Inputs, Selects, and Modals, or situations
  /// where the container, and its effects, are not required or desired.
  bare,
}

/// When you don’t have enough space for regular buttons, or the action is
/// clear enough, you can use an icon button without text.
class OptimusIconButton extends StatefulWidget {
  const OptimusIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusIconButtonVariant.defaultButton,
  }) : super(key: key);

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Typically [Icon] widget.
  final Widget icon;

  /// Button size.
  final OptimusWidgetSize size;

  /// Button type.
  final OptimusIconButtonVariant variant;

  @override
  _OptimusIconButtonState createState() => _OptimusIconButtonState();
}

class _OptimusIconButtonState extends State<OptimusIconButton>
    with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  @override
  Widget build(BuildContext context) => OptimusEnabled(
        isEnabled: widget.onPressed != null,
        child: MouseRegion(
          onEnter: (_) => _onHoverChanged(true),
          onExit: (_) => _onHoverChanged(false),
          child: GestureDetector(
            onTap: widget.onPressed,
            onTapDown: (_) => setState(() => _isTappedDown = true),
            onTapUp: (_) => setState(() => _isTappedDown = false),
            onTapCancel: () => setState(() => _isTappedDown = false),
            child: AnimatedContainer(
              height: _containerSize,
              width: _containerSize,
              padding: EdgeInsets.zero,
              decoration: _decoration,
              duration: buttonAnimationDuration,
              child: IconTheme.merge(
                data: IconThemeData(color: _iconColor, size: _iconSize),
                child: widget.icon,
              ),
            ),
          ),
        ),
      );

  Decoration get _decoration => widget.variant == OptimusIconButtonVariant.float
      ? BoxDecoration(
          shape: BoxShape.circle,
          color: _color,
          boxShadow: elevation50,
        )
      : BoxDecoration(
          color: _color,
          borderRadius: const BorderRadius.all(borderRadius50),
        );

  double get _containerSize {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return 32;
      case OptimusWidgetSize.medium:
        return 40;
      case OptimusWidgetSize.large:
        return 48;
    }
  }

  Color get _color => _isTappedDown
      ? _highlightColor
      : _isHovering
          ? _hoverColor
          : _normalColor;

  Color get _normalColor {
    switch (widget.variant) {
      case OptimusIconButtonVariant.defaultButton:
        return theme.colors.neutral50;
      case OptimusIconButtonVariant.primary:
        return theme.colors.primary500;
      case OptimusIconButtonVariant.text:
        return Colors.transparent;
      case OptimusIconButtonVariant.destructive:
        return theme.colors.danger500;
      case OptimusIconButtonVariant.float:
        return theme.colors.primary500;
      case OptimusIconButtonVariant.bare:
        return Colors.transparent;
    }
  }

  Color get _hoverColor {
    switch (widget.variant) {
      case OptimusIconButtonVariant.defaultButton:
        return theme.colors.neutral100;
      case OptimusIconButtonVariant.primary:
        return theme.colors.primary700;
      case OptimusIconButtonVariant.text:
        return theme.colors.neutral500t8;
      case OptimusIconButtonVariant.destructive:
        return theme.colors.danger700;
      case OptimusIconButtonVariant.float:
        return theme.colors.primary700;
      case OptimusIconButtonVariant.bare:
        return Colors.transparent;
    }
  }

  Color get _highlightColor {
    switch (widget.variant) {
      case OptimusIconButtonVariant.defaultButton:
        return theme.colors.neutral200;
      case OptimusIconButtonVariant.primary:
        return theme.colors.primary900;
      case OptimusIconButtonVariant.text:
        return theme.colors.neutral500t16;
      case OptimusIconButtonVariant.destructive:
        return theme.colors.danger900;
      case OptimusIconButtonVariant.float:
        return theme.colors.primary900;
      case OptimusIconButtonVariant.bare:
        return Colors.transparent;
    }
  }

  double get _iconSize {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  Color get _iconColor {
    switch (widget.variant) {
      case OptimusIconButtonVariant.primary:
      case OptimusIconButtonVariant.destructive:
      case OptimusIconButtonVariant.float:
        return theme.colors.neutral0;
      case OptimusIconButtonVariant.defaultButton:
        return theme.colors.neutral500;
      case OptimusIconButtonVariant.text:
        // TODO(V): can be changed when final dark theme design is ready.
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
      case OptimusIconButtonVariant.bare:
        return _bareIconColor;
    }
  }

  // TODO(V): can be changed when final dark theme design is ready.
  Color get _bareIconColor =>
      theme.isDark ? _bareIconColorDark : _bareIconColorLight;

  Color get _bareIconColorLight => _isTappedDown
      ? theme.colors.neutral1000
      : _isHovering
          ? theme.colors.neutral700
          : theme.colors.neutral500;

  Color get _bareIconColorDark => _isTappedDown
      ? theme.colors.neutral100
      : _isHovering
          ? theme.colors.neutral50
          : theme.colors.neutral0;
}
