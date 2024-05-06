import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final spinnerStory = Story(
  name: 'Feedback/Spinner',
  builder: (context) {
    final size = context.knobs.options(
      label: 'Size',
      initial: OptimusSpinnerSize.medium,
      options: OptimusSpinnerSize.values.toOptions(),
    );

    return Center(
      child: OptimusSpinner(size: size),
    );
  },
);
