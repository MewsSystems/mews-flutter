import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

enum OptimusBasicCardVariant {
  /// The system default, general purpose option used in the majority of cases.
  /// It is recommended, but not required, to use it on a darker background
  /// for the best result.
  normal,

  /// The overlay type can only be used for dialogs, modals, or elements of
  /// a similar nature. It can contain nested cards.
  overlay,
}

enum OptimusNestedCardVariant {
  /// Used for subtle grouping of content.
  normal,

  /// Used to emphasize grouped content.
  emphasized,

  /// Used to highlight grouped content.
  highlighted,
}

enum OptimusCardSpacing {
  spacing0,
  spacing100,
  spacing200,
  spacing300,
  spacing400,
}

enum OptimusCardAttachment { none, top, right, bottom, left }

/// A card is a container that groups related pieces of information.
/// It is intended as a short, linked representation of a conceptual unit.
///
/// The system default, general purpose option used in the majority of cases.
/// It is recommended, but not required, to use it on a darker background for
/// the best result.
class OptimusCard extends StatelessWidget {
  const OptimusCard({
    super.key,
    required this.child,
    this.contentWrapperBuilder,
    this.padding = OptimusCardSpacing.spacing200,
    this.attachment = OptimusCardAttachment.none,
    this.variant = OptimusBasicCardVariant.normal,
  });

  final Widget child;

  /// Controls padding value for the card.
  final OptimusCardSpacing padding;

  /// Builds custom content. If content padding needed wrap in
  /// [OptimusCardChildPadding].
  final ContentWrapperBuilder? contentWrapperBuilder;

  /// Attaches the card to one side. For example, a card attached to the right
  /// will set the top right and bottom right border-radius to 0.
  final OptimusCardAttachment attachment;

  /// Controls card variant.
  final OptimusBasicCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final tokens = theme.tokens;

    return _Card(
      spacing: padding,
      attachment: attachment,
      shadows: _getShadows(tokens),
      contentWrapperBuilder: contentWrapperBuilder,
      color: _color(theme),
      child: child,
    );
  }

  List<BoxShadow> _getShadows(OptimusTokens tokens) => switch (variant) {
        OptimusBasicCardVariant.normal => tokens.shadow100,
        OptimusBasicCardVariant.overlay => tokens.shadow300,
      };

  // TODO(VG): can be changed when final dark theme design is ready.
  Color _color(OptimusThemeData theme) =>
      theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0;
}

/// A card is a container that groups related pieces of information.
/// It is intended as a short, linked representation of a conceptual unit.
///
/// The nested type, available in multiple variants, can only be used inside of
/// a basic card type. It is recommended to use only one layer of nesting.
class OptimusNestedCard extends StatelessWidget {
  const OptimusNestedCard({
    super.key,
    required this.child,
    this.contentWrapperBuilder,
    this.padding = OptimusCardSpacing.spacing200,
    this.attachment = OptimusCardAttachment.none,
    this.variant = OptimusNestedCardVariant.normal,
  });

  final Widget child;

  /// Builds custom content. If content padding needed wrap in
  /// [OptimusCardChildPadding].
  final ContentWrapperBuilder? contentWrapperBuilder;

  /// Controls padding value for the card.
  final OptimusCardSpacing padding;

  /// Attaches the card to one side. For example, a card attached to the right
  /// will set the top right and bottom right border-radius to 0.
  final OptimusCardAttachment attachment;

  /// Controls card variant.
  final OptimusNestedCardVariant variant;

  Border? _border(BuildContext context) =>
      variant == OptimusNestedCardVariant.normal
          ? Border.all(
              width: context.tokens.borderWidth100,
              // TODO(VG): can be changed when final dark theme design is ready.
              color: context.theme.isDark
                  ? context.theme.colors.neutral0t32
                  : context.theme.colors.neutral500t16,
            )
          : null;

  // TODO(VG): can be changed when final dark theme design is ready.
  Color _color(OptimusThemeData theme) => switch (variant) {
        OptimusNestedCardVariant.emphasized =>
          theme.isDark ? theme.colors.neutral400t24 : theme.colors.neutral500t8,
        OptimusNestedCardVariant.highlighted => theme.colors.primary500t8,
        OptimusNestedCardVariant.normal =>
          theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
      };

  @override
  Widget build(BuildContext context) => _Card(
        spacing: padding,
        attachment: attachment,
        border: _border(context),
        color: _color(context.theme),
        contentWrapperBuilder: contentWrapperBuilder,
        child: child,
      );
}

class _Card extends StatelessWidget {
  const _Card({
    required this.child,
    this.contentWrapperBuilder,
    required this.spacing,
    required this.attachment,
    this.shadows = const [],
    this.border,
    this.color,
  });

  final Widget child;
  final ContentWrapperBuilder? contentWrapperBuilder;
  final OptimusCardSpacing spacing;
  final OptimusCardAttachment attachment;
  final List<BoxShadow> shadows;
  final Border? border;
  final Color? color;

  BorderRadius _getBorderRadius(OptimusTokens tokens) {
    final radius = tokens.borderRadius200;

    return switch (attachment) {
      OptimusCardAttachment.none => BorderRadius.all(radius),
      OptimusCardAttachment.left => BorderRadius.only(
          topRight: radius,
          bottomRight: radius,
        ),
      OptimusCardAttachment.right => BorderRadius.only(
          topLeft: radius,
          bottomLeft: radius,
        ),
      OptimusCardAttachment.top => BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius,
        ),
      OptimusCardAttachment.bottom => BorderRadius.only(
          topLeft: radius,
          topRight: radius,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final contentWrapperBuilder = this.contentWrapperBuilder;
    final wrappedChild = contentWrapperBuilder == null
        ? OptimusCardChildPadding(spacing: spacing, child: child)
        : contentWrapperBuilder(context, child);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: _getBorderRadius(context.tokens),
        border: border,
        color: color,
        boxShadow: shadows,
      ),
      child: wrappedChild,
    );
  }
}

class OptimusCardChildPadding extends StatelessWidget {
  const OptimusCardChildPadding({
    super.key,
    required this.child,
    this.spacing = OptimusCardSpacing.spacing200,
  });

  final Widget child;
  final OptimusCardSpacing spacing;

  EdgeInsets _getPadding(OptimusTokens tokens) => switch (spacing) {
        OptimusCardSpacing.spacing0 => EdgeInsets.zero,
        OptimusCardSpacing.spacing100 => EdgeInsets.all(tokens.spacing100),
        OptimusCardSpacing.spacing200 => EdgeInsets.all(tokens.spacing200),
        OptimusCardSpacing.spacing300 => EdgeInsets.all(tokens.spacing300),
        OptimusCardSpacing.spacing400 => EdgeInsets.all(tokens.spacing400),
      };

  @override
  Widget build(BuildContext context) =>
      Padding(padding: _getPadding(context.tokens), child: child);
}
