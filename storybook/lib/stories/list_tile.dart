import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
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
                options: _fontVariants,
              ),
              suffix: Text(k.text('Suffix', initial: null)),
              prefix: Text(k.text('Prefix', initial: null)),
              infoWidget: Text(k.text('Info Widget', initial: null)),
              onTap: () {},
            ),
          )
          .toList(),
    ),
  ),
);

final List<Option<FontVariant>> _fontVariants =
    FontVariant.values.map((e) => Option(describeEnum(e), e)).toList();
