import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final pictogramsStory = Story(
  name: 'Media/Pictogram',
  builder: (context) => OptimusPictogram(
    size: context.knobs.options(
      label: 'Size',
      initial: OptimusPictogramSize.large,
      options: OptimusPictogramSize.values.toOptions(),
    ),
    variant: context.knobs.options(
      label: 'Variant',
      initial: OptimusPictogramVariant.calendar,
      options: OptimusPictogramVariant.values.toOptions(),
    ),
  ),
);
