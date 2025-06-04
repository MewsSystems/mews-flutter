import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/semantics.dart';
import 'package:optimus/src/lists/base_list_tile.dart';
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
    super.key,
    required this.title,
    this.subtitle,
    this.prefix,
    this.suffix,
    this.info,
    this.infoWidget,
    this.onTap,
    this.fontVariant = FontVariant.normal,
    this.contentPadding,
    this.prefixSize = OptimusPrefixSize.medium,
    this.prefixVerticalAlignment,
  });

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

  /// The size of the prefix widget. Defaults to [OptimusPrefixSize.medium].
  final OptimusPrefixSize prefixSize;

  /// The vertical alignment of the prefix. By default it would align to the top,
  /// but if there is a [suffix] is would align to the center. Providing
  /// prefixVerticalAlignment will override the alignment.
  final OptimusPrefixVerticalAlignment? prefixVerticalAlignment;

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

  /// The padding of the list content. If not specified, the default padding
  /// will be used.
  final EdgeInsets? contentPadding;

  OptimusPrefixVerticalAlignment get _prefixVerticalAlignment =>
      prefixVerticalAlignment ??
      (subtitle != null
          ? OptimusPrefixVerticalAlignment.start
          : OptimusPrefixVerticalAlignment.center);

  EdgeInsets _getContentPadding(OptimusTokens tokens) =>
      contentPadding ??
      EdgeInsets.symmetric(
        vertical: tokens.spacing300,
        horizontal: tokens.spacing200,
      );

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Semantics(
      role: SemanticsRole.listItem,
      child: BaseListTile(
        onTap: onTap,
        content: Padding(
          padding: _getContentPadding(tokens),
          child: Stack(
            children: [
              if (prefix case final prefix?)
                Positioned(
                  top: tokens.spacing0,
                  bottom: _prefixVerticalAlignment.getBottom(tokens),
                  child: _Prefix(prefix: prefix, size: prefixSize),
                ),
              Row(
                children: [
                  if (prefix != null)
                    SizedBox(
                      width: prefixSize.getWidth(tokens),
                    ).excludeSemantics(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: tokens.spacing100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: _Title(
                                  title: title,
                                  fontVariant: fontVariant,
                                ),
                              ),
                              if (info case final info?)
                                Flexible(child: _Info(info: info)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (subtitle case final subtitle?)
                                Expanded(
                                  child: _Subtitle(
                                    subtitle: subtitle,
                                    fontVariant: fontVariant,
                                  ),
                                )
                              else
                                const Spacer(),
                              if (infoWidget case final infoWidget?) infoWidget,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (suffix case final suffix?) _Suffix(suffix: suffix),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum OptimusPrefixVerticalAlignment { center, start }

enum OptimusPrefixSize { medium, large }

class _Prefix extends StatelessWidget {
  const _Prefix({required this.prefix, this.size = OptimusPrefixSize.medium});

  final Widget prefix;
  final OptimusPrefixSize size;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SizedBox(
      width: size.getWidth(tokens),
      child: Padding(
        padding: EdgeInsets.only(right: tokens.spacing100),
        child: OptimusTypography(
          color: OptimusTypographyColor.secondary,
          resolveStyle: (_) => tokens.bodyMediumStrong,
          child: AspectRatio(aspectRatio: 1, child: prefix),
        ),
      ),
    );
  }
}

class _Suffix extends StatelessWidget {
  const _Suffix({required this.suffix});

  final Widget suffix;

  @override
  Widget build(BuildContext context) => OptimusTypography(
    resolveStyle: (_) => context.tokens.bodyMediumStrong,
    child: suffix,
  );
}

class _Title extends StatelessWidget {
  const _Title({required this.title, required this.fontVariant});

  final Widget title;
  final FontVariant fontVariant;

  @override
  Widget build(BuildContext context) => OptimusTypography(
    resolveStyle: (_) => fontVariant.getPrimaryStyle(context.tokens),
    child: title,
  );
}

class _Info extends StatelessWidget {
  const _Info({required this.info});

  final Widget info;

  @override
  Widget build(BuildContext context) => OptimusTypography(
    resolveStyle:
        (_) => context.tokens.bodySmallStrong.copyWith(
          overflow: TextOverflow.ellipsis,
        ),
    color: OptimusTypographyColor.secondary,
    child: info,
  );
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({required this.subtitle, required this.fontVariant});

  final Widget subtitle;
  final FontVariant fontVariant;

  @override
  Widget build(BuildContext context) => OptimusTypography(
    resolveStyle: (_) => context.tokens.bodyMediumStrong,
    color: fontVariant.secondaryColor,
    child: subtitle,
  );
}

extension on OptimusPrefixSize {
  double getWidth(OptimusTokens tokens) => switch (this) {
    OptimusPrefixSize.medium => tokens.sizing400,
    OptimusPrefixSize.large => tokens.sizing600,
  };
}

extension on OptimusPrefixVerticalAlignment {
  double? getBottom(OptimusTokens tokens) => switch (this) {
    OptimusPrefixVerticalAlignment.center => tokens.spacing0,
    OptimusPrefixVerticalAlignment.start => null,
  };
}
