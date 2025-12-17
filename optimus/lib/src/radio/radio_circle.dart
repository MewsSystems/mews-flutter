import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/text_scaling.dart';

class RadioCircle extends StatelessWidget {
  const RadioCircle({
    super.key,
    required this.isSelected,
    required this.controller,
  });

  final bool isSelected;
  final WidgetStatesController controller;

  WidgetStateColor _getBorderColor(OptimusTokens tokens) => .fromMap({
    WidgetState.disabled: isSelected
        ? tokens.backgroundDisabled
        : tokens.borderDisabled,
    WidgetState.pressed: isSelected
        ? tokens.backgroundInteractivePrimaryActive
        : tokens.borderInteractiveInputActive,
    WidgetState.hovered: isSelected
        ? tokens.backgroundInteractivePrimaryHover
        : tokens.borderInteractiveInputHover,
    WidgetState.any: isSelected
        ? tokens.backgroundInteractivePrimaryDefault
        : tokens.borderInteractiveInputDefault,
  });

  WidgetStateColor _getFillColor(OptimusTokens tokens) => .fromMap({
    WidgetState.disabled: tokens.backgroundInteractiveNeutralSubtleDefault,
    WidgetState.pressed: tokens.backgroundInteractiveNeutralSubtleActive,
    WidgetState.hovered: tokens.backgroundInteractiveNeutralSubtleHover,
    WidgetState.any: tokens.backgroundInteractiveNeutralSubtleDefault,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final size = tokens.sizing200;
    final scaledSize = size.toScaled(context);
    final borderWidth = tokens.borderWidth100;
    final selectedBorderWidth = _selectedBorderWidth.toScaled(context);

    return AnimatedContainer(
      duration: _duration,
      width: scaledSize,
      height: scaledSize,
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(
          width: isSelected ? selectedBorderWidth : borderWidth,
          color: _getBorderColor(tokens).resolve(controller.value),
        ),
        color: _getFillColor(tokens).resolve(controller.value),
      ),
    );
  }
}

const _duration = Duration(milliseconds: 100);
const _selectedBorderWidth = 6.0;
