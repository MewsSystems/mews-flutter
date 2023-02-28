import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story navListTileStory = Story(
  name: 'General/List/Navigation List tile',
  builder: (context) {
    final k = context.knobs;
    final headline = k.text(label: 'Headline', initial: 'Headline');
    final description = k.text(label: 'Description', initial: 'Description');
    final leading = k.options(
      label: 'Leading Icon',
      initial: null,
      options: exampleIcons,
    );
    final trailing = k.options(
      label: 'Trailing Icon',
      initial: null,
      options: exampleIcons,
    );
    final fontVariant = k.options(
      label: 'Font variant',
      initial: FontVariant.normal,
      options: FontVariant.values.toOptions(),
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: Iterable<int>.generate(10)
              .map(
                (i) => OptimusNavListTile(
                  headline: Text(headline),
                  description: Text(description),
                  fontVariant: fontVariant,
                  leadingIcon: leading != null ? Icon(leading) : null,
                  trailingIcon: trailing != null ? Icon(trailing) : null,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  },
);
