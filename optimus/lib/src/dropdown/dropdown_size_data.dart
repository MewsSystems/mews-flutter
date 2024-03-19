import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class DropdownSizeData extends InheritedWidget {
  const DropdownSizeData({
    super.key,
    required super.child,
    required this.size,
  });

  final OptimusWidgetSize size;

  static DropdownSizeData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DropdownSizeData>();

  @override
  bool updateShouldNotify(DropdownSizeData oldWidget) => size != oldWidget.size;
}
