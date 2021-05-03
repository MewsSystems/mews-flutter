/// Used with grouped items such as [OptimusRadioGroup], [OptimusCheckboxGroup]
/// and [OptimusSegmentedControl].
class OptimusGroupItem<T> {
  const OptimusGroupItem({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}
