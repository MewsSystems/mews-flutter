import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story bannerStory = Story(
  name: 'Banner',
  section: 'Banner',
  builder: (_, k) {
    final description = k.text(label: 'Additional description', initial: '');
    return SingleChildScrollView(
      child: Column(
          children: OptimusBannerVariant.values
              .map(
                (v) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: OptimusBanner(
                    title: Text(k.text(label: 'Content', initial: 'Info Text')),
                    description: description.isNotEmpty ? Text(description) : null,
                    hasIcon: k.boolean(label: 'Show icon'),
                    isDismissible: k.boolean(label: 'Dismissible'),
                    variant: v,
                  ),
                ),
              )
              .toList()),
    );
  },
);
