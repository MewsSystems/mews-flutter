import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/common.dart';
import 'package:optimus/src/typography/presets.dart';

/// Divider is a visual representation of a separation between two areas.
class OptimusDivider extends StatelessWidget {
  const OptimusDivider({
    super.key,
    this.child,
    this.direction = Axis.horizontal,
  });

  /// The text to display in the middle of the divider. If null, the divider
  /// will be just a line.
  final Widget? child;

  /// The direction of the divider.
  final Axis direction;

  double get _verticalPadding =>
      direction == Axis.horizontal ? spacing100 : spacing150;

  double get _horizontalPadding =>
      direction == Axis.horizontal ? spacing200 : spacing150;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final child = this.child;
    final color = theme.tokens.borderStaticSecondary;

    final divider = direction == Axis.horizontal
        ? Divider(color: color, thickness: 1)
        : VerticalDivider(color: color, thickness: 1);
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
              horizontal: _horizontalPadding,
              vertical: _verticalPadding,
            ),
            child: AnimatedContainer(
              duration: themeChangeAnimationDuration,
              child: DefaultTextStyle.merge(
                style: preset100s.copyWith(
                  color: theme.tokens.textStaticSecondary,
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
