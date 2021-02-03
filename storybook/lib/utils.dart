import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final List<Option<OptimusColorOption>> colorOptions =
    OptimusColorOption.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<IconData>> exampleIcons = [
  const Option('', null),
  const Option('Mews Logo', OptimusIcons.mews_logo_small),
  const Option('Magic', OptimusIcons.magic),
  const Option('Plus', OptimusIcons.plus),
  const Option('Delete', OptimusIcons.delete),
  const Option('Edit', OptimusIcons.edit),
  const Option('Chevron right', OptimusIcons.chevron_right),
  const Option('Chevron left', OptimusIcons.chevron_left),
];

final List<Option<OptimusWidgetSize>> sizeOptions =
    OptimusWidgetSize.values.map((e) => Option(describeEnum(e), e)).toList();

extension EnumsToOptions<T> on List<T> {
  List<Option<T>> toOptions() => map((e) => Option(describeEnum(e), e)).toList();
}
