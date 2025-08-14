import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Split Button',
  type: OptimusSplitButton,
  path: '[Buttons]',
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
                size: k.object.dropdown(
                  label: 'Size',
                  initialOption: OptimusWidgetSize.large,
                  options: OptimusWidgetSize.values,
                  labelBuilder: enumLabelBuilder,
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
                onPressed: isEnabled ? ignore : null,
                onItemSelected: isEnabled ? ignore : null,
                variant: v,
                semanticLabel: 'Split Button: Primary',
                dropdownSemanticLabel: 'Split Button: Dropdown',
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
