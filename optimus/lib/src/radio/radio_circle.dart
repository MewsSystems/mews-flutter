import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/state_property.dart';

class RadioCircle extends StatelessWidget {
  const RadioCircle({
    super.key,
    required this.isSelected,
    required this.controller,
  });

  final bool isSelected;
  final WidgetStatesController controller;

  InteractiveStateColor _getBorderColor(OptimusTokens tokens) =>
      InteractiveStateColor(
        defaultColor: isSelected
            ? tokens.backgroundInteractivePrimaryDefault
            : tokens.borderInteractiveSecondaryDefault,
        disabled:
            isSelected ? tokens.backgroundDisabled : tokens.borderDisabled,
        pressed: isSelected
            ? tokens.backgroundInteractivePrimaryActive
            : tokens.borderInteractiveSecondaryActive,
        hovered: isSelected
            ? tokens.backgroundInteractivePrimaryHover
            : tokens.borderInteractiveSecondaryHover,
      );

  InteractiveStateColor _getFillColor(OptimusTokens tokens) =>
      InteractiveStateColor(
        defaultColor: tokens.backgroundInteractiveNeutralSubtleDefault,
        disabled: tokens.backgroundInteractiveNeutralSubtleDefault,
        pressed: tokens.backgroundInteractiveNeutralSubtleActive,
        hovered: tokens.backgroundInteractiveNeutralSubtleHover,
      );

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
