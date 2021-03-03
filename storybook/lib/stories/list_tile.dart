import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story listTileStory = Story(
  name: 'List tile',
  builder: (_, k) => SingleChildScrollView(
    child: Column(
      children: Iterable<int>.generate(10)
          .map(
            (i) => OptimusListTile(
              title: Text(k.text('Title', initial: 'Title')),
              subtitle: Text(k.text('Subtitle', initial: 'Subtitle')),
              info: Text(k.text('Info', initial: 'Info')),
              fontVariant: k.options(
                'Font variant',
                initial: FontVariant.normal,
                options: FontVariant.values.toOptions(),
              ),
              suffix: Icon(
                k.options('Suffix', initial: null, options: exampleIcons),
              ),
              prefix: Icon(
                k.options('Prefix', initial: null, options: exampleIcons),
              ),
              infoWidget: Icon(
                k.options('Info widget', initial: null, options: exampleIcons),
              ),
              onTap: () {},
            ),
          )
          .toList(),
    ),
  ),
);
