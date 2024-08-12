import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/checkbox/checkbox_tick.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/radio/circle.dart';
import 'package:optimus/src/radio/state.dart';

enum OptimusSelectionCardVariant { vertical, horizontal }

enum OptimusSelectionCardBorderRadius { small, medium }

enum OptimusSelectionCardSelectionVariant { radio, checkbox }

class OptimusSelectionCard extends StatefulWidget {
  const OptimusSelectionCard({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.variant = OptimusSelectionCardVariant.horizontal,
    this.borderRadius = OptimusSelectionCardBorderRadius.medium,
    this.selectionVariant = OptimusSelectionCardSelectionVariant.radio,
    this.isSelected = false,
    this.showSelector = true,
    this.isEnabled = true,
    this.onPressed,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final OptimusSelectionCardVariant variant;
  final OptimusSelectionCardBorderRadius borderRadius;
  final OptimusSelectionCardSelectionVariant selectionVariant;
  final bool isSelected;
  final bool showSelector;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  State<OptimusSelectionCard> createState() => _OptimusSelectionCardState();
}

class _OptimusSelectionCardState extends State<OptimusSelectionCard>
    with ThemeGetter {
  final _controller = WidgetStatesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _InteractiveStateColor get _backgroundColor => _InteractiveStateColor(
        defaultColor: widget.isSelected
            ? tokens.backgroundInteractiveSecondaryDefault
            : tokens.backgroundStaticFlat,
        disabled: tokens.backgroundStaticFlat,
        pressed: widget.isSelected
            ? tokens.backgroundInteractiveSecondaryActive
            : tokens.backgroundStaticFlat,
        hovered: widget.isSelected
            ? tokens.backgroundInteractiveSecondaryHover
            : tokens.backgroundStaticFlat,
      );

  _InteractiveStateColor get _borderColor => _InteractiveStateColor(
        defaultColor: widget.isSelected
            ? tokens.borderInteractivePrimaryDefault
            : tokens.borderInteractiveSecondaryDefault,
        disabled: tokens.borderDisabled,
        pressed: widget.isSelected
            ? tokens.borderInteractivePrimaryActive
            : tokens.borderInteractiveSecondaryActive,
        hovered: widget.isSelected
            ? tokens.borderInteractivePrimaryHover
            : tokens.borderInteractiveSecondaryHover,
      );

  _InteractiveStateColor get _titleColor => _InteractiveStateColor(
        defaultColor: tokens.textStaticPrimary,
        disabled: tokens.textDisabled,
        pressed: tokens.textStaticPrimary,
        hovered: tokens.textStaticPrimary,
      );

  _InteractiveStateColor get _descriptionColor => _InteractiveStateColor(
        defaultColor: tokens.textStaticTertiary,
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

          final selector = widget.selectionVariant ==
                  OptimusSelectionCardSelectionVariant.radio
              ? RadioCircle(
                  state: RadioState.basic,
                  isSelected: widget.isSelected,
                )
              : CheckboxTick(
                  isEnabled: widget.isEnabled,
                  isChecked: widget.isSelected,
                  onChanged: (_) {},
                  onTap: () {},
                );

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
                    if (widget.showSelector) selector,
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
                          SizedBox(height: tokens.spacing25),
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
                    if (widget.trailing case final trailing?)
                      IconTheme.merge(
                        child: trailing,
                        data: IconThemeData(color: titleColor),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _InteractiveStateColor extends WidgetStateProperty<Color> {
  _InteractiveStateColor({
    required this.defaultColor,
    required this.disabled,
    required this.pressed,
    required this.hovered,
  });

  final Color disabled;
  final Color pressed;
  final Color hovered;
  final Color defaultColor;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.isDisabled) return disabled;
    if (states.isPressed) return pressed;
    if (states.isHovered) return hovered;

    return defaultColor;
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
