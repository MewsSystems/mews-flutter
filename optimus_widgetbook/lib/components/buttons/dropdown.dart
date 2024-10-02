import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Dropdown Button',
  type: OptimusDropDownButton,
  path: '[Buttons]/Dropdown Button',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final isEnabled = k.isEnabledKnob;

  return SingleChildScrollView(
    child: Column(
      children: OptimusDropdownButtonVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: OptimusDropDownButton<int>(
                size: k.widgetSizeKnob,
                items: Iterable<int>.generate(10)
                    .map(
                      (i) => ListDropdownTile<int>(
                        value: i,
                        title: Text('Dropdown tile #$i'),
                        subtitle: Text('Subtitle #$i'),
                      ),
                    )
                    .toList(),
                onItemSelected: isEnabled ? (_) => () {} : null,
                variant: v,
                child: Text(
                  k.string(label: 'Label', initialValue: 'Dropdown button'),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
