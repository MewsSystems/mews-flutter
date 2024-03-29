import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/lists/base_list_tile.dart';
import 'package:optimus/src/typography/typography.dart';

/// Lists are vertically organized groups of data. Optimized for reading
/// comprehension, a list consists of a single continuous column of rows, with
/// each row representing a list item (in some cases on bigger viewports it
/// could use a multi-column layout). [OptimusNavListTile] is meant to be
/// used an a tile, which contains some interactable element, e.g. tile which
/// leads to the new screen.
///
/// A list should be easily scannable, and any element of a list can be used to
/// anchor and align list item content. Scannability is improved when elements
/// (such as supporting visuals and headlines) are placed in consistent
/// locations across list items. It's not recommended to mix tiles with icon,
/// avatar or without any leading widget in the same list.
class OptimusNavListTile extends StatelessWidget {
  const OptimusNavListTile({
    super.key,
    required this.headline,
    this.description,
    this.leadingIcon,
    this.leadingAvatar,
    this.trailingIcon,
    this.metadata,
    this.onTap,
    this.fontVariant = FontVariant.normal,
    this.tileSize = TileSize.normal,
  });

  /// Communicates the subject of the list item.
  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget headline;

  /// Additional content displayed below the [headline].
  /// Can provide extra information needed for the user to make a choice.
  ///
  /// Typically a [Text] widget.
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

  /// Font variant, which will determine the text style. See [FontVariant] for
  /// more details.
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

  double _getContentSpacing(OptimusTokens tokens) => switch (tileSize) {
        TileSize.normal => tokens.spacing200,
        TileSize.small => tokens.spacing100,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final leadingIcon = this.leadingIcon;
    final leadingAvatar = this.leadingAvatar;

    return BaseListTile(
      onTap: onTap,
      content: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _getContentSpacing(tokens),
          horizontal: tokens.spacing200,
        ),
        child: Row(
          children: <Widget>[
            if (leadingAvatar != null) _Avatar(avatar: leadingAvatar),
            if (leadingAvatar == null && leadingIcon != null)
              _LeadingIcon(icon: leadingIcon),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Headline(fontVariant: fontVariant, headline: headline),
                  if (description case final description?)
                    _Description(
                      description: description,
                      fontVariant: fontVariant,
                    ),
                ],
              ),
            ),
            if (metadata case final metadata?) _Metadata(metadata: metadata),
            if (trailingIcon case final trailingIcon?)
              _TrailingIcon(icon: trailingIcon),
          ],
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    required this.description,
    required this.fontVariant,
  });

  final Widget description;
  final FontVariant fontVariant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(right: tokens.spacing100),
      child: OptimusTypography(
        resolveStyle: (_) => tokens.bodyMediumStrong,
        color: fontVariant.secondaryColor,
        child: DefaultTextStyle.merge(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          child: description,
        ),
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(right: tokens.spacing200),
      child: IconTheme.merge(
        data: IconThemeData(size: tokens.sizing300),
        child: icon,
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatar});

  final Widget avatar;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(right: tokens.spacing200),
      child: SizedBox(width: tokens.sizing500, child: avatar),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.fontVariant, required this.headline});

  final FontVariant fontVariant;
  final Widget headline;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(right: tokens.spacing100),
      child: OptimusTypography(
        resolveStyle: (_) => fontVariant.getPrimaryStyle(tokens),
        child: DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: headline,
        ),
      ),
    );
  }
}

class _Metadata extends StatelessWidget {
  const _Metadata({required this.metadata});

  final Widget metadata;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens.bodySmallStrong,
        color: OptimusTypographyColor.secondary,
        child: metadata,
      );
}

class _TrailingIcon extends StatelessWidget {
  const _TrailingIcon({required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(left: tokens.spacing200),
      child: IconTheme.merge(
        data: IconThemeData(size: tokens.sizing300),
        child: icon,
      ),
    );
  }
}

enum TileSize { normal, small }
