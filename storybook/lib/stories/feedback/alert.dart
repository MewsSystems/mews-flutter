import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story alertStory = Story(
  name: 'Feedback/Alert',
  builder: (context) => AlertStory(
    knobsBuilder: context.knobs,
  ),
);

class AlertStory extends StatelessWidget {
  const AlertStory({super.key, required this.knobsBuilder});

  final KnobsBuilder knobsBuilder;

  @override
  Widget build(BuildContext context) {
    final title = knobsBuilder.text(label: 'Title', initial: 'Title');
    final description = knobsBuilder.text(label: 'Description', initial: '');
    final link = knobsBuilder.text(label: 'Link text', initial: '');
    final isDismissible = knobsBuilder.boolean(label: 'Is Dismissible');
    final position = knobsBuilder.options(
      label: 'Position',
      initial: OptimusAlertPosition.topRight,
      options: OptimusAlertPosition.values.toOptions(),
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

  final String title;
  final String description;
  final String link;
  final bool isDismissible;

  OptimusFeedbackLink? get _link => link.isNotEmpty
      ? OptimusFeedbackLink(
          text: Text(link),
          onPressed: () {},
        )
      : null;

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...OptimusFeedbackVariant.values.map(
                (variant) => OptimusAlert(
                  title: Text(title),
                  description:
                      description.isNotEmpty ? Text(description) : null,
                  variant: variant,
                  link: _link,
                  isDismissible: isDismissible,
                ),
              ),
              OptimusButton(
                onPressed: () {
                  OptimusAlertOverlay.of(context)?.show(
                    OptimusAlert(
                      title: Text(title),
                      description:
                          description.isNotEmpty ? Text(description) : null,
                      link: _link,
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
