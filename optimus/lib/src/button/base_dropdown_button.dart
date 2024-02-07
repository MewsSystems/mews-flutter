import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/overlay_controller.dart';

class BaseDropDownButton<T> extends StatefulWidget {
  const BaseDropDownButton({
    super.key,
    this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.defaultButton,
    this.borderRadius,
  });

  /// Typically the button's label.
  final Widget? child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T>? onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;
  final BorderRadius? borderRadius;

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

  void _handleHoverChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

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
      ? tokens.bodyMediumStrong.copyWith(color: _textColor)
      : tokens.bodyLargeStrong.copyWith(color: _textColor);

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
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(context.tokens.borderRadius50);

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
        child: GestureWrapper(
          onHoverChanged: _handleHoverChanged,
          onPressedChanged: _handlePressedChanged,
          onTap: _node.requestFocus,
          child: Focus(
            focusNode: _node,
            child: SizedBox(
              height: widget.size.getValue(tokens),
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: tokens.spacing200),
                key: _selectFieldKey,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: borderRadius,
                  border: borderColor != null
                      ? Border.all(
                          color: borderColor,
                          width: context.tokens.borderWidth100,
                        )
                      : null,
                ),
                duration: buttonAnimationDuration,
                curve: buttonAnimationCurve,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (child != null)
                      Padding(
                        padding: EdgeInsets.only(right: tokens.spacing150),
                        child: DefaultTextStyle.merge(
                          style: _labelStyle,
                          child: child,
                        ),
                      ),
                    RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        OptimusIcons.chevron_down,
                        size: widget.size.getIconSize(tokens),
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
    );
  }
}

const double _dropdownWidth = 280;

extension on OptimusWidgetSize {
  double getIconSize(OptimusTokens tokens) =>
      this == OptimusWidgetSize.small ? tokens.sizing200 : tokens.sizing300;
}
