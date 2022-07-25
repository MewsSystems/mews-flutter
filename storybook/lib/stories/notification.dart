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
  const NotificationStory({Key? key, required this.knobsBuilder})
      : super(key: key);

  final KnobsBuilder knobsBuilder;

  @override
  Widget build(BuildContext context) {
    final title = knobsBuilder.text(label: 'Title', initial: 'Title');
    final body = knobsBuilder.text(label: 'Notification body', initial: '');
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
        body: body,
        link: link,
        dismissible: dismissible,
      ),
    );
  }
}

class _NotificationStoryContent extends StatelessWidget {
  const _NotificationStoryContent({
    Key? key,
    required this.title,
    required this.body,
    required this.link,
    required this.dismissible,
  }) : super(key: key);

  final String title;
  final String body;
  final String link;
  final bool dismissible;

  @override
  Widget build(BuildContext context) => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...OptimusNotificationVariant.values
                  .map(
                    (variant) => OptimusNotification(
                      title: Text(title),
                      body: body.isNotEmpty ? Text(body) : null,
                      variant: variant,
                      link: link.isNotEmpty ? Text(link) : null,
                      onDismissed: dismissible ? () {} : null,
                    ),
                  )
                  .toList(),
              OptimusButton(
                onPressed: () {
                  OptimusNotificationsOverlay.of(context)?.show(
                    OptimusNotification(
                      title: Text(title),
                      body: body.isNotEmpty ? Text(body) : null,
                      link: link.isNotEmpty ? Text(link) : null,
                      onLinkPressed: link.isNotEmpty ? (() {}) : null,
                      onDismissed: dismissible ? () {} : null,
                    ),
                  );
                },
                child: const Text('Show notification'),
              )
            ],
          ),
        ),
      );
}
