import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/lists/base_list_tile.dart';
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
/// locations across list items. It's not recommended to mix components type in
/// the same position, e.g. stick to list with icons as a prefix and don't mix
/// it with list items without any prefix.
class OptimusListTile extends StatelessWidget {
  const OptimusListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.prefix,
    this.suffix,
    this.info,
    this.infoWidget,
    this.onTap,
    this.fontVariant = FontVariant.normal,
  }) : super(key: key);

  /// Communicates the subject of the list item.
  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the [title].
  /// Can provide extra information needed for the user to make a choice.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// The Widget to be displayed on the leading position. Typically an [Icon].
  final Widget? prefix;

  /// The Widget to be displayed on the tailoring position. Typically an [Icon].
  final Widget? suffix;

  /// The Widget to be displayed between the [title] and [suffix]. Typically
  /// an [Text] widget.
  final Widget? info;

  /// Additional widget to be displayed alongside with the [info] widget.
  /// Typically an [Icon].
  final Widget? infoWidget;

  /// Action that should be called on the tap gesture.
  final VoidCallback? onTap;

  /// Font variant, which will determine the text style. See [FontVariant] for
  /// more details.
  final FontVariant fontVariant;

  Widget _buildPrefix(Widget prefix) => Padding(
        padding: const EdgeInsets.only(right: spacing100),
        child: OptimusTypography(
          color: OptimusTypographyColor.secondary,
          resolveStyle: (_) => preset200s,
          child: prefix,
        ),
      );

  Widget _buildInfo(Widget info) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: OptimusTypographyColor.secondary,
        child: info,
      );

  Widget get _title => Padding(
        padding: const EdgeInsets.only(right: spacing100),
        child: OptimusTypography(
          resolveStyle: (_) => fontVariant.primaryStyle,
          child: title,
        ),
      );

  Widget get _subtitle {
    final subtitle = this.subtitle;

    return subtitle != null
        ? OptimusTypography(
            resolveStyle: (_) => preset200s,
            color: fontVariant.secondaryColor,
            child: subtitle,
          )
        : const SizedBox.shrink();
  }

  Widget _buildSuffix(Widget suffix) => OptimusTypography(
        resolveStyle: (_) => preset200s,
        child: suffix,
      );

  @override
  Widget build(BuildContext context) {
    final prefix = this.prefix;
    final info = this.info;
    final suffix = this.suffix;
    final infoWidget = this.infoWidget;

    return BaseListTile(
      onTap: onTap,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: spacing300,
          horizontal: spacing200,
        ),
        child: Row(
          children: <Widget>[
            if (prefix != null) _buildPrefix(prefix),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: _title),
                      if (info != null) _buildInfo(info),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(child: _subtitle),
                      if (infoWidget != null) infoWidget,
                    ],
                  ),
                ],
              ),
            ),
            if (suffix != null) _buildSuffix(suffix),
          ],
        ),
      ),
    );
  }
}
