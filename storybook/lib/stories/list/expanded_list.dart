import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story expandedListTileStory = Story(
  name: 'Data Display/List/Expanded List Tile',
  builder: (context) {
    final k = context.knobs;
    final title = k.text(label: 'Title', initial: 'Title');
    final subtitle = k.text(label: 'Subtitle', initial: 'Subtitle');
    final longSubtitle = k.boolean(label: 'Long subtitle', initial: false);
    final trailing = k.options(
      label: 'Trailing',
      initial: null,
      options: exampleIcons,
    );
    final leading = k.options(
      label: 'Leading',
      initial: null,
      options: exampleIcons,
    );

    return SingleChildScrollView(
      child: Column(
        children: Iterable<int>.generate(10)
            .map(
              (i) => OptimusExpansionTile(
                title: Text(title),
                subtitle: subtitle.isNotEmpty
                    ? Text(longSubtitle ? longText : subtitle)
                    : null,
                trailing: trailing != null ? Icon(trailing) : null,
                leading: leading != null ? Icon(leading) : null,
                children: Iterable<int>.generate(3)
                    .map((e) => OptimusListTile(title: Text('Children of $i')))
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  },
);
