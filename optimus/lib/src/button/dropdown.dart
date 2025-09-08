import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/base_dropdown_button.dart';

enum OptimusDropdownButtonVariant { primary, secondary, tertiary, text }

/// Dropdown buttons trigger a dropdown menu with more actions related to the
/// context of the button.
class OptimusDropDownButton<T> extends StatelessWidget {
  const OptimusDropDownButton({
    super.key,
    required this.child,
    required this.items,
    this.onItemSelected,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusDropdownButtonVariant.tertiary,
    this.emptyList,
    this.dropdownWidth,
    this.maxDropdownHeight = 300.0,
  });

  /// Typically the button's label.
  final Widget child;

  /// List of items in dropdown section.
  final List<OptimusDropdownTile<T>> items;

  /// Called when dropdown item is selected.
  final ValueSetter<T>? onItemSelected;

  /// The size of the button.
  final OptimusWidgetSize size;

  /// The variant of the button.
  final OptimusDropdownButtonVariant variant;

  /// The empty list widget to display when there are no items in the dropdown.
  final Widget? emptyList;

  /// The width of the dropdown. If null, the width of the button will be used.
  final double? dropdownWidth;

  /// The maximum height of the dropdown. Will be clamped to the available
  /// space.
  final double maxDropdownHeight;

  @override
  Widget build(BuildContext context) => BaseDropDownButton(
    items: items,
    onItemSelected: onItemSelected,
    size: size,
    variant: variant,
    emptyList: emptyList,
    dropdownWidth: dropdownWidth,
    maxDropdownHeight: maxDropdownHeight,
    child: child,
  );
}

extension BaseButtonVariantResolve on OptimusDropdownButtonVariant {
  BaseButtonVariant toBaseVariant() => switch (this) {
    OptimusDropdownButtonVariant.tertiary => BaseButtonVariant.tertiary,
    OptimusDropdownButtonVariant.primary => BaseButtonVariant.primary,
    OptimusDropdownButtonVariant.secondary => BaseButtonVariant.secondary,
    OptimusDropdownButtonVariant.text => BaseButtonVariant.ghost,
  };
}
