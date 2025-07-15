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
    final scaledSize = MediaQuery.textScalerOf(context).scale(size);
    final borderWidth = tokens.borderWidth150;

    return AnimatedContainer(
      duration: _duration,
      width: scaledSize,
      height: scaledSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: isSelected ? borderWidth / 2 : borderWidth,
          color: _getBorderColor(tokens).resolve(controller.value),
        ),
        color: _getFillColor(tokens).resolve(controller.value),
      ),
    );
  }
}

const _duration = Duration(milliseconds: 100);
