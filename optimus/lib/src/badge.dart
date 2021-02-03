import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final bool isSingleDigit = text.length == 1;

    return Container(
      height: _singleDigitContainerHeight,
      width: isSingleDigit ? _singleDigitContainerWidth : null,
      decoration: BoxDecoration(
        color: OptimusColors.primary,
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(40)),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: spacing50),
          child: OptimusLabel(
            variation: Variation.variationSecondary,
            child: Text(
              text,
              style: const TextStyle(color: OptimusColors.basic0, height: 1),
            ),
          ),
        ),
      ),
    );
  }
}

const double _singleDigitContainerHeight = 20;
const double _singleDigitContainerWidth = 20;
