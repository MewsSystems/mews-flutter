import 'package:flutter/widgets.dart';

class DropdownTapInterceptor extends InheritedWidget {
  const DropdownTapInterceptor({
    super.key,
    required this.onTap,
    required super.child,
  });

  static DropdownTapInterceptor? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  final VoidCallback onTap;

  @override
  bool updateShouldNotify(DropdownTapInterceptor oldWidget) =>
      oldWidget.onTap != onTap;
}
