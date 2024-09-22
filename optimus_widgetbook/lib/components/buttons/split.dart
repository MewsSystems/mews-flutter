import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Split Button',
  type: OptimusSplitButton,
  path: '[Buttons]/Split Button',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final isEnabled = k.boolean(label: 'Enabled', initialValue: true);

  return SingleChildScrollView(
    child: Column(
      children: OptimusSplitButtonVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: OptimusSplitButton<int>(
                size: k.list(
                  label: 'Size',
                  initialOption: OptimusWidgetSize.large,
                  options: OptimusWidgetSize.values,
                ),
                items: Iterable<int>.generate(10)
                    .map(
                      (i) => ListDropdownTile<int>(
                        value: i,
                        title: Text('Dropdown tile #$i'),
                        subtitle: Text('Subtitle #$i'),
                      ),
                    )
                    .toList(),
                onPressed: isEnabled ? () {} : null,
                onItemSelected: isEnabled ? (_) => () {} : null,
                variant: v,
                child: Text(
                  k.string(label: 'Label', initialValue: 'Split button'),
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
