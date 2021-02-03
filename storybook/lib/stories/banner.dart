import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story bannerStory = Story(
  name: 'Banner',
  section: 'Banner',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
        children: OptimusBannerVariant.values
            .map(
              (v) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusBanner(
                  content: Text(k.text('Content', initial: 'Info Text')),
                  additionalDescription: k.text('Additional description', initial: ''),
                  showIcon: k.boolean('Show icon'),
                  dismissible: k.boolean('Dismissible'),
                  variant: v,
                ),
              ),
            )
            .toList()),
  ),
);
