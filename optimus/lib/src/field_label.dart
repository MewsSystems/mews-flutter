import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldLabel extends StatelessWidget {
  const OptimusFieldLabel({
    Key key,
    this.label,
    this.isRequired = false,
  }) : super(key: key);

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: OptimusLabelSmall(
          variation: Variation.variationSecondary,
          child: Text(isRequired ? '$label *' : label),
        ),
      );
}
