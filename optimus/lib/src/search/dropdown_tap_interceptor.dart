import 'package:flutter/widgets.dart';

class DropdownTapInterceptor extends InheritedWidget {
  const DropdownTapInterceptor({
    Key key,
    @required this.onTap,
    Widget child,
  }) : super(key: key, child: child);

  static DropdownTapInterceptor of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  final VoidCallback onTap;

  @override
  bool updateShouldNotify(DropdownTapInterceptor oldWidget) =>
      oldWidget.onTap != onTap;
}
