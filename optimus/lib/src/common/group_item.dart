import 'package:flutter/widgets.dart';

/// Used with grouped items such as `OptimusRadioGroup`, `OptimusCheckboxGroup`
/// and `OptimusSegmentedControl`.
class OptimusGroupItem<T> {
  const OptimusGroupItem({
    required this.label,
    required this.value,
  });

  final Widget label;
  final T value;
}
