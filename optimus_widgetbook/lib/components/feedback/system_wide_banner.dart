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
  final titleMaxLines = k.int.slider(
    label: 'Title Max Lines',
    initialValue: 1,
    min: 1,
    max: 5,
  );
  final descriptionMaxLines = k.int.slider(
    label: 'Description Max Lines',
    initialValue: 5,
    min: 1,
    max: 10,
  );
  final linkMaxLines = k.int.slider(
    label: 'Link Max Lines',
    initialValue: 1,
    min: 1,
    max: 3,
  );
  final overflow = k.object.dropdown(
    label: 'Overflow Style',
    initialOption: TextOverflow.ellipsis,
    options: TextOverflow.values,
    labelBuilder: (overflow) => overflow.name,
  );

  return SingleChildScrollView(
    child: Column(
      children: OptimusFeedbackVariant.values
          .map(
            (v) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusSystemWideBanner(
                title: Text(title),
                description: description.maybeToWidget(),
                link: link.isNotEmpty
                    ? OptimusFeedbackLink(
                        text: Text(link),
                        onPressed: ignore,
                        semanticUri: exampleUri,
                      )
                    : null,
                variant: v,
                titleMaxLines: titleMaxLines,
                descriptionMaxLines: descriptionMaxLines,
                linkMaxLines: linkMaxLines,
                overflow: overflow,
              ),
            ),
          )
          .toList(),
    ),
  );
}
