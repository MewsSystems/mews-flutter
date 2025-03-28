import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';
import 'package:optimus/src/button/outlined_border.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';

enum OptimusSplitButtonVariant { primary, secondary, tertiary }

/// Split buttons have a main action and a dropdown action. The main action is
/// on the left. An arrow on the right opens a dropdown menu with more actions
/// related to the main action.
class OptimusSplitButton<T> extends StatefulWidget {
  const OptimusSplitButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusSplitButtonVariant.tertiary,
  });

  /// Typically the button's label.
  final Widget child;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// List of items in dropdown section (when pressed on the button's right
  /// part).
  final List<OptimusDropdownTile<T>> items;

  /// Called when dropdown item is selected.
  final ValueSetter<T>? onItemSelected;

  /// The size of the button
  final OptimusWidgetSize size;

  /// The variant of the button.
  final OptimusSplitButtonVariant variant;

  @override
  State<OptimusSplitButton<T>> createState() => _OptimusSplitButtonState<T>();
}

class _OptimusSplitButtonState<T> extends State<OptimusSplitButton<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final borderRadius = tokens.borderRadius100;
    final dividerColor = widget.variant.toButtonVariant().getBorderColor(
      tokens,
      isEnabled: widget.onPressed != null,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    return GestureWrapper(
      onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
      onPressedChanged: (isPressed) => setState(() => _isPressed = isPressed),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseButton(
            onPressed: widget.onPressed,
            variant: widget.variant.toButtonVariant(),
            borderRadius: BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
            ),
            size: widget.size,
            shapeBuilder:
                (borderRadius, borderSide) => CustomOutlinedBorder(
                  borderRadius: borderRadius,
                  borderSide: borderSide,
                  hasRight: false,
                ),
            child: widget.child,
          ),
          SizedBox(
            width: tokens.borderWidth150,
            height: widget.size.getValue(tokens),
            child: ColoredBox(color: dividerColor ?? Colors.transparent),
          ),
          BaseDropDownButton(
            items: widget.items,
            onItemSelected: widget.onItemSelected,
            variant: widget.variant.toDropdownButtonVariant(),
            borderRadius: BorderRadius.only(
              topRight: borderRadius,
              bottomRight: borderRadius,
            ),
            borderBuilder:
                (color) => Border(
                  top: BorderSide(color: color, width: tokens.borderWidth150),
                  right: BorderSide(color: color, width: tokens.borderWidth150),
                  bottom: BorderSide(
                    color: color,
                    width: tokens.borderWidth150,
                  ),
                ),
            size: widget.size,
          ),
        ],
      ),
    );
  }
}

extension on OptimusSplitButtonVariant {
  BaseButtonVariant toButtonVariant() => switch (this) {
    OptimusSplitButtonVariant.primary => BaseButtonVariant.primary,
    OptimusSplitButtonVariant.secondary => BaseButtonVariant.secondary,
    OptimusSplitButtonVariant.tertiary => BaseButtonVariant.tertiary,
  };

  OptimusDropdownButtonVariant toDropdownButtonVariant() => switch (this) {
    OptimusSplitButtonVariant.primary => OptimusDropdownButtonVariant.primary,
    OptimusSplitButtonVariant.secondary =>
      OptimusDropdownButtonVariant.secondary,
    OptimusSplitButtonVariant.tertiary => OptimusDropdownButtonVariant.tertiary,
  };
}
