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
    this.dropdownWidth = 280,
  });

  /// Typically the button's label.
  final Widget child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T>? onItemSelected;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonVariant variant;

  /// The width of the dropdown menu. If null, the dropdown menu will be the
  /// same width as the button.
  // ignore: avoid-unnecessary-nullable-fields, null is valid for this field
  final double? dropdownWidth;

  @override
  Widget build(BuildContext context) => BaseDropDownButton(
    items: items,
    onItemSelected: onItemSelected,
    size: size,
    variant: variant,
    dropdownWidth: dropdownWidth,
    child: child,
  );
}

extension BaseButtonVariantResolve on OptimusDropdownButtonVariant {
  BaseButtonVariant toBaseVariant() => switch (this) {
    .tertiary => .tertiary,
    .primary => .primary,
    .secondary => .secondary,
    .text => .ghost,
  };
}
