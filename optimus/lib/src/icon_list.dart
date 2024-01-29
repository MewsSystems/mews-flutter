import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// The icon list component serves as a static, non-interactable option and is
/// used when you need to show an icon with a label and/or optional description.
class OptimusIconList extends StatelessWidget {
  const OptimusIconList({
    super.key,
    this.items = const [],
    this.listSize,
  });

  /// Controls the content of tiles.
  final List<OptimusIconListItem> items;

  /// Controls size of list tile.
  ///
  /// - `null` – default value. Changes the tile size to match screen viewport.
  /// - [OptimusIconListSize.large] – considered the default option, used across
  ///   all products and platforms.
  /// - [OptimusIconListSize.small] – intended for content-heavy environments
  ///   and/or small viewports.
  final OptimusIconListSize? listSize;

  @override
  Widget build(BuildContext context) {
    final size = listSize ?? _getListSize(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (_, index) => _ListTile(item: items[index], size: size),
      separatorBuilder: (context, index) =>
          SizedBox(height: context.tokens.spacing200),
    );
  }

  OptimusIconListSize _getListSize(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).screenBreakpoint) {
        Breakpoint.extraSmall || Breakpoint.small => OptimusIconListSize.small,
        Breakpoint.medium ||
        Breakpoint.large ||
        Breakpoint.extraLarge =>
          OptimusIconListSize.large,
      };
}

enum OptimusIconListSize {
  /// Considered the default option, used across all products and platforms.
  large,

  /// Intended for content-heavy environments and/or small viewports.
  small,
}

/// Data that is provided to [OptimusIconList].
class OptimusIconListItem {
  const OptimusIconListItem({
    required this.iconData,
    required this.label,
    this.description,
    this.colorOption = OptimusIconColorOption.basic,
  });

  /// Controls the icon.
  final IconData iconData;

  /// Controls the tile label.
  final String label;

  /// Controls the tile description.
  final String? description;

  /// Controls color of the icon.
  ///
  /// - `null` – default value. Changes the color of the icon to match its
  ///   parent font color.
  /// - [OptimusIconColorOption.basic] – variant with no extra emphasis.
  /// - [OptimusIconColorOption.primary] – used to emphasize the item in a
  ///   general way.
  /// - [OptimusIconColorOption.success] – used to emphasize the item and convey
  ///   a sense of success.
  /// - [OptimusIconColorOption.warning] – used to emphasize the item and convey
  ///   a sense of warning.
  /// - [OptimusIconColorOption.danger] – used to emphasize the item and convey
  ///   a sense of danger or error.
  final OptimusIconColorOption colorOption;
}

class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.item,
    required this.size,
  });

  final OptimusIconListItem item;
  final OptimusIconListSize size;

  @override
  Widget build(BuildContext context) {
    final description = item.description;
    final theme = OptimusTheme.of(context);
    final tokens = context.tokens;

    return Row(
      children: [
        OptimusIcon(iconData: item.iconData, colorOption: item.colorOption),
        Padding(
          padding: EdgeInsets.only(left: tokens.spacing200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.label.capitalize(), style: _labelStyle),
              if (description != null && description.isNotEmpty)
                Text(
                  description.capitalize(),
                  style: _descriptionStyle.copyWith(
                    color: theme.isDark
                        ? theme.colors.neutral0t64
                        : theme.colors.neutral1000t64,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  TextStyle get _labelStyle => switch (size) {
        OptimusIconListSize.large => preset300s,
        OptimusIconListSize.small => preset200s,
      };

  TextStyle get _descriptionStyle => switch (size) {
        OptimusIconListSize.large => preset200s,
        OptimusIconListSize.small => preset100s,
      };
}

extension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
