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

  BoxDecoration _singleDigitDecoration(OptimusThemeData theme) => BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colors.primary,
        border: _border(theme),
      );

  BoxDecoration _multipleDigitDecoration(OptimusThemeData theme) =>
      BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        color: theme.colors.primary,
        border: _border(theme),
      );

  Border _border(OptimusThemeData theme) =>
      Border.all(width: 2, color: theme.colors.neutral0);

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      height: 20,
      width: _isSingleDigit ? 20 : null,
      decoration: _isSingleDigit
          ? _singleDigitDecoration(theme)
          : _multipleDigitDecoration(theme),
      child: Padding(
        padding: _padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptimusLabel(
              variation: Variation.variationSecondary,
              child: Text(
                text,
                style: TextStyle(color: theme.colors.neutral0, height: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get _isSingleDigit => text.length == 1;

  EdgeInsets get _padding => EdgeInsets.symmetric(
        horizontal: _isSingleDigit ? spacing0 : spacing50,
        vertical: spacing25,
      );
}
