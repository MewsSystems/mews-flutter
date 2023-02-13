import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story listTileStory = Story(
  name: 'General/List/List tile',
  builder: (context) {
    final k = context.knobs;

    final leadingIcon =
        k.options(label: 'Leading Icon', initial: null, options: exampleIcons);
    final trailingIcon =
        k.options(label: 'Trailing Icon', initial: null, options: exampleIcons);

    final headline = k.text(label: 'Headline', initial: 'Headline');
    final description = k.text(label: 'Description', initial: 'Description');
    final metadata = k.text(label: 'Metadata', initial: 'Metadata');

    final leadingAvatar = k.boolean(label: 'Use avatar', initial: false);

    return SingleChildScrollView(
      child: Column(
        children: Iterable<int>.generate(10)
            .map(
              (i) => OptimusListTile(
                headline: Text(headline),
                description: description.isNotEmpty ? Text(description) : null,
                metadata: metadata.isNotEmpty ? Text(metadata) : null,
                tileSize: k.options(
                  label: 'Tile size',
                  initial: TileSize.normal,
                  options: TileSize.values.toOptions(),
                ),
                fontVariant: k.options(
                  label: 'Font variant',
                  initial: FontVariant.normal,
                  options: FontVariant.values.toOptions(),
                ),
                leadingIcon: leadingIcon != null ? Icon(leadingIcon) : null,
                leadingAvatar: leadingAvatar
                    ? const OptimusAvatar(
                        title: 'Avatar',
                        imageUrl: _avatarUrl,
                      )
                    : null,
                trailingIcon: trailingIcon != null ? Icon(trailingIcon) : null,
                onTap: () {},
              ),
            )
            .toList(),
      ),
    );
  },
);

const _avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';
