import 'package:flutter/widgets.dart';

class GestureWrapper extends StatelessWidget {
  const GestureWrapper({
    super.key,
    required this.child,
    required this.onHoverChanged,
    required this.onPressedChanged,
    this.onTap,
  });

  final Widget child;
  final ValueChanged<bool> onHoverChanged;
  final ValueChanged<bool> onPressedChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    onTapDown: (_) => onPressedChanged(true),
    onTapUp: (_) => onPressedChanged(false),
    onTapCancel: () => onPressedChanged(false),
    child: MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: child,
    ),
  );
}
