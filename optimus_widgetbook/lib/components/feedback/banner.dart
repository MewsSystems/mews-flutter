import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Banner', type: OptimusBanner, path: '[Feedback]')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final title = k.string(label: 'Title', initialValue: 'Title');
  final description = k.string(
    label: 'Additional description',
    initialValue: '',
  );
  final width = k.double.slider(
    label: 'Width',
    initialValue: 400,
    max: 800,
    min: 200,
  );

  return Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: width),
      child: SingleChildScrollView(
        child: Column(
          children: OptimusFeedbackVariant.values
              .map(
                (v) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: OptimusBanner(
                    title: Text(title),
                    description: description.maybeToWidget(),
                    hasIcon: k.boolean(label: 'Show icon'),
                    isDismissible: k.boolean(label: 'Dismissible'),
                    variant: v,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
