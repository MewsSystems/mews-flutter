import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

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
    Key key,
    this.child,
    this.contentWrapperBuilder,
    this.padding = OptimusCardSpacing.spacing200,
    this.attachment = OptimusCardAttachment.none,
    this.variant = OptimusBasicCardVariant.normal,
  }) : super(key: key);

  final Widget child;

  /// Controls padding value for the card.
  final OptimusCardSpacing padding;

  /// Builds custom content. If content padding needed wrap in
  /// [OptimusCardChildPadding].
  final ContentWrapperBuilder contentWrapperBuilder;

  /// Attaches the card to one side. For example, a card attached to the right
  /// will set the top right and bottom right border-radius to 0.
  final OptimusCardAttachment attachment;

  /// Controls card variant.
  final OptimusBasicCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return _Card(
      spacing: padding,
      attachment: attachment,
      shadows: _shadows,
      contentWrapperBuilder: contentWrapperBuilder,
      color: _color(theme),
      child: child,
    );
  }

  // ignore: missing_return
  List<BoxShadow> get _shadows {
    switch (variant) {
      case OptimusBasicCardVariant.normal:
        return elevation25;
      case OptimusBasicCardVariant.overlay:
        return elevation100;
    }
  }

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
    Key key,
    this.child,
    this.contentWrapperBuilder,
    this.padding = OptimusCardSpacing.spacing200,
    this.attachment = OptimusCardAttachment.none,
    this.variant = OptimusNestedCardVariant.normal,
  }) : super(key: key);

  final Widget child;

  /// Builds custom content. If content padding needed wrap in
  /// [OptimusCardChildPadding].
  final ContentWrapperBuilder contentWrapperBuilder;

  /// Controls padding value for the card.
  final OptimusCardSpacing padding;

  /// Attaches the card to one side. For example, a card attached to the right
  /// will set the top right and bottom right border-radius to 0.
  final OptimusCardAttachment attachment;

  /// Controls card variant.
  final OptimusNestedCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return _Card(
      spacing: padding,
      attachment: attachment,
      border: _border(theme),
      color: _color(theme),
      contentWrapperBuilder: contentWrapperBuilder,
      child: child,
    );
  }

  Border _border(OptimusThemeData theme) =>
      variant == OptimusNestedCardVariant.normal
          ? Border.all(
              width: 1,
              // TODO(VG): can be changed when final dark theme design is ready.
              color: theme.isDark
                  ? theme.colors.neutral0t32
                  : theme.colors.neutral500t16,
            )
          : null;

  // TODO(VG): can be changed when final dark theme design is ready.
  // ignore: missing_return
  Color _color(OptimusThemeData theme) {
    switch (variant) {
      case OptimusNestedCardVariant.emphasized:
        return theme.isDark
            ? theme.colors.neutral500t48
            : theme.colors.neutral500t8;
      case OptimusNestedCardVariant.highlighted:
        return theme.colors.primary500t8;
      case OptimusNestedCardVariant.normal:
        return theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0;
    }
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key key,
    this.child,
    this.contentWrapperBuilder,
    @required this.spacing,
    @required this.attachment,
    this.shadows = const [],
    this.border,
    this.color,
  }) : super(key: key);

  final Widget child;
  final ContentWrapperBuilder contentWrapperBuilder;
  final OptimusCardSpacing spacing;
  final OptimusCardAttachment attachment;
  final List<BoxShadow> shadows;
  final Border border;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final wrappedChild = contentWrapperBuilder == null
        ? OptimusCardChildPadding(spacing: spacing, child: child)
        : contentWrapperBuilder(context, child);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: border,
        color: color,
        boxShadow: shadows,
      ),
      child: wrappedChild,
    );
  }

  // ignore: missing_return
  BorderRadius get _borderRadius {
    switch (attachment) {
      case OptimusCardAttachment.none:
        return const BorderRadius.all(borderRadius100);
      case OptimusCardAttachment.left:
        return const BorderRadius.only(
          topRight: borderRadius100,
          bottomRight: borderRadius100,
        );
      case OptimusCardAttachment.right:
        return const BorderRadius.only(
          topLeft: borderRadius100,
          bottomLeft: borderRadius100,
        );
      case OptimusCardAttachment.top:
        return const BorderRadius.only(
          bottomLeft: borderRadius100,
          bottomRight: borderRadius100,
        );
      case OptimusCardAttachment.bottom:
        return const BorderRadius.only(
          topLeft: borderRadius100,
          topRight: borderRadius100,
        );
    }
  }
}

class OptimusCardChildPadding extends StatelessWidget {
  const OptimusCardChildPadding({
    Key key,
    this.child,
    this.spacing = OptimusCardSpacing.spacing200,
  }) : super(key: key);

  final Widget child;
  final OptimusCardSpacing spacing;

  @override
  Widget build(BuildContext context) =>
      Padding(padding: _padding, child: child);

  // ignore: missing_return
  EdgeInsets get _padding {
    switch (spacing) {
      case OptimusCardSpacing.spacing0:
        return const EdgeInsets.all(spacing0);
      case OptimusCardSpacing.spacing100:
        return const EdgeInsets.all(spacing100);
      case OptimusCardSpacing.spacing200:
        return const EdgeInsets.all(spacing200);
      case OptimusCardSpacing.spacing300:
        return const EdgeInsets.all(spacing300);
      case OptimusCardSpacing.spacing400:
        return const EdgeInsets.all(spacing400);
    }
  }
}
