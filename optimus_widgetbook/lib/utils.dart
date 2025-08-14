import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';

final List<IconDetails> exampleIcons = optimusIcons.take(10).toList();
final List<AlignmentGeometry> alignments = [
  Alignment.center,
  Alignment.centerLeft,
  Alignment.centerRight,
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomLeft,
  Alignment.bottomRight,
];

const longText =
    'Nascetur nec convallis tempor sagittis ligula. Mauris aenean curae vestibulum aenean fames posuere consequat turpis. Cursus lectus rutrumdolor condimentum rhoncus tincidunt rutrum. Hac amet class vivamus rhoncus condimentum; penatibus risus magnis. Penatibus nulla venenatis nulla praesent mauris. Morbi feugiat rhoncus ridiculus varius faucibus commodo tincidunt ipsum molestie. Volutpat semper aptent viverra facilisi nam nibh suscipit purus himenaeos. Himenaeos quisque ultrices condimentum mauris a diam.';

final stubDate = DateTime(2012, 4, 3);

final exampleUri = Uri.parse('https://mews.design');

String enumOrNullLabelBuilder<T extends Enum>(T? value) => value?.name ?? '';

String enumLabelBuilder<T extends Enum>(T value) => value.name;

extension KnobsBuilderExt on KnobsBuilder {
  OptimusWidgetSize get widgetSizeKnob => object.dropdown(
    label: 'Size',
    options: OptimusWidgetSize.values,
    initialOption: OptimusWidgetSize.large,
    labelBuilder: enumLabelBuilder,
  );

  IconDetails optimusIconKnob({String label = 'Icon'}) => object.dropdown(
    label: label,
    options: exampleIcons,
    labelBuilder: (value) => value.name,
  );

  IconDetails? optimusIconOrNullKnob({String label = 'Icon'}) =>
      objectOrNull.dropdown(
        label: label,
        options: exampleIcons,
        labelBuilder: (value) => value.name,
      );

  AlignmentGeometry alignmentKnob({String label = 'Alignment'}) =>
      object.dropdown(label: label, options: alignments);

  bool get isEnabledKnob => boolean(label: 'Enabled', initialValue: true);
}

extension WidgetbookContext on BuildContext {
  bool get isInWidgetbookCloud => WidgetbookState.of(this).previewMode;
}

extension OptionalTextWidget on String {
  Widget? maybeToWidget() =>
      let((value) => value.isNotEmpty ? Text(value) : null);
}

extension OptionalIconWidget on IconDetails {
  Widget toWidget() => let((details) => Icon(details.data));
}

extension IconNameFilter on IconDetails {
  String get semanticName => name.replaceAll('_', ' ').replaceAll('24', '');
}
