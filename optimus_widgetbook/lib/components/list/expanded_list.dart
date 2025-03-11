import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Expanded List Tile',
  type: OptimusExpansionTile,
  path: '[Data Display]/List',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final title = k.string(label: 'Title', initialValue: 'Title');
  final subtitle = k.string(label: 'Subtitle', initialValue: 'Subtitle');
  final useLongSubtitle = k.boolean(
    label: 'Long subtitle',
    initialValue: false,
  );
  final trailing = k.optimusIconOrNullKnob(label: 'Trailing Icon');
  final leading = k.optimusIconOrNullKnob(label: 'Leading Icon');

  return SingleChildScrollView(
    child: Column(
      children:
          Iterable<int>.generate(10)
              .map(
                (i) => OptimusExpansionTile(
                  title: Text(title),
                  subtitle:
                      subtitle.isNotEmpty
                          ? Text(useLongSubtitle ? longText : subtitle)
                          : null,
                  trailing: trailing != null ? Icon(trailing.data) : null,
                  leading: leading != null ? Icon(leading.data) : null,
                  children:
                      Iterable<int>.generate(3)
                          .map(
                            (e) =>
                                OptimusListTile(title: Text('Children of $i')),
                          )
                          .toList(),
                ),
              )
              .toList(),
    ),
  );
}
