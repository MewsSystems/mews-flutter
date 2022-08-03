import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseDropDownButton<T> extends StatefulWidget {
  const BaseDropDownButton({
    Key? key,
    this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius50),
  }) : super(key: key);

  /// Typically the button's label.
  final Widget? child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T>? onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;
  final BorderRadius borderRadius;

  @override
  State<BaseDropDownButton<T>> createState() => _BaseDropDownButtonState<T>();
}

class _BaseDropDownButtonState<T> extends State<BaseDropDownButton<T>>
    with ThemeGetter, SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  final _selectFieldKey = GlobalKey();
  bool _isHovering = false;
  bool _isTappedDown = false;

  final _node = FocusNode();
  late final AnimationController _controller;
  late final Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.child;

    return OverlayController(
      items: widget.items,
      anchorKey: _selectFieldKey,
      onItemSelected: widget.onItemSelected ?? (_) {},
      focusNode: _node,
      width: _dropdownWidth,
      onShown: () => setState(() => _controller.forward()),
      onHidden: () => setState(() => _controller.reverse()),
      child: OptimusEnabled(
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
              child: SizedBox(
                height: widget.size.value,
                child: AnimatedContainer(
                  padding: const EdgeInsets.symmetric(horizontal: spacing200),
                  key: _selectFieldKey,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: widget.borderRadius,
                  ),
                  duration: buttonAnimationDuration,
                  curve: Curves.fastOutSlowIn,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (child != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: DefaultTextStyle.merge(
                            style: _labelStyle,
                            child: child,
                          ),
                        ),
                      RotationTransition(
                        turns: _iconTurns,
                        child: _icon,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool get _isEnabled => widget.onItemSelected != null;

  TextStyle get _labelStyle => widget.size == OptimusWidgetSize.small
      ? preset200b.copyWith(color: _textColor)
      : preset300b.copyWith(color: _textColor);

  // TODO(VG): can be changed when final dark theme design is ready.
  Color get _textColor {
    switch (widget.variant) {
      case OptimusDropdownButtonVariant.primary:
        return theme.colors.neutral0;
      case OptimusDropdownButtonVariant.defaultButton:
        return theme.colors.neutral500;
      case OptimusDropdownButtonVariant.text:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500;
    }
  }

  Color get _color => _node.hasFocus || _isTappedDown
      ? _highlightColor
      : _isHovering
          ? _hoverColor
          : _normalColor;

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
        OptimusIcons.chevron_down,
        size: widget.size.iconSize,
        color: _textColor,
      );
}

const double _dropdownWidth = 280;

extension on OptimusWidgetSize {
  double get iconSize {
    switch (this) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }
}
