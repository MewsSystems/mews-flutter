import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';

enum OptimusSplitButtonVariant {
  primary,
  secondary,
  tertiary,
}

/// Split buttons have a main action and a dropdown action. The main action is
/// on the left. An arrow on the right opens a dropdown menu with more actions
/// related to the main action.
class OptimusSplitButton<T> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final borderRadius = Radius.circular(tokens.borderRadius100);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseButton(
          onPressed: onPressed,
          variant: variant.toButtonVariant(),
          borderRadius: BorderRadius.only(
            topLeft: borderRadius,
            bottomLeft: borderRadius,
          ),
          size: size,
          child: child,
        ),
        if (variant == OptimusSplitButtonVariant.primary)
          const SizedBox(width: 1),
        BaseDropDownButton(
          items: items,
          onItemSelected: onItemSelected,
          variant: variant.toDropdownButtonVariant(),
          borderRadius: BorderRadius.only(
            topRight: borderRadius,
            bottomRight: borderRadius,
          ),
          size: size,
        ),
      ],
    );
  }
}

extension on OptimusSplitButtonVariant {
  OptimusButtonVariant toButtonVariant() => switch (this) {
        OptimusSplitButtonVariant.primary => OptimusButtonVariant.primary,
        OptimusSplitButtonVariant.secondary => OptimusButtonVariant.secondary,
        OptimusSplitButtonVariant.tertiary => OptimusButtonVariant.tertiary,
      };

  OptimusDropdownButtonVariant toDropdownButtonVariant() => switch (this) {
        OptimusSplitButtonVariant.primary =>
          OptimusDropdownButtonVariant.primary,
        OptimusSplitButtonVariant.secondary =>
          OptimusDropdownButtonVariant.secondary,
        OptimusSplitButtonVariant.tertiary =>
          OptimusDropdownButtonVariant.tertiary,
      };
}
