import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/widget_size.dart';

class BaseDropDownButton<T> extends StatefulWidget {
  const BaseDropDownButton({
    Key key,
    this.child,
    @required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius50),
  }) : super(key: key);

  /// Typically the button's label.
  final Widget child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;
  final BorderRadius borderRadius;

  @override
  _BaseDropDownButtonState createState() => _BaseDropDownButtonState<T>();
}

class _BaseDropDownButtonState<T> extends State<BaseDropDownButton<T>>
    with ThemeGetter {
  final _selectFieldKey = GlobalKey();
  bool _isHovering = false;
  bool _isTappedDown = false;
  bool _isOpened = false;
  final _node = FocusNode();

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  @override
  Widget build(BuildContext context) => OverlayController(
        items: widget.items,
        anchorKey: _selectFieldKey,
        onItemSelected: widget.onItemSelected,
        focusNode: _node,
        width: _dropdownWidth,
        onShown: () => setState(() => _isOpened = true),
        onHidden: () => setState(() => _isOpened = false),
        child: Enabled(
          isEnabled: _isEnabled,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: _node.requestFocus,
              onTapDown: (_) => setState(() => _isTappedDown = true),
              onTapUp: (_) => setState(() => _isTappedDown = false),
              onTapCancel: () => setState(() => _isTappedDown = false),
              child: Focus(
                focusNode: _node,
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: spacing200),
                  height: widget.size.value,
                  key: _selectFieldKey,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: widget.borderRadius,
                  ),
                  duration: buttonAnimationDuration,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.child != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: DefaultTextStyle.merge(
                            style: _labelStyle,
                            child: widget.child,
                          ),
                        ),
                      _icon,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  bool get _isEnabled => widget.onItemSelected != null;

  TextStyle get _labelStyle => widget.size == OptimusWidgetSize.small
      ? preset200s.copyWith(color: _textColor, height: 1.3)
      : preset300s.copyWith(color: _textColor, height: 1.3);

  // TODO(VG): can be changed when final dark theme design is ready.
  // ignore: missing_return
  Color get _textColor {
    switch (widget.variant) {
      case OptimusDropdownButtonVariant.primary:
        return theme.colors.invertedTextColor;
      case OptimusDropdownButtonVariant.defaultButton:
        return theme.colors.neutral500;
      case OptimusDropdownButtonVariant.text:
        return theme.isDark
            ? theme.colors.invertedTextColor
            : theme.colors.neutral500;
    }
  }

  Color get _color => _node.hasFocus || _isTappedDown
      ? _highlightColor
      : _isHovering
          ? _hoverColor
          : _normalColor;

  // ignore: missing_return
  Color get _normalColor {
    switch (widget.variant) {
      case OptimusDropdownButtonVariant.defaultButton:
        return theme.colors.neutral50;
      case OptimusDropdownButtonVariant.primary:
        return theme.colors.primary500;
      case OptimusDropdownButtonVariant.text:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  Color get _hoverColor {
    switch (widget.variant) {
      case OptimusDropdownButtonVariant.defaultButton:
        return theme.colors.neutral100;
      case OptimusDropdownButtonVariant.primary:
        return theme.colors.primary700;
      case OptimusDropdownButtonVariant.text:
        return theme.colors.neutral500t8;
    }
  }

  // ignore: missing_return
  Color get _highlightColor {
    switch (widget.variant) {
      case OptimusDropdownButtonVariant.defaultButton:
        return theme.colors.neutral200;
      case OptimusDropdownButtonVariant.primary:
        return theme.colors.primary900;
      case OptimusDropdownButtonVariant.text:
        return theme.colors.neutral500t16;
    }
  }

  Icon get _icon => Icon(
        _isOpened ? OptimusIcons.chevron_up_1 : OptimusIcons.chevron_down_1,
        size: widget.size == OptimusWidgetSize.small ? 16 : 24,
        color: _textColor,
      );
}

const double _dropdownWidth = 280;
