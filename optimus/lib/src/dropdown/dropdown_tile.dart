import 'package:flutter/widgets.dart';
import 'package:optimus/src/dropdown/base_dropdown_tile.dart';

abstract class OptimusDropdownTile<T> extends StatelessWidget {
  const OptimusDropdownTile({super.key, required this.value});

  final T value;
}

class ListDropdownTile<T> extends OptimusDropdownTile<T> {
  const ListDropdownTile({
    super.key,
    required super.value,
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.hasCheckbox = false,
  });

  final Widget title;
  final Widget? subtitle;
  final bool isSelected;
  final bool hasCheckbox;

  @override
  Widget build(BuildContext context) => BaseDropdownTile(
    title: title,
    subtitle: subtitle,
    isSelected: isSelected,
    hasCheckbox: hasCheckbox,
  );
}
