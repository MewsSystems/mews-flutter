import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

class OptimusFieldLabel extends StatelessWidget {
  const OptimusFieldLabel({
    Key key,
    this.label,
    this.isRequired = false,
  }) : super(key: key);

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: OptimusLabelSmall(
        variation: Variation.variationSecondary,
        child: Text(isRequired ? '$label *' : label,
            style: TextStyle(color: _textColor(theme))),
      ),
    );
  }

  Color _textColor(OptimusThemeData theme) {
    if (theme.isDark) {
      return OptimusDarkColors.neutral0t64;
    } else {
      return OptimusLightColors.neutral1000t64;
    }
  }
}
