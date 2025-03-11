import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class RadioCircle extends StatelessWidget {
  const RadioCircle({
    super.key,
    required this.isSelected,
    required this.controller,
  });

  final bool isSelected;
  final WidgetStatesController controller;

  WidgetStateColor _getBorderColor(OptimusTokens tokens) =>
      WidgetStateColor.fromMap({
        WidgetState.disabled:
            isSelected ? tokens.backgroundDisabled : tokens.borderDisabled,
        WidgetState.pressed:
            isSelected
                ? tokens.backgroundInteractivePrimaryActive
                : tokens.borderInteractiveSecondaryActive,
        WidgetState.hovered:
            isSelected
                ? tokens.backgroundInteractivePrimaryHover
                : tokens.borderInteractiveSecondaryHover,
        WidgetState.any:
            isSelected
                ? tokens.backgroundInteractivePrimaryDefault
                : tokens.borderInteractiveSecondaryDefault,
      });

  WidgetStateColor _getFillColor(OptimusTokens tokens) =>
      WidgetStateColor.fromMap({
        WidgetState.disabled: tokens.backgroundInteractiveNeutralSubtleDefault,
        WidgetState.pressed: tokens.backgroundInteractiveNeutralSubtleActive,
        WidgetState.hovered: tokens.backgroundInteractiveNeutralSubtleHover,
        WidgetState.any: tokens.backgroundInteractiveNeutralSubtleDefault,
      });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = tokens.sizing200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: isSelected ? _selectedBorder : tokens.borderWidth150,
          color: _getBorderColor(tokens).resolve(controller.value),
        ),
        color: _getFillColor(tokens).resolve(controller.value),
      ),
    );
  }
}

const double _selectedBorder = 6.0;
