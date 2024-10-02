import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';

extension KnobsBuilderExt on KnobsBuilder {
  OptimusWidgetSize get widgetSizeKnob => list(
        label: 'Size',
        options: OptimusWidgetSize.values,
        labelBuilder: (value) => value.name,
      );

  IconDetails optimusIconKnob({required String label}) => list(
        label: label,
        options: exampleIcons,
        labelBuilder: (value) => value.name,
      );

  IconDetails? optimusIconOrNullKnob({required String label}) => listOrNull(
        label: label,
        options: exampleIcons,
        labelBuilder: (value) => value?.name ?? 'None',
      );

  (Alignment, String) get alignmentKnob => list(
        label: 'Alignment',
        options: alignments,
        labelBuilder: (value) => value.$2,
      );

  bool get isEnabledKnob => boolean(label: 'Enabled', initialValue: true);
}
