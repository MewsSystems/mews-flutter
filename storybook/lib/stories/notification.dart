import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story notificationStory = Story(
  name: 'Notification',
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
      initial: _NotificationPosition.topRight,
      options: _NotificationPosition.values.toOptions(),
    );
    final slideIn = knobsBuilder.options(
      label: 'Slide-in from:',
      initial: OptimusIncomingDirection.fromRight,
      options: OptimusIncomingDirection.values.toOptions(),
    );

    return OptimusNotificationsOverlay(
      left: position.left,
      top: position.top,
      right: position.right,
      bottom: position.bottom,
      inDirection: slideIn,
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
                    title: Text(title),
                    body: body.isNotEmpty ? Text(body) : null,
                    link: link.isNotEmpty
                        ? NotificationLink(
                            linkText: Text(link),
                            onLinkPressed: () {},
                          )
                        : null,
                    onDismissed: dismissible ? () {} : null,
                  );
                },
                child: const Text('Show notification'),
              )
            ],
          ),
        ),
      );
}

enum _NotificationPosition { topLeft, topRight, bottomRight, bottomLeft }

extension on _NotificationPosition {
  double? get left {
    switch (this) {
      case _NotificationPosition.bottomLeft:
      case _NotificationPosition.topLeft:
        return spacing100;
      case _NotificationPosition.topRight:
      case _NotificationPosition.bottomRight:
        return null;
    }
  }

  double? get top {
    switch (this) {
      case _NotificationPosition.topLeft:
      case _NotificationPosition.topRight:
        return spacing100;
      case _NotificationPosition.bottomRight:
      case _NotificationPosition.bottomLeft:
        return null;
    }
  }

  double? get right {
    switch (this) {
      case _NotificationPosition.bottomRight:
      case _NotificationPosition.topRight:
        return spacing100;
      case _NotificationPosition.topLeft:
      case _NotificationPosition.bottomLeft:
        return null;
    }
  }

  double? get bottom {
    switch (this) {
      case _NotificationPosition.bottomRight:
      case _NotificationPosition.bottomLeft:
        return spacing100;
      case _NotificationPosition.topLeft:
      case _NotificationPosition.topRight:
        return null;
    }
  }
}
