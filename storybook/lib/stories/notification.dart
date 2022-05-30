import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story notificationStory = Story(
  name: 'Notification',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final body = k.text(label: 'Notification body', initial: '');
    final link = k.text(label: 'Link text', initial: '');
    final dismissible = k.boolean(label: 'Is Dismissible');

    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: OptimusNotificationVariant.values
                .map(
                  (variant) => OptimusNotification(
                    title: title,
                    body: body.isNotEmpty ? body : null,
                    variant: variant,
                    link: link.isNotEmpty ? link : null,
                    onDismissed: dismissible ? () {} : null,
                  ),
                )
                .toList(),
          ),
        ),
        Positioned(
          left: spacing200,
          bottom: spacing200,
          child: OptimusButton(
            onPressed: () {
              OptimusNotificationManager().showNotification(
                context: context,
                title: title,
                body: body.isNotEmpty ? body : null,
                onDismissed: dismissible ? () {} : null,
                link: link.isNotEmpty ? link : null,
                onLinkPressed: link.isNotEmpty ? () {} : null,
              );
            },
            child: const Text('Show notification'),
          ),
        )
      ],
    );
  },
);
