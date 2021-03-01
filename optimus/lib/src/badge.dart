import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  BoxDecoration _decoration(OptimusThemeData theme) => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        color: theme.colors.primary,
        border: _border(theme),
      );

  Border _border(OptimusThemeData theme) => Border.all(
        width: 2,
        color: theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
      );

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      height: 20,
      decoration: _decoration(theme),
      child: Padding(
        padding: _padding,
        child: IntrinsicWidth(
          child: Center(
            child: OptimusLabel(
              variation: Variation.variationSecondary,
              child: Text(
                text,
                style: TextStyle(
                  color: theme.isDark
                      ? theme.colors.neutral1000
                      : theme.colors.neutral0,
                  height: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets get _padding =>
      const EdgeInsets.symmetric(horizontal: spacing50, vertical: spacing25);
}
