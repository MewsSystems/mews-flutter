import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Button',
  type: OptimusIconButton,
  path: '[Buttons]/Icon Button',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final icon = k.list(
    label: 'Icon',
    initialOption: OptimusIcons.calendar,
    options: exampleIcons,
  );

  return SingleChildScrollView(
    child: Column(
      children: OptimusButtonVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusIconButton(
                onPressed: k.boolean(label: 'Enabled', initialValue: true)
                    ? ignore
                    : null,
                icon: Icon(icon),
                size: k.list(
                  label: 'Size',
                  initialOption: OptimusWidgetSize.large,
                  options: OptimusWidgetSize.values,
                ),
                variant: v,
              ),
            ),
          )
          .toList(),
    ),
  );
}
