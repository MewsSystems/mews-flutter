import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/dropdown/common.dart';
import 'package:optimus/src/dropdown/dropdown_size_data.dart';

typedef BorderBuilder = Border Function(Color color);

class BaseDropDownButton<T> extends StatefulWidget {
  const BaseDropDownButton({
    super.key,
    this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.tertiary,
    this.borderRadius,
    this.borderBuilder,
    this.semanticLabel,
    this.dropdownWidth = 280.0,
    this.maxDropdownHeight = 300.0,
    this.emptyList,
  });

  final Widget? child;
  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T>? onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;
  final BorderRadius? borderRadius;
  final BorderBuilder? borderBuilder;
  final String? semanticLabel;
  // ignore: avoid-unnecessary-nullable-fields, width can be null for cases where we want to use the button width instead of a fixed width
  final double? dropdownWidth;
  final double maxDropdownHeight;
  final Widget? emptyList;

  @override
  State<BaseDropDownButton<T>> createState() => _BaseDropDownButtonState<T>();
}

class _BaseDropDownButtonState<T> extends State<BaseDropDownButton<T>>
    with ThemeGetter, SingleTickerProviderStateMixin {
  final _layerLink = LayerLink();
  final _overlayController = OverlayPortalController();

  void _handleToggleDropdown() {
    if (_overlayController.isShowing) {
      _hideDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    if (_overlayController.isShowing) return;

    _overlayController.show();
  }

  void _hideDropdown() {
    if (!_overlayController.isShowing) return;

    _overlayController.hide();
  }

  void _handleCloseDropdown() => _hideDropdown();

  void _handleItemSelected(T value) {
    widget.onItemSelected?.call(value);
    _hideDropdown();
  }

  @override
  Widget build(BuildContext context) => DropdownSizeData(
    size: widget.size,
    child: OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (context) {
        final renderObject = context.findRenderObject();
        if (renderObject is! RenderBox) {
          return const SizedBox.shrink();
        }
        final renderBox = renderObject;

        final buttonPosition = renderBox.localToGlobal(Offset.zero);
        final buttonSize = renderBox.size;
        final screenSize = MediaQuery.sizeOf(context);
        final screenPadding = MediaQuery.paddingOf(context);

        final width = widget.dropdownWidth ?? buttonSize.width;

        final spaceBelow =
            screenSize.height -
            buttonPosition.dy -
            buttonSize.height -
            screenPadding.bottom;
        final spaceAbove = buttonPosition.dy - screenPadding.top;

        final isOnTop =
            spaceBelow < widget.maxDropdownHeight && spaceAbove > spaceBelow;

        final spaceRight =
            screenSize.width - buttonPosition.dx - screenPadding.right;
        final spaceLeft = buttonPosition.dx - screenPadding.left;

        final shouldAlignRight = spaceRight < width && spaceLeft >= width;

        final offset = Offset(
          0,
          isOnTop ? -context.menuOffset : context.menuOffset,
        );

        final targetAnchor = isOnTop
            ? (shouldAlignRight ? Alignment.topRight : Alignment.topLeft)
            : (shouldAlignRight ? Alignment.bottomRight : Alignment.bottomLeft);
        final followerAnchor = isOnTop
            ? (shouldAlignRight ? Alignment.bottomRight : Alignment.bottomLeft)
            : (shouldAlignRight ? Alignment.topRight : Alignment.topLeft);

        final maxHeight = isOnTop
            ? spaceAbove.clamp(100.0, widget.maxDropdownHeight)
            : spaceBelow.clamp(100.0, widget.maxDropdownHeight);

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _handleCloseDropdown,
                child: Container(color: Colors.transparent),
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: offset,
              targetAnchor: targetAnchor,
              followerAnchor: followerAnchor,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: width,
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(tokens.borderRadius100),
                    color: tokens.backgroundStaticFloating,
                    boxShadow: tokens.shadow200,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.listHorizontalPadding,
                    ),
                    // ignore: avoid-single-child-column-or-row, we want to shrink the view without using shrinkWrap
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.items.isEmpty)
                          widget.emptyList ?? const SizedBox.shrink()
                        else
                          Flexible(
                            child: OptimusScrollConfiguration(
                              child: ListView.builder(
                                reverse: isOnTop,
                                itemCount: widget.items.length,
                                itemBuilder: (context, index) {
                                  final item = widget.items[index];

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: context.verticalSpacing,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                          tokens.borderRadius100,
                                        ),
                                        hoverColor: tokens
                                            .backgroundInteractiveNeutralHover,
                                        splashColor: tokens
                                            .backgroundInteractiveNeutralActive,
                                        highlightColor: tokens
                                            .backgroundInteractiveNeutralActive,
                                        onTap: () =>
                                            _handleItemSelected(item.value),
                                        child: Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(
                                            tokens.spacing50,
                                          ),
                                          child: item,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: _DropdownButton(
          isEnabled: widget.onItemSelected != null,
          semanticLabel: widget.semanticLabel,
          size: widget.size,
          variant: widget.variant,
          borderRadius: widget.borderRadius,
          borderBuilder: widget.borderBuilder,
          onTap: widget.onItemSelected != null ? _handleToggleDropdown : null,
          color: widget.variant.toBaseVariant().getBackgroundColor(
            tokens,
            isEnabled: widget.onItemSelected != null,
            isPressed: false,
            isHovered: false,
          ),
          child: widget.child,
        ),
      ),
    ),
  );
}

class _DropdownButton extends StatefulWidget {
  const _DropdownButton({
    required this.isEnabled,
    this.semanticLabel,
    required this.size,
    required this.variant,
    this.borderRadius,
    this.borderBuilder,
    this.child,
    this.onTap,
    this.color,
  });

  final bool isEnabled;
  final String? semanticLabel;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;
  final BorderRadius? borderRadius;
  final BorderBuilder? borderBuilder;
  final Widget? child;
  final VoidCallback? onTap;
  final Color? color;

  @override
  State<_DropdownButton> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<_DropdownButton>
    with ThemeGetter, SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  bool _isTurned = false;

  late final AnimationController _controller;
  late final Animation<double> _iconTurns;

  static final Animatable<double> _easeInTween = CurveTween(
    curve: Curves.fastOutSlowIn,
  );
  static final Animatable<double> _halfTween = Tween<double>(
    begin: 0,
    end: 0.5,
  );

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

  bool get _isEnabled => widget.onTap != null;

  void _handleHoverChanged({required bool isHovered}) =>
      setState(() => _isHovered = isHovered);

  void _handlePressedChanged({required bool isPressed}) =>
      setState(() => _isPressed = isPressed);

  TextStyle get _labelStyle => widget.size == OptimusWidgetSize.small
      ? tokens.bodyMediumStrong.copyWith(color: _textColor)
      : tokens.bodyLargeStrong.copyWith(color: _textColor);

  Color? get _color => widget.variant.toBaseVariant().getBackgroundColor(
    tokens,
    isEnabled: _isEnabled,
    isPressed: _isPressed,
    isHovered: _isHovered,
  );

  Color get _textColor => widget.variant.toBaseVariant().getForegroundColor(
    tokens,
    isEnabled: _isEnabled,
    isPressed: _isPressed,
    isHovered: _isHovered,
  );

  Color? get _borderColor => widget.variant.toBaseVariant().getBorderColor(
    tokens,
    isHovered: _isHovered,
    isPressed: _isPressed,
    isEnabled: _isEnabled,
  );

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final borderColor = _borderColor;
    final borderRadius =
        widget.borderRadius ?? BorderRadius.all(tokens.borderRadius100);
    final border = borderColor != null
        ? (widget.borderBuilder?.let((it) => it(borderColor)) ??
              Border.all(color: borderColor, width: context.borderWidth))
        : null;

    return IgnorePointer(
      ignoring: !_isEnabled,
      child: Semantics(
        label: widget.semanticLabel,
        button: true,
        child: GestureWrapper(
          onHoverChanged: (isHovered) =>
              _handleHoverChanged(isHovered: isHovered),
          onPressedChanged: (isPressed) =>
              _handlePressedChanged(isPressed: isPressed),
          onTap: widget.onTap,
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(
              horizontal: widget.size.getHorizontalPadding(tokens),
              vertical: widget.size.getVerticalPadding(tokens),
            ),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: borderRadius,
              border: border,
            ),
            duration: buttonAnimationDuration,
            curve: buttonAnimationCurve,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.child case final child?)
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
    );
  }
}

extension on BuildContext {
  double get menuOffset => tokens.spacing50;
}

extension on OptimusWidgetSize {
  double getIconSize(OptimusTokens tokens) =>
      this == OptimusWidgetSize.small ? tokens.sizing200 : tokens.sizing300;
}
