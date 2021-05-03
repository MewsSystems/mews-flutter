import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

class OptimusFieldLabel extends StatelessWidget {
  const OptimusFieldLabel({
    Key? key,
    required this.label,
    required this.isRequired,
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
        child: Text(
          label.markRequiredIf(isRequired),
          style: TextStyle(color: _textColor(theme)),
        ),
      ),
    );
  }

  Color _textColor(OptimusThemeData theme) =>
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;
}

extension StringExt on String {
  // ignore: avoid_positional_boolean_parameters
  String markRequiredIf(bool isRequired) => isRequired ? '$this *' : this;
}
