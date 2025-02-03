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

const longText = '''
Nascetur nec convallis tempor sagittis ligula. Mauris aenean curae vestibulum 
aenean fames posuere consequat turpis. Cursus lectus rutrum dolor condimentum 
rhoncus tincidunt rutrum. Hac amet class vivamus rhoncus condimentum; penatibus 
risus magnis. Penatibus nulla venenatis nulla praesent mauris. Morbi feugiat 
rhoncus ridiculus varius faucibus commodo tincidunt ipsum molestie. Volutpat 
semper aptent viverra facilisi nam nibh suscipit purus himenaeos. Himenaeos 
quisque ultrices condimentum mauris a diam.''';

final stubDate = DateTime(2012, 4, 3);

String enumOrNullLabelBuilder<T extends Enum>(T? value) => value?.name ?? '';

String enumLabelBuilder<T extends Enum>(T value) => value.name;

extension KnobsBuilderExt on KnobsBuilder {
  OptimusWidgetSize get widgetSizeKnob => list(
        label: 'Size',
        options: OptimusWidgetSize.values,
        labelBuilder: (value) => value.name,
      );

  IconDetails optimusIconKnob({String label = 'Icon'}) => list(
        label: label,
        options: exampleIcons,
        labelBuilder: (value) => value.name,
      );

  IconDetails? optimusIconOrNullKnob({String label = 'Icon'}) => listOrNull(
        label: label,
        options: exampleIcons,
        labelBuilder: (value) => value?.name ?? 'None',
      );

  AlignmentGeometry alignmentKnob({String label = 'Alignment'}) => list(
        label: label,
        options: alignments,
      );

  bool get isEnabledKnob => boolean(label: 'Enabled', initialValue: true);
}

extension WidgetbookContext on BuildContext {
  bool get isInWidgetbookCloud => WidgetbookState.of(this).previewMode;
}
