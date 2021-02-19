import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';

enum OptimusSplitButtonType {
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
    this.onDropdownItemPressed,
    this.size = OptimusWidgetSize.large,
    this.type = OptimusSplitButtonType.defaultButton,
  }) : super(key: key);

  /// Typically the button's label.
  final Widget child;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback onPressed;

  final List<OptimusDropdownTile<T>> items;

  final ValueSetter<T> onDropdownItemPressed;

  final OptimusWidgetSize size;

  final OptimusSplitButtonType type;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseButton(
            onPressed: onPressed,
            variant: _buttonType,
            borderRadius: const BorderRadius.only(
              topLeft: borderRadius50,
              bottomLeft: borderRadius50,
            ),
            child: child,
          ),
          const SizedBox(width: 1),
          BaseDropDownButton(
            items: items,
            onChanged: onDropdownItemPressed,
            type: _dropdownButtonType,
            borderRadius: const BorderRadius.only(
              topRight: borderRadius50,
              bottomRight: borderRadius50,
            ),
          ),
        ],
      );

  // ignore: missing_return
  OptimusButtonVariant get _buttonType {
    switch (type) {
      case OptimusSplitButtonType.defaultButton:
        return OptimusButtonVariant.defaultButton;
      case OptimusSplitButtonType.primary:
        return OptimusButtonVariant.primary;
    }
  }

  // ignore: missing_return
  OptimusDropdownButtonType get _dropdownButtonType {
    switch (type) {
      case OptimusSplitButtonType.defaultButton:
        return OptimusDropdownButtonType.defaultButton;
      case OptimusSplitButtonType.primary:
        return OptimusDropdownButtonType.primary;
    }
  }
}
