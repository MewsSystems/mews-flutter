import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';

enum OptimusDropdownButtonVariant {
  /// The default option. Use this variant for the majority of cases.
  defaultButton,

  /// Use if you want to grab the user’s attention and group together main
  /// actions that don’t have any clear priority.
  primary,

  /// Use in non-crucial situations, e.g., to group “more” actions together.
  text,
}

/// Dropdown buttons trigger a dropdown menu with more actions related to the
/// context of the button.
class OptimusDropDownButton<T> extends StatelessWidget {
  const OptimusDropDownButton({
    Key? key,
    required this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.defaultButton,
  }) : super(key: key);

  /// Typically the button's label.
  final Widget child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T>? onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;

  @override
  Widget build(BuildContext context) => BaseDropDownButton(
        items: items,
        onItemSelected: onItemSelected,
        size: size,
        variant: variant,
        child: child,
      );
}
