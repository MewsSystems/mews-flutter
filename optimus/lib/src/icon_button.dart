import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusIconButtonType { defaultButton, primary, text, destructive, float, bare }

class OptimusIconButton extends StatefulWidget {
  const OptimusIconButton({
    Key key,
    this.onPressed,
    @required this.icon,
    this.size = OptimusWidgetSize.large,
    this.type = OptimusIconButtonType.defaultButton,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget icon;
  final OptimusWidgetSize size;
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
            child: Container(
              height: _containerSize,
              width: _containerSize,
              padding: EdgeInsets.zero,
              decoration: _decoration,
              child: IconTheme.merge(data: IconThemeData(color: _iconColor, size: _iconSize), child: widget.icon),
            ),
          ),
        ),
      );

  Decoration get _decoration => widget.type == OptimusIconButtonType.float
      ? BoxDecoration(shape: BoxShape.circle, color: _color)
      : BoxDecoration(color: _color, borderRadius: const BorderRadius.all(borderRadius50));

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
      ? _highLightColor
      : _isHovering
          ? _hoverColor
          : _normalColor;

  // ignore: missing_return
  Color get _normalColor {
    switch (widget.type) {
      case OptimusIconButtonType.defaultButton:
        return OptimusColors.basic50;
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
        return OptimusColors.basic100;
      case OptimusIconButtonType.primary:
        return OptimusColors.primary700;
      case OptimusIconButtonType.text:
        return OptimusColors.basic500t8;
      case OptimusIconButtonType.destructive:
        return OptimusColors.danger700;
      case OptimusIconButtonType.float:
        return OptimusColors.primary700;
      case OptimusIconButtonType.bare:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  Color get _highLightColor {
    switch (widget.type) {
      case OptimusIconButtonType.defaultButton:
        return OptimusColors.basic200;
      case OptimusIconButtonType.primary:
        return OptimusColors.primary900;
      case OptimusIconButtonType.text:
        return OptimusColors.basic500t16;
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

  Color get _iconColor {
    switch (widget.type) {
      case OptimusIconButtonType.primary:
      case OptimusIconButtonType.destructive:
      case OptimusIconButtonType.float:
        return OptimusColors.basic0;
      default:
        return OptimusColors.basic500;
    }
  }
}
