import 'package:flutter/widgets.dart';

class InteractiveStateColor extends WidgetStateProperty<Color> {
  InteractiveStateColor({
    required this.defaultColor,
    required this.disabled,
    required this.pressed,
    required this.hovered,
  });

  final Color disabled;
  final Color pressed;
  final Color hovered;
  final Color defaultColor;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.isDisabled) return disabled;
    if (states.isPressed) return pressed;
    if (states.isHovered) return hovered;

    return defaultColor;
  }
}

extension States on Set<WidgetState> {
  bool get isDisabled => contains(WidgetState.disabled);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isHovered => contains(WidgetState.hovered);
}
