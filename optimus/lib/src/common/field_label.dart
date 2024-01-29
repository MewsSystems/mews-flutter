import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldLabel extends StatelessWidget {
  const OptimusFieldLabel({
    super.key,
    required this.label,
    this.isRequired = false,
    this.isEnabled = true,
  });

  final String label;
  final bool isRequired;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;
    final color = isEnabled ? tokens.textStaticPrimary : tokens.textDisabled;

    return Padding(
      padding: EdgeInsets.only(bottom: tokens.spacing25),
      child: OptimusLabel(
        variation: Variation.variationSecondary,
        child: Text(
          isRequired ? '$label *' : label,
          style: TextStyle(color: color),
        ),
      ),
    );
  }
}
