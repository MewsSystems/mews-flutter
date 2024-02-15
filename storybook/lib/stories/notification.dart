import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story notificationStory = Story(
  name: 'Feedback/Notification',
  builder: (context) => NotificationStory(
    knobsBuilder: context.knobs,
  ),
);

class NotificationStory extends StatelessWidget {
  const NotificationStory({super.key, required this.knobsBuilder});

  final KnobsBuilder knobsBuilder;

  @override
  Widget build(BuildContext context) {
    final title = knobsBuilder.text(label: 'Title', initial: 'Title');
    final description = knobsBuilder.text(label: 'Description', initial: '');
    final link = knobsBuilder.text(label: 'Link text', initial: '');
    final dismissible = knobsBuilder.boolean(label: 'Is Dismissible');
    final position = knobsBuilder.options(
      label: 'Position',
      initial: OptimusNotificationPosition.topRight,
      options: OptimusNotificationPosition.values.toOptions(),
    );

    return OptimusNotificationsOverlay(
      position: position,
      child: _NotificationStoryContent(
        title: title,
        description: description,
        link: link,
        dismissible: dismissible,
      ),
    );
  }
}

class _NotificationStoryContent extends StatelessWidget {
  const _NotificationStoryContent({
    required this.title,
    required this.description,
    required this.link,
    required this.dismissible,
  });

  final String title;
  final String description;
  final String link;
  final bool dismissible;

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
                (variant) => OptimusNotification(
                  title: Text(title),
                  description:
                      description.isNotEmpty ? Text(description) : null,
                  variant: variant,
                  link: _link,
                  onDismissed: dismissible ? () {} : null,
                ),
              ),
              OptimusButton(
                onPressed: () {
                  OptimusNotificationsOverlay.of(context)?.show(
                    OptimusNotification(
                      title: Text(title),
                      description:
                          description.isNotEmpty ? Text(description) : null,
                      link: _link,
                      onDismissed: dismissible ? () {} : null,
                    ),
                  );
                },
                child: const Text('Show notification'),
              ),
            ],
          ),
        ),
      );
}
