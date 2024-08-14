import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final avatarStory = Story(
  name: 'Media/Avatar',
  builder: (context) {
    final k = context.knobs;
    final size = k.options(
      label: 'Size',
      initial: OptimusWidgetSize.medium,
      options: OptimusWidgetSize.values.toOptions(),
    );

    final hasIndicator = k.boolean(label: 'Has indicator', initial: false);
    final useImage = k.boolean(label: 'Use image', initial: false);
    final isErrorLoading = k.boolean(label: 'Error loading', initial: false);
    final title = k.text(label: 'Title', initial: 'User');
    final useBadge = k.boolean(label: 'Use badge', initial: false);

    return Center(
      child: OptimusAvatar(
        title: title,
        imageUrl: useImage
            ? isErrorLoading
                ? _badUrl
                : _avatarUrl
            : null,
        isIndicatorVisible: hasIndicator,
        size: size,
        badgeUrl: useBadge ? _badgeUrl : null,
      ),
    );
  },
);

const _avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

const _badgeUrl =
    'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80';

const _badUrl = 'https://bad.ulrl';
