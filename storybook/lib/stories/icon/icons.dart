import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/icon/icons_list.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story allIconsStory = Story(
  name: 'Media/Icons/All Icons',
  builder: (context) => GridView.builder(
    itemCount: optimusIcons.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 5,
    ),
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          OptimusIcon(iconData: optimusIcons[index].data),
          Text(
            optimusIcons[index].name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  ),
);
