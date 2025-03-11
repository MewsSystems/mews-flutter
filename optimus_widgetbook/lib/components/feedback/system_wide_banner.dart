import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'System Wide Banner',
  type: OptimusSystemWideBanner,
  path: '[Feedback]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final title = k.string(label: 'Title', initialValue: 'Title');
  final description = k.string(
    label: 'Description',
    initialValue: 'Description',
  );
  final link = k.string(label: 'Link', initialValue: 'Link');

  return SingleChildScrollView(
    child: Column(
      children:
          OptimusFeedbackVariant.values
              .map(
                (v) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: OptimusSystemWideBanner(
                    title: Text(title),
                    description: description.maybeToWidget(),
                    link:
                        link.isNotEmpty
                            ? OptimusFeedbackLink(
                              text: Text(link),
                              onPressed: ignore,
                            )
                            : null,
                    variant: v,
                  ),
                ),
              )
              .toList(),
    ),
  );
}
