import 'package:flutter/widgets.dart';

// TODO(VG): add description for OptimusSegmentedControl?
/// Used with grouped items such as [OptimusRadioGroup] and [OptimusCheckboxGroup].
class OptimusGroupItem<T> {
  const OptimusGroupItem({
    required this.label,
    required this.value,
  });

  final Widget label;
  final T value;
}
