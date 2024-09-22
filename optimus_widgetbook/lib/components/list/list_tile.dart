import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'List Tile',
  type: OptimusListTile,
  path: '[Data Display]/List',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final title = k.string(label: 'Title', initialValue: 'Title');
  final subtitle = k.string(label: 'Subtitle', initialValue: 'Subtitle');
  final useLongSubtitle =
      k.boolean(label: 'Long subtitle', initialValue: false);
  final prefix = k.listOrNull(
    label: 'Prefix',
    initialOption: null,
    options: exampleIcons,
  );
  final suffix = k.listOrNull(
    label: 'Suffix',
    initialOption: null,
    options: exampleIcons,
  );
  final info = k.string(label: 'Info', initialValue: 'Info');
  final infoWidget = k.listOrNull(
    label: 'Info widget',
    initialOption: null,
    options: exampleIcons,
  );
  final fontVariant = k.list(
    label: 'Font variant',
    initialOption: FontVariant.normal,
    options: FontVariant.values,
  );

  return SingleChildScrollView(
    child: Column(
      children: Iterable<int>.generate(10)
          .map(
            (i) => OptimusListTile(
              title: Text(title),
              subtitle: subtitle.isNotEmpty
                  ? Text(useLongSubtitle ? longText : subtitle)
                  : null,
              info: info.isNotEmpty ? Text(info) : null,
              fontVariant: fontVariant,
              prefix: prefix != null ? Icon(prefix) : null,
              suffix: suffix != null ? Icon(suffix) : null,
              infoWidget: infoWidget != null ? Icon(infoWidget) : null,
              onTap: ignore,
            ),
          )
          .toList(),
    ),
  );
}
