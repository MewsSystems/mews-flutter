import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusIconButtonType {
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
    Key key,
    this.onPressed,
    @required this.icon,
    this.size = OptimusWidgetSize.large,
    this.type = OptimusIconButtonType.defaultButton,
  }) : super(key: key);

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback onPressed;

  /// Typically [Icon] widget.
  final Widget icon;

  /// Button size.
  final OptimusWidgetSize size;

  /// Button type.
  final OptimusIconButtonType type;

  @override
  _OptimusIconButtonState createState() => _OptimusIconButtonState();
}

class _OptimusIconButtonState extends State<OptimusIconButton> {
  bool _isHovering = false;
  bool _isTappedDown = false;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  @override
  Widget build(BuildContext context) => Enabled(
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

  Decoration get _decoration => widget.type == OptimusIconButtonType.float
      ? BoxDecoration(shape: BoxShape.circle, color: _color)
      : BoxDecoration(
          color: _color,
          borderRadius: const BorderRadius.all(borderRadius50),
        );

  // ignore: missing_return
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

  // ignore: missing_return
  Color get _normalColor {
    switch (widget.type) {
      case OptimusIconButtonType.defaultButton:
        return OptimusColors.neutral50;
      case OptimusIconButtonType.primary:
        return OptimusColors.primary500;
      case OptimusIconButtonType.text:
        return Colors.transparent;
      case OptimusIconButtonType.destructive:
        return OptimusColors.danger500;
      case OptimusIconButtonType.float:
        return OptimusColors.primary500;
      case OptimusIconButtonType.bare:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  Color get _hoverColor {
    switch (widget.type) {
      case OptimusIconButtonType.defaultButton:
        return OptimusColors.neutral100;
      case OptimusIconButtonType.primary:
        return OptimusColors.primary700;
      case OptimusIconButtonType.text:
        return OptimusColors.neutral500t8;
      case OptimusIconButtonType.destructive:
        return OptimusColors.danger700;
      case OptimusIconButtonType.float:
        return OptimusColors.primary700;
      case OptimusIconButtonType.bare:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  Color get _highlightColor {
    switch (widget.type) {
      case OptimusIconButtonType.defaultButton:
        return OptimusColors.neutral200;
      case OptimusIconButtonType.primary:
        return OptimusColors.primary900;
      case OptimusIconButtonType.text:
        return OptimusColors.neutral500t16;
      case OptimusIconButtonType.destructive:
        return OptimusColors.danger900;
      case OptimusIconButtonType.float:
        return OptimusColors.primary900;
      case OptimusIconButtonType.bare:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  double get _iconSize {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  // ignore: missing_return
  Color get _iconColor {
    switch (widget.type) {
      case OptimusIconButtonType.primary:
      case OptimusIconButtonType.destructive:
      case OptimusIconButtonType.float:
        return OptimusColors.neutral0;
      case OptimusIconButtonType.defaultButton:
      case OptimusIconButtonType.text:
        return OptimusColors.neutral500;
      case OptimusIconButtonType.bare:
        return _bareIconColor;
    }
  }

  Color get _bareIconColor => _isTappedDown
      ? OptimusColors.neutral1000
      : _isHovering
          ? OptimusColors.neutral700
          : OptimusColors.neutral500;
}
