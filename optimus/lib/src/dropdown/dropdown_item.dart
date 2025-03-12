import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class DropdownItem<T> extends StatelessWidget {
  const DropdownItem({
    super.key,
    required this.child,
    required this.onTap,
    this.width,
    this.height,
  });

  final OptimusDropdownTile<T> child;
  final double? width;
  final double? height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: InkWell(
      borderRadius: BorderRadius.all(context.tokens.borderRadius100),
      onTap: onTap,
      child: child,
    ),
  );
}
