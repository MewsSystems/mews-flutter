import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/button/outlined_border.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/semantics.dart';

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
    this.semanticLabel,
    this.dropdownSemanticLabel,
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

  /// The semantic label of the button. This label is used by screen readers to
  /// provide a description of the button's purpose. We suggest using a concise
  /// and descriptive label that accurately reflects the button's function.
  final String? semanticLabel;

  /// The semantic label of the dropdown button. This label is used by screen
  /// readers to provide a description of the dropdown button's purpose. We
  /// suggest using a concise and descriptive label that accurately reflects the
  /// dropdown button's function.
  final String? dropdownSemanticLabel;

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
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: .min,
          children: [
            BaseButton(
              onPressed: widget.onPressed,
              semanticLabel: widget.semanticLabel,
              variant: widget.variant.toButtonVariant(),
              borderRadius: .only(
                topLeft: borderRadius,
                bottomLeft: borderRadius,
              ),
              size: widget.size,
              shapeBuilder: (borderRadius, borderSide) => CustomOutlinedBorder(
                borderRadius: borderRadius,
                borderSide: borderSide,
                hasRight: false,
              ),
              child: widget.child,
            ),
            Container(
              width: context.borderWidth,
              color: dividerColor ?? Colors.transparent,
            ).excludeSemantics(),
            BaseDropDownButton(
              items: widget.items,
              onItemSelected: widget.onItemSelected,
              variant: widget.variant.toDropdownButtonVariant(),
              semanticLabel: widget.dropdownSemanticLabel,
              borderRadius: .only(
                topRight: borderRadius,
                bottomRight: borderRadius,
              ),
              borderBuilder: (color) => Border(
                top: BorderSide(color: color, width: context.borderWidth),
                right: BorderSide(color: color, width: context.borderWidth),
                bottom: BorderSide(color: color, width: context.borderWidth),
              ),
              size: widget.size,
            ),
          ],
        ),
      ),
    );
  }
}

extension on OptimusSplitButtonVariant {
  BaseButtonVariant toButtonVariant() => switch (this) {
    .primary => .primary,
    .secondary => .secondary,
    .tertiary => .tertiary,
  };

  OptimusDropdownButtonVariant toDropdownButtonVariant() => switch (this) {
    .primary => .primary,
    .secondary => .secondary,
    .tertiary => .tertiary,
  };
}
