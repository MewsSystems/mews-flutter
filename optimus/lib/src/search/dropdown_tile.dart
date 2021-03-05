import 'package:flutter/widgets.dart';
import 'package:optimus/src/search/base_dropdown_tile.dart';

abstract class OptimusDropdownTile<T> extends StatelessWidget {
  const OptimusDropdownTile({Key? key, required this.value}) : super(key: key);

  final T value;

  @override
  Widget build(BuildContext context);
}

class ListDropdownTile<T> extends OptimusDropdownTile<T> {
  const ListDropdownTile({
    Key? key,
    required T value,
    required this.title,
    this.subtitle,
  }) : super(key: key, value: value);

  final Widget title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) => BaseDropdownTile(
        title: title,
        subtitle: subtitle,
      );
}
