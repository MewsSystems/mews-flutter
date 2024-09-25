import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default Style',
  type: OptimusButton,
  path: '[Buttons]/Button',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final leadingIcon = k.listOrNull(
    label: 'Leading icon',
    initialOption: null,
    options: exampleIcons,
  );
  final trailingIcon = k.listOrNull(
    label: 'Trailing icon',
    initialOption: null,
    options: exampleIcons,
  );

  final showBadge = k.boolean(label: 'Show Badge', initialValue: false);
  final counter =
      k.int.slider(label: 'Badge Count', initialValue: 0, max: 110, min: 0);

  return SingleChildScrollView(
    child: Column(
      children: OptimusButtonVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusButton(
                onPressed: k.boolean(label: 'Enabled', initialValue: true)
                    ? () {}
                    : null,
                size: k.list(
                  label: 'Size',
                  initialOption: OptimusWidgetSize.large,
                  options: OptimusWidgetSize.values,
                ),
                isLoading: k.boolean(label: 'Loading', initialValue: false),
                variant: v,
                leadingIcon: leadingIcon,
                trailingIcon: trailingIcon,
                counter: showBadge ? counter : null,
                child: Text(k.string(label: 'Text', initialValue: 'Button')),
              ),
            ),
          )
          .toList(),
    ),
  );
}
