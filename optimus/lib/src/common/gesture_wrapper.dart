import 'package:flutter/widgets.dart';

class GestureWrapper extends StatelessWidget {
  const GestureWrapper({
    super.key,
    required this.child,
    this.onHoverChanged,
    this.onPressedChanged,
    this.onTap,
  });

  final Widget child;
  final ValueChanged<bool>? onHoverChanged;
  final ValueChanged<bool>? onPressedChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    onTapDown: (_) => onPressedChanged?.call(true),
    onTapUp: (_) => onPressedChanged?.call(false),
    onTapCancel: () => onPressedChanged?.call(false),
    child: MouseRegion(
      onEnter: (_) => onHoverChanged?.call(true),
      onExit: (_) => onHoverChanged?.call(false),
      child: child,
    ),
  );
}
