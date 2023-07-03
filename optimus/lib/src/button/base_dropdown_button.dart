import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseDropDownButton<T> extends StatefulWidget {
  const BaseDropDownButton({
    super.key,
    this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius50),
  });

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
  final _node = FocusNode();
  bool _isHovered = false;
  bool _isPressed = false;
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
    _node.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _node
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  bool get _isEnabled => widget.onItemSelected != null;

  Color get _textColor => widget.variant.toButtonVariant().foregroundColor(
        tokens,
        isEnabled: _isEnabled,
        isPressed: _isPressed,
        isHovered: _isHovered,
      );

  Color? get _borderColor => widget.variant.toButtonVariant().borderColor(
        tokens,
        isHovered: _isHovered,
        isPressed: _isPressed,
        isEnabled: _isEnabled,
      );

  TextStyle get _labelStyle => widget.size == OptimusWidgetSize.small
      ? preset200b.copyWith(color: _textColor)
      : preset300b.copyWith(color: _textColor);

  Color? get _color => widget.variant.toButtonVariant().backgroundColor(
        tokens,
        isEnabled: _isEnabled,
        isPressed: _isPressed,
        isHovered: _isHovered,
      );

  @override
  Widget build(BuildContext context) {
    final child = widget.child;
    final borderColor = this._borderColor;

    return OverlayController(
      items: widget.items,
      anchorKey: _selectFieldKey,
      onItemSelected: widget.onItemSelected ?? (_) {},
      focusNode: _node,
      width: _dropdownWidth,
      onShown: _controller.forward,
      onHidden: _controller.reverse,
      child: IgnorePointer(
        ignoring: !_isEnabled,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _node.requestFocus,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
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
                    border: borderColor != null
                        ? Border.all(color: borderColor, width: 1)
                        : null,
                  ),
                  duration: buttonAnimationDuration,
                  curve: buttonAnimationCurve,
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
                        child: Icon(
                          OptimusIcons.chevron_down,
                          size: widget.size.iconSize,
                          color: _textColor,
                        ),
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
}

const double _dropdownWidth = 280;

extension on OptimusWidgetSize {
  double get iconSize => switch (this) {
        OptimusWidgetSize.small => 16,
        OptimusWidgetSize.medium || OptimusWidgetSize.large => 24,
      };
}
