import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story systemWideBannerStory = Story(
  name: 'Feedback/System Wide Banner',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(
      label: 'Title',
      initial: 'Title',
    );
    final description = k.text(
      label: 'Description',
      initial: 'Description',
    );
    final link = k.text(
      label: 'Link',
      initial: 'Link',
    );

    return SingleChildScrollView(
      child: Column(
        children: OptimusFeedbackVariant.values
            .map(
              (v) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusSystemWideBanner(
                  title: Text(title),
                  description:
                      description.isNotEmpty ? Text(description) : null,
                  link: link.isNotEmpty
                      ? OptimusFeedbackLink(
                          text: Text(link),
                          onPressed: () {},
                        )
                      : null,
                  variant: v,
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);
