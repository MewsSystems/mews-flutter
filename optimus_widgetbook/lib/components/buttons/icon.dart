import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Icon Button',
  type: OptimusIconButton,
  path: '[Buttons]/Icon Button',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final icon = k.optimusIconKnob(label: 'Icon');

  return SingleChildScrollView(
    child: Column(
      children: OptimusButtonVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusIconButton(
                onPressed: k.isEnabledKnob ? ignore : null,
                icon: Icon(icon.data),
                size: k.widgetSizeKnob,
                variant: v,
              ),
            ),
          )
          .toList(),
    ),
  );
}
