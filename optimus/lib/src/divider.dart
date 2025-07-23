import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/common.dart';

/// Divider is a visual representation of a separation between two areas.
class OptimusDivider extends StatelessWidget {
  const OptimusDivider({
    super.key,
    this.child,
    this.direction = Axis.horizontal,
    this.usePadding = true,
    this.thickness = OptimusDividerThicknessVariant.thin,
  });

  /// The text to display in the middle of the divider. If null, the divider
  /// will be just a line.
  final Widget? child;

  /// The direction of the divider.
  final Axis direction;

  /// Whether to use padding for the divider.
  final bool usePadding;

  /// The thickness of the divider.
  final OptimusDividerThicknessVariant thickness;

  double _getVerticalPadding(OptimusTokens tokens) =>
      direction == Axis.horizontal ? tokens.spacing100 : tokens.spacing150;

  double _getHorizontalPadding(OptimusTokens tokens) =>
      direction == Axis.horizontal ? tokens.spacing200 : tokens.spacing150;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final child = this.child;

    final divider =
        direction == Axis.horizontal
            ? Divider(
              color: context.dividerColor,
              thickness: thickness.getLineThickness(tokens),
              height:
                  usePadding
                      ? _getHorizontalPadding(tokens)
                      : thickness.getLineThickness(tokens),
            )
            : VerticalDivider(
              color: context.dividerColor,
              thickness: thickness.getLineThickness(tokens),
              width:
                  usePadding
                      ? _getVerticalPadding(tokens)
                      : thickness.getLineThickness(tokens),
            );
    final animatedDivider = AnimatedContainer(
      duration: themeChangeAnimationDuration,
      child: divider,
    );

    return Flex(
      direction: direction,
      children: [
        Expanded(child: animatedDivider),
        if (child != null) ...[
          Padding(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: _getHorizontalPadding(tokens),
              vertical: _getVerticalPadding(tokens),
            ),
            child: AnimatedContainer(
              duration: themeChangeAnimationDuration,
              child: DefaultTextStyle.merge(
                style: tokens.bodySmallStrong.copyWith(
                  color: context.textColor,
                ),
                child: child,
              ),
            ),
          ),
          Expanded(child: animatedDivider),
        ],
      ],
    );
  }
}

enum OptimusDividerThicknessVariant { thin, thick }

extension on OptimusDividerThicknessVariant {
  double getLineThickness(OptimusTokens tokens) => switch (this) {
    OptimusDividerThicknessVariant.thin => tokens.borderWidth150,
    OptimusDividerThicknessVariant.thick => tokens.borderWidth800,
  };
}

extension on BuildContext {
  Color get textColor => tokens.borderStaticSecondary;
  Color get dividerColor => tokens.borderStaticSecondary;
}
