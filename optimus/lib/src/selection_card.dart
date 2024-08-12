import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/radio/circle.dart';
import 'package:optimus/src/radio/state.dart';

enum OptimusSelectionCardVariant { vertical, horizontal }

enum OptimusSelectionCardBorderRadius { small, medium }

class OptimusSelectionCard extends StatefulWidget {
  const OptimusSelectionCard({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.variant = OptimusSelectionCardVariant.horizontal,
    this.borderRadius = OptimusSelectionCardBorderRadius.medium,
    this.isSelected = false,
    this.isEnabled = true,
    this.onPressed,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final OptimusSelectionCardVariant variant;
  final OptimusSelectionCardBorderRadius borderRadius;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  State<OptimusSelectionCard> createState() => _OptimusSelectionCardState();
}

class _OptimusSelectionCardState extends State<OptimusSelectionCard>
    with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;
  final _controller = WidgetStatesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _InteractiveStateColor get _backgroundColor => _InteractiveStateColor(
        tokens.backgroundStaticFlat.value,
        disabled: tokens.backgroundStaticFlat,
        pressed: tokens.backgroundStaticFlat,
        hovered: tokens.backgroundStaticFlat,
      );

  _InteractiveStateColor get _borderColor => _InteractiveStateColor(
        tokens.borderInteractiveSecondaryDefault.value,
        disabled: tokens.borderDisabled,
        pressed: tokens.borderInteractiveSecondaryActive,
        hovered: tokens.borderInteractiveSecondaryHover,
      );

  _InteractiveStateColor get _titleColor => _InteractiveStateColor(
        tokens.textStaticPrimary.value,
        disabled: tokens.textDisabled,
        pressed: tokens.textStaticPrimary,
        hovered: tokens.textStaticPrimary,
      );

  _InteractiveStateColor get _descriptionColor => _InteractiveStateColor(
        tokens.textStaticTertiary.value,
        disabled: tokens.textDisabled,
        pressed: tokens.textStaticTertiary,
        hovered: tokens.textStaticTertiary,
      );

  @override
  void didUpdateWidget(covariant OptimusSelectionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      _controller.update(WidgetState.disabled, !widget.isEnabled);
    }
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final backgroundColor = _backgroundColor.resolve(_controller.value);
          final borderColor = _borderColor.resolve(_controller.value);
          final titleColor = _titleColor.resolve(_controller.value);
          final descriptionColor = _descriptionColor.resolve(_controller.value);

          return GestureWrapper(
            onHoverChanged: (isHovered) =>
                _controller.update(WidgetState.hovered, isHovered),
            onPressedChanged: (isPressed) =>
                _controller.update(WidgetState.pressed, isPressed),
            onTap: widget.onPressed,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(
                  widget.borderRadius.getBorderRadius(tokens),
                ),
                border: Border.all(
                  color: borderColor,
                  width: tokens.borderWidth150,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(tokens.spacing200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RadioCircle(
                      state: RadioState.basic,
                      isSelected: widget.isSelected,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: tokens.spacing200),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultTextStyle.merge(
                            child: widget.title,
                            style: tokens.bodyLargeStrong
                                .copyWith(color: titleColor),
                          ),
                          if (widget.description case final description?)
                            DefaultTextStyle.merge(
                              child: description,
                              style: tokens.bodyMedium
                                  .copyWith(color: descriptionColor),
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    if (widget.trailing case final trailing?) trailing,
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _InteractiveStateColor extends WidgetStateColor {
  const _InteractiveStateColor(super.defaultValue,
      {required this.disabled, required this.pressed, required this.hovered})
      : _defaultColor = defaultValue;

  final Color disabled;
  final Color pressed;
  final Color hovered;
  final int _defaultColor;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.isDisabled) return disabled;
    if (states.isPressed) return pressed;
    if (states.isHovered) return hovered;

    return Color(_defaultColor);
  }
}

extension on Set<WidgetState> {
  bool get isDisabled => contains(WidgetState.disabled);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isHovered => contains(WidgetState.hovered);
}

extension on OptimusSelectionCardBorderRadius {
  Radius getBorderRadius(OptimusTokens tokens) {
    switch (this) {
      case OptimusSelectionCardBorderRadius.small:
        return tokens.borderRadius100;
      case OptimusSelectionCardBorderRadius.medium:
        return tokens.borderRadius200;
    }
  }
}
