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
    final position = k.list(
      label: 'Position',
      initialOption: OptimusAlertPosition.topRight,
      options: OptimusAlertPosition.values,
      labelBuilder: enumLabelBuilder,
    );

    return OptimusAlertOverlay(
      position: position,
      child: _AlertStoryContent(
        title: title,
        description: description,
        link: link,
        isDismissible: isDismissible,
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
  });

  final String? title;
  final String? description;
  final String? link;
  final bool isDismissible;

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
