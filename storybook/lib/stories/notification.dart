import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story notificationStory = Story(
  name: 'Notification',
  builder: (context) => OptimusNotificationLayer(
    top: spacing100,
    right: spacing200,
    child: NotificationStory(
      knobsBuilder: context.knobs,
    ),
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

    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: OptimusNotificationVariant.values
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
            ),
          ),
        ),
        Positioned(
          left: spacing200,
          bottom: spacing200,
          child: OptimusButton(
            onPressed: () {
              OptimusNotificationLayer.of(context)?.show(
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
          ),
        )
      ],
    );
  }
}
