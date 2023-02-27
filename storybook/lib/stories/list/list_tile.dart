import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story listTileStory = Story(
  name: 'General/List/List tile',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final subtitle = k.text(label: 'Subtitle', initial: 'Subtitle');
    final prefix = k.options(
      label: 'Prefix',
      initial: null,
      options: exampleIcons,
    );
    final suffix = k.options(
      label: 'Suffix',
      initial: null,
      options: exampleIcons,
    );
    final info = k.text(label: 'Info', initial: 'Info');
    final infoWidget = k.options(
      label: 'Info widget',
      initial: null,
      options: exampleIcons,
    );
    final fontVariant = k.options(
      label: 'Font variant',
      initial: FontVariant.normal,
      options: FontVariant.values.toOptions(),
    );

    return SingleChildScrollView(
      child: Column(
        children: Iterable<int>.generate(10)
            .map(
              (i) => OptimusListTile(
                title: Text(title),
                subtitle: Text(subtitle),
                info: Text(info),
                fontVariant: fontVariant,
                prefix: prefix != null ? Icon(prefix) : null,
                suffix: suffix != null ? Icon(suffix) : null,
                infoWidget: infoWidget != null ? Icon(infoWidget) : null,
                onTap: () {},
              ),
            )
            .toList(),
      ),
    );
  },
);
