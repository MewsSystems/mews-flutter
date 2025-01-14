import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/checkbox/checkbox_tick.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/state_property.dart';
import 'package:optimus/src/radio/radio_circle.dart';

enum OptimusSelectionCardVariant { vertical, horizontal }

enum OptimusSelectionCardBorderRadius { small, medium }

enum OptimusSelectionCardSelectionVariant { radio, checkbox }

/// A card that represents a choice. Depending on the [selectionVariant], it can
/// be a radio button or a checkbox, hence single or multiple selection.
/// The card consists of a title, an optional description, and an optional
/// trailing widget.
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
    this.isSelectorVisible = true,
    this.isEnabled = true,
    this.onPressed,
  });

  /// The title of the card.
  final Widget title;

  /// The description of the card.
  final Widget? description;

  /// The trailing widget of the card.
  final Widget? trailing;

  /// The variant of the card. Default is [OptimusSelectionCardVariant.horizontal].
  final OptimusSelectionCardVariant variant;

  /// The border radius of the card. Default is [OptimusSelectionCardBorderRadius.medium].
  final OptimusSelectionCardBorderRadius borderRadius;

  /// The selection variant of the card. Default is [OptimusSelectionCardSelectionVariant.radio].
  final OptimusSelectionCardSelectionVariant selectionVariant;

  /// Whether the card is selected. Default is false.
  final bool isSelected;

  /// Whether the selector is shown. Default is true.
  final bool isSelectorVisible;

  /// Whether the card is enabled. Default is true.
  final bool isEnabled;

  /// The callback that is called when the card is pressed.
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

  InteractiveStateColor get _backgroundColor => InteractiveStateColor(
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

  InteractiveStateColor get _borderColor => InteractiveStateColor(
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

  InteractiveStateColor get _titleColor => InteractiveStateColor(
        defaultColor: tokens.textStaticPrimary,
        disabled: tokens.textDisabled,
        pressed: tokens.textStaticPrimary,
        hovered: tokens.textStaticPrimary,
      );

  InteractiveStateColor get _descriptionColor => InteractiveStateColor(
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
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: !widget.isEnabled,
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final backgroundColor = _backgroundColor.resolve(_controller.value);
            final borderColor = _borderColor.resolve(_controller.value);
            final titleColor = _titleColor.resolve(_controller.value);
            final descriptionColor =
                _descriptionColor.resolve(_controller.value);

            final selector = widget.isSelectorVisible
                ? switch (widget.selectionVariant) {
                    OptimusSelectionCardSelectionVariant.radio => RadioCircle(
                        controller: _controller,
                        isSelected: widget.isSelected,
                      ),
                    OptimusSelectionCardSelectionVariant.checkbox =>
                      CheckboxTick(
                        isEnabled: widget.isEnabled,
                        isChecked: widget.isSelected,
                        onChanged: (_) {},
                        onTap: () {},
                      )
                  }
                : null;

            final title = DefaultTextStyle.merge(
              child: widget.title,
              style: tokens.bodyLargeStrong.copyWith(color: titleColor),
            );

            final Widget? description = widget.description?.let(
              (it) => DefaultTextStyle.merge(
                child: it,
                style: tokens.bodyMedium.copyWith(color: descriptionColor),
              ),
            );

            final Widget? trailing = widget.trailing?.let(
              (it) => IconTheme.merge(
                child: it,
                data: IconThemeData(color: titleColor),
              ),
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
                child: switch (widget.variant) {
                  OptimusSelectionCardVariant.horizontal => _HorizontalCard(
                      title: title,
                      description: description,
                      trailing: trailing,
                      isSelected: widget.isSelected,
                      selector: selector,
                    ),
                  OptimusSelectionCardVariant.vertical => _VerticalCard(
                      title: title,
                      description: description,
                      trailing: trailing,
                      isSelected: widget.isSelected,
                      selector: selector,
                    )
                },
              ),
            );
          },
        ),
      );
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.title,
    this.description,
    this.trailing,
    required this.isSelected,
    this.selector,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final Widget? selector;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selector case final selector?) selector,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: tokens.spacing200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(child: title),
                  SizedBox(height: tokens.spacing25),
                  if (description case final description?)
                    Flexible(child: description),
                ],
              ),
            ),
          ),
          if (trailing case final trailing?) trailing,
        ],
      ),
    );
  }
}

class _VerticalCard extends StatelessWidget {
  const _VerticalCard({
    required this.title,
    this.description,
    this.trailing,
    required this.isSelected,
    this.selector,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final bool isSelected;
  final Widget? selector;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          if (selector case final selector?)
            Positioned(
              right: context.tokens.spacing100,
              top: context.tokens.spacing100,
              child: selector,
            ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.tokens.spacing200,
              vertical: context.tokens.spacing400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailing case final trailing?) trailing,
                SizedBox(
                  height: context.tokens.spacing200,
                  width: context.tokens.sizing1300,
                ),
                Flexible(child: title),
                SizedBox(height: context.tokens.spacing50),
                if (description case final description?)
                  Flexible(child: description),
              ],
            ),
          ),
        ],
      );
}

extension on OptimusSelectionCardBorderRadius {
  Radius getBorderRadius(OptimusTokens tokens) => switch (this) {
        OptimusSelectionCardBorderRadius.small => tokens.borderRadius100,
        OptimusSelectionCardBorderRadius.medium => tokens.borderRadius200
      };
}
