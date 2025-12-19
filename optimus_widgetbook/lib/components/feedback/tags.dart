import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Tag', type: OptimusTag, path: '[Feedback]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final isOutlined = k.boolean(label: 'Outlined', initialValue: false);
  final leadingIcon = k.optimusIconOrNullKnob(label: 'Leading Icon');
  final trailingIcon = k.optimusIconOrNullKnob(label: 'Trailing Icon');
  final text = k.string(label: 'Text', initialValue: 'Label');
  final maxWidth = k.doubleOrNull.slider(
    label: 'Max width',
    initialValue: 50,
    min: 0,
    max: 300,
  );

  return Column(
    mainAxisSize: .min,
    children: [
      const OptimusTitleMedium(child: Text('Semantic')),
      Wrap(
        children: OptimusColorOption.values
            .map(
              (c) => Padding(
                padding: const .all(8),
                child: OptimusTag(
                  text: text.isEmpty ? c.name : text,
                  leadingIcon: leadingIcon?.data,
                  trailingIcon: trailingIcon?.data,
                  colorOption: c,
                  isOutlined: isOutlined,
                  maxWidth: maxWidth,
                ),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: 20),
      const OptimusTitleMedium(child: Text('Categorical')),
      Wrap(
        children: OptimusCategoricalColorOption.values
            .map(
              (c) => Padding(
                padding: const .all(8),
                child: OptimusCategoricalTag(
                  text: text.isEmpty ? c.name : text,
                  leadingIcon: leadingIcon?.data,
                  trailingIcon: trailingIcon?.data,
                  colorOption: c,
                  isOutlined: isOutlined,
                  maxWidth: maxWidth,
                ),
              ),
            )
            .toList(),
      ),
    ],
  );
}
