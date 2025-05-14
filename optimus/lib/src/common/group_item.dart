import 'package:flutter/widgets.dart';

/// Used with grouped items such as `OptimusRadioGroup`, `OptimusCheckboxGroup`
/// and `OptimusSegmentedControl`.
class OptimusGroupItem<T> {
  const OptimusGroupItem({
    required this.label,
    required this.value,
    this.semanticLabel,
  });

  /// The label widget of the item. Will be displayed alongside the item.
  final Widget label;

  /// The semantic label of the item. Will be used for accessibility purposes.
  final String? semanticLabel;

  /// The value of the item. Will be used to identify the item.
  final T value;
}
