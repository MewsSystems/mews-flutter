import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';

enum OptimusSplitButtonVariant {
  /// The default option used in most scenarios.
  defaultButton,

  /// Use this variant if you want to a primary, main action and
  /// related/similar actions to have the same priority.
  primary,
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
    this.variant = OptimusSplitButtonVariant.defaultButton,
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
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseButton(
            onPressed: onPressed,
            variant: _buttonVariant,
            borderRadius: const BorderRadius.only(
              topLeft: borderRadius50,
              bottomLeft: borderRadius50,
            ),
            size: size,
            child: child,
          ),
          const SizedBox(width: 1),
          BaseDropDownButton(
            items: items,
            onItemSelected: onItemSelected,
            variant: _dropdownButtonVariant,
            borderRadius: const BorderRadius.only(
              topRight: borderRadius50,
              bottomRight: borderRadius50,
            ),
            size: size,
          ),
        ],
      );

  OptimusButtonVariant get _buttonVariant => switch (variant) {
        OptimusSplitButtonVariant.defaultButton =>
          OptimusButtonVariant.defaultButton,
        OptimusSplitButtonVariant.primary => OptimusButtonVariant.primary,
      };

  OptimusDropdownButtonVariant get _dropdownButtonVariant => switch (variant) {
        OptimusSplitButtonVariant.defaultButton =>
          OptimusDropdownButtonVariant.defaultButton,
        OptimusSplitButtonVariant.primary =>
          OptimusDropdownButtonVariant.primary,
      };
}
