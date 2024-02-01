import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story alertStory = Story(
  name: 'Feedback/Alert',
  builder: (context) {
    final k = context.knobs;

    return SingleChildScrollView(
      child: Column(
        children: OptimusAlertVariant.values
            .map(
              (v) => Padding(
                padding: const EdgeInsets.all(8),
                child: OptimusAlert(
                  title: Text(
                    k.text(
                      label: 'Content',
                      initial: 'Info Text.',
                    ),
                  ),
                  variant: v,
                ),
              ),
            )
            .toList(),
      ),
    );
  },
);
