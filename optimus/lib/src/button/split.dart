import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
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
    Key key,
    @required this.child,
    this.onPressed,
    @required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusSplitButtonVariant.defaultButton,
  }) : super(key: key);

  /// Typically the button's label.
  final Widget child;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback onPressed;

  final List<OptimusDropdownTile<T>> items;

  final ValueSetter<T> onItemSelected;

  final OptimusWidgetSize size;

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
          ),
        ],
      );

  // ignore: missing_return
  OptimusButtonVariant get _buttonVariant {
    switch (variant) {
      case OptimusSplitButtonVariant.defaultButton:
        return OptimusButtonVariant.defaultButton;
      case OptimusSplitButtonVariant.primary:
        return OptimusButtonVariant.primary;
    }
  }

  // ignore: missing_return
  OptimusDropdownButtonVariant get _dropdownButtonVariant {
    switch (variant) {
      case OptimusSplitButtonVariant.defaultButton:
        return OptimusDropdownButtonVariant.defaultButton;
      case OptimusSplitButtonVariant.primary:
        return OptimusDropdownButtonVariant.primary;
    }
  }
}
