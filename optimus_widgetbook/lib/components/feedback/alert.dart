import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Alert', type: OptimusAlert, path: '[Feedback]')
Widget createDefaultStyle(BuildContext _) => const AlertStory();

class AlertStory extends StatelessWidget {
  const AlertStory({super.key});

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final title = k.stringOrNull(label: 'Title', initialValue: 'Title');
    final description = k.stringOrNull(label: 'Description', initialValue: '');
    final link = k.stringOrNull(label: 'Action', initialValue: '');
    final isDismissible = k.boolean(label: 'Dismissible');
    final position = k.object.dropdown(
      label: 'Position',
      initialOption: OptimusAlertPosition.topRight,
      options: OptimusAlertPosition.values,
      labelBuilder: enumLabelBuilder,
    );
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

    return OptimusAlertOverlay(
      position: position,
      child: _AlertStoryContent(
        title: title,
        description: description,
        link: link,
        isDismissible: isDismissible,
        titleMaxLines: titleMaxLines,
        descriptionMaxLines: descriptionMaxLines,
        linkMaxLines: linkMaxLines,
        overflow: overflow,
      ),
    );
  }
}

class _AlertStoryContent extends StatelessWidget {
  const _AlertStoryContent({
    required this.title,
    required this.description,
    required this.link,
    required this.isDismissible,
    required this.titleMaxLines,
    required this.descriptionMaxLines,
    required this.linkMaxLines,
    required this.overflow,
  });

  final String? title;
  final String? description;
  final String? link;
  final bool isDismissible;
  final int titleMaxLines;
  final int descriptionMaxLines;
  final int linkMaxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...OptimusFeedbackVariant.values.map(
            (variant) => OptimusAlert(
              title: title?.maybeToWidget(),
              description: description?.maybeToWidget(),
              variant: variant,
              action: link?.let((link) {
                if (link.isNotEmpty) {
                  return OptimusFeedbackLink(
                    text: Text(link),
                    onPressed: ignore,
                    semanticUri: exampleUri,
                  );
                }
              }),
              isDismissible: isDismissible,
              titleMaxLines: titleMaxLines,
              descriptionMaxLines: descriptionMaxLines,
              linkMaxLines: linkMaxLines,
              overflow: overflow,
            ),
          ),
          OptimusButton(
            onPressed: () {
              OptimusAlertOverlay.of(context)?.show(
                OptimusAlert(
                  title: title?.maybeToWidget(),
                  description: description?.maybeToWidget(),
                  action: link?.let((link) {
                    if (link.isNotEmpty) {
                      return OptimusFeedbackLink(
                        text: Text(link),
                        onPressed: ignore,
                      );
                    }
                  }),
                  isDismissible: isDismissible,
                  titleMaxLines: titleMaxLines,
                  descriptionMaxLines: descriptionMaxLines,
                  linkMaxLines: linkMaxLines,
                  overflow: overflow,
                ),
              );
            },
            child: const Text('Show alert'),
          ),
        ],
      ),
    ),
  );
}
