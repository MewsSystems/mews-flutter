import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Logo',
  type: OptimusMewsLogo,
  path: '[Media]',
)
Widget createDefaultStyle(BuildContext context) {
  final knobs = context.knobs;
  final variant = knobs.list(
    label: 'Variant',
    initialOption: OptimusMewsLogoVariant.wordmark,
    options: OptimusMewsLogoVariant.values,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.list(
    label: 'Size',
    initialOption: OptimusMewsLogoSizeVariant.medium,
    options: OptimusMewsLogoSizeVariant.values,
    labelBuilder: (value) => value.name,
  );
  final color = knobs.list(
    label: 'Color',
    initialOption: OptimusMewsLogoColorVariant.black,
    options: OptimusMewsLogoColorVariant.values,
    labelBuilder: (value) => value.name,
  );
  final align = knobs.list(
    label: 'Align',
    initialOption: OptimusMewsLogoAlignVariant.topCenter,
    options: OptimusMewsLogoAlignVariant.values,
    labelBuilder: (value) => value.name,
  );

  return Container(
    alignment: Alignment.center,
    color: color == OptimusMewsLogoColorVariant.white ? Colors.black : null,
    child: OptimusMewsLogo(
      logoVariant: variant,
      sizeVariant: size,
      colorVariant: color,
      alignVariant: align,
    ),
  );
}
