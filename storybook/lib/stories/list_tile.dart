import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story listTileStory = Story(
  name: 'List tile',
  builder: (context) {
    final k = context.knobs;

    return SingleChildScrollView(
      child: Column(
        children: Iterable<int>.generate(10)
            .map(
              (i) => OptimusListTile(
                title: Text(k.text(label: 'Title', initial: 'Title')),
                subtitle: Text(k.text(label: 'Subtitle', initial: 'Subtitle')),
                info: Text(k.text(label: 'Info', initial: 'Info')),
                fontVariant: k.options(
                  label: 'Font variant',
                  initial: FontVariant.normal,
                  options: FontVariant.values.toOptions(),
                ),
                suffix: Icon(
                  k.options(
                    label: 'Suffix',
                    initial: null,
                    options: exampleIcons,
                  ),
                ),
                prefix: Icon(
                  k.options(
                    label: 'Prefix',
                    initial: null,
                    options: exampleIcons,
                  ),
                ),
                infoWidget: Icon(
                  k.options(
                    label: 'Info widget',
                    initial: null,
                    options: exampleIcons,
                  ),
                ),
                onTap: () {},
              ),
            )
            .toList(),
      ),
    );
  },
);
