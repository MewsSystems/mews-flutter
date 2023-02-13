import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_side.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Lists are vertically organized groups of data. Optimized for reading
/// comprehension, a list consists of a single continuous column of rows, with
/// each row representing a list item (in some cases on bigger viewports it
/// could use a multi-column layout).
///
/// A list should be easily scannable, and any element of a list can be used to
/// anchor and align list item content. Scannability is improved when elements
/// (such as supporting visuals and headlines) are placed in consistent
/// locations across list items. It's not recommended to mix tiles with icon,
/// avatar or without any leading widget in the same list.
class OptimusListTile extends StatefulWidget {
  const OptimusListTile({
    Key? key,
    required this.headline,
    this.description,
    this.leadingIcon,
    this.leadingAvatar,
    this.trailingIcon,
    this.metadata,
    this.onTap,
    this.fontVariant = FontVariant.normal,
    this.tileSize = TileSize.normal,
  }) : super(key: key);

  /// Communicates the subject of the list item.
  final Widget headline;

  /// Can provide extra information needed for the user to make a choice.
  final Widget? description;

  /// Icons can help with scanning and speed up the user's decision. Remember
  /// to use icons that can be easily recognized by the users. If
  /// [leadingAvatar] is provided, the [leadingIcon] will be hidden.
  final Widget? leadingIcon;

  /// An image that would be displayed on the leading position. Used for better
  /// recognition. Will replace [leadingIcon] if provided.
  final Widget? leadingAvatar;

  /// Additional cue to indicate the interactive character of the list item.
  final Widget? trailingIcon;

  /// Can be used in addition to Additional Description, to communicate
  /// meta-information about the list item, such as price, content count, or
  /// other details.
  final Widget? metadata;

  /// Action to be called on the tap gesture.
  final VoidCallback? onTap;

  /// Font variant used for the tile. Will be set to [FontVariant.normal], if
  /// not provided.
  /// [FontVariant.normal] - default typography preset
  /// [FontVariant.bold] - bold typography preset
  final FontVariant fontVariant;

  /// Depending on the screen size and list context you might need to use small
  /// variant. Will be set to [TileSize.normal], if not provided.
  /// - [TileSize.normal] - This variant should be used always when there is no
  /// space constraint
  /// - [TileSize.small] - Uses smaller font sizes and has less padding on top
  /// and bottom than the default variant. This variant should only be used
  /// when vertical space is scarce and showing more items on the list without
  /// the need to scroll is important for the user's task completion.
  final TileSize tileSize;

  @override
  State<OptimusListTile> createState() => _OptimusListTileState();
}

class _OptimusListTileState extends State<OptimusListTile> with ThemeGetter {
  Widget _buildLeadingIcon(Widget icon) => Padding(
        padding: const EdgeInsets.only(right: spacing200),
        child: IconTheme.merge(
          data: const IconThemeData(size: spacing300),
          child: icon,
        ),
      );

  Widget _buildLeadingAvatar(Widget avatar) => Padding(
        padding: const EdgeInsets.only(right: spacing200),
        child: SizedBox(width: spacing500, child: avatar),
      );

  Widget _buildMetadata(Widget metadata) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: OptimusTypographyColor.secondary,
        child: metadata,
      );

  TextStyle get _headlineStyle {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return preset300s;
      case FontVariant.bold:
        return preset300b;
    }
  }

  double get _contentSpacing {
    switch (widget.tileSize) {
      case TileSize.normal:
        return spacing200;
      case TileSize.small:
        return spacing100;
    }
  }

  Widget get _headline => Padding(
        padding: const EdgeInsets.only(right: spacing100),
        child: OptimusTypography(
          resolveStyle: (_) => _headlineStyle,
          child: DefaultTextStyle.merge(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            child: widget.headline,
          ),
        ),
      );

  Widget get _description {
    final description = widget.description;

    return description != null
        ? Padding(
            padding: const EdgeInsets.only(right: spacing100),
            child: OptimusTypography(
              resolveStyle: (_) => preset200s,
              color: _descriptionColor,
              child: DefaultTextStyle.merge(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                child: description,
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  OptimusTypographyColor get _descriptionColor {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return OptimusTypographyColor.secondary;
      case FontVariant.bold:
        return OptimusTypographyColor.primary;
    }
  }

  Widget _buildTrailingIcon(Widget suffix) => Padding(
        padding: const EdgeInsets.only(left: spacing200),
        child: IconTheme.merge(
          data: const IconThemeData(size: spacing300),
          child: suffix,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final metadata = widget.metadata;
    final trailing = widget.trailingIcon;
    final leadingIcon = widget.leadingIcon;
    final leadingAvatar = widget.leadingAvatar;

    return Container(
      decoration: BoxDecoration(border: Border(bottom: borderSide(theme))),
      constraints: const BoxConstraints(minHeight: spacing700),
      child: InkWell(
        highlightColor:
            theme.isDark ? theme.colors.neutral300 : theme.colors.neutral50,
        hoverColor:
            theme.isDark ? theme.colors.neutral400 : theme.colors.neutral25,
        splashColor: Colors.transparent,
        onTap: widget.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: _contentSpacing,
            horizontal: spacing200,
          ),
          child: Row(
            children: <Widget>[
              if (leadingAvatar != null) _buildLeadingAvatar(leadingAvatar),
              if (leadingAvatar == null && leadingIcon != null)
                _buildLeadingIcon(leadingIcon),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[_headline, _description],
                ),
              ),
              if (metadata != null) _buildMetadata(metadata),
              if (trailing != null) _buildTrailingIcon(trailing),
            ],
          ),
        ),
      ),
    );
  }
}

enum FontVariant { normal, bold }

enum TileSize { normal, small }
