import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldLabel extends StatelessWidget {
  const OptimusFieldLabel({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: OptimusLabel(
          variation: Variation.variationSecondary,
          child: Text(
            isRequired ? '$label *' : label,
            style: TextStyle(color: context.tokens.textStaticPrimary),
          ),
        ),
      );
}
