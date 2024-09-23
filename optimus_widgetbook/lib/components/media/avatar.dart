import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Avatar',
  type: OptimusAvatar,
  path: '[Media]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final size = k.list(
    label: 'Size',
    initialOption: OptimusWidgetSize.medium,
    options: OptimusWidgetSize.values,
  );

  final hasIndicator = k.boolean(label: 'Has indicator', initialValue: false);
  final useImage = k.boolean(label: 'Use image', initialValue: false);
  final isErrorLoading = k.boolean(label: 'Error loading', initialValue: false);
  final title = k.string(label: 'Title', initialValue: 'User');
  final useBadge = k.boolean(label: 'Use badge', initialValue: false);

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
}

const _avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

const _badgeUrl =
    'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80';

const _badUrl = 'https://bad.ulrl';
