import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story notificationStory = Story(
  name: 'Notification',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final body = k.text(label: 'Notification body', initial: '');
    final link = k.text(label: 'Link text', initial: '');
    final dismissible = k.boolean(label: 'Is Dismissible');
    final variant = k.options(
      label: 'Variant',
      description: 'Notification variant',
      initial: OptimusNotificationVariant.info,
      options: _variants,
    );

    return Column(
      children: [
        const Spacer(),
        OptimusNotification(
          title: title,
          body: body.isNotEmpty ? body : null,
          variant: variant,
          link: link.isNotEmpty ? link : null,
          onDismissed: dismissible ? () {} : null,
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomLeft,
          child: OptimusButton(
            onPressed: () {
              OptimusNotificationManager().showNotification(
                context: context,
                title: title,
                body: body.isNotEmpty ? body : null,
                variant: variant,
                link: link.isNotEmpty ? link : null,
                onDismissed: dismissible ? () {} : null,
              );
            },
            child: const Text('Show notification'),
          ),
        )
      ],
    );
  },
);

final _variants = OptimusNotificationVariant.values.toOptions();
