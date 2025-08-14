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

enum OptimusCardCornerRadius { small, medium }

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
    this.isOutlined = true,
    this.radius = OptimusCardCornerRadius.medium,
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

  /// Whether card should be outlined;
  final bool isOutlined;

  /// Controls the radius of the card.
  final OptimusCardCornerRadius radius;

  Border? _border(BuildContext context) => isOutlined
      ? Border.all(
          width: context.tokens.borderWidth150,
          color: context.tokens.borderStaticPrimary,
        )
      : null;

  List<BoxShadow> _getShadows(OptimusTokens tokens) => switch (variant) {
    OptimusBasicCardVariant.normal => tokens.shadow100,
    OptimusBasicCardVariant.overlay => tokens.shadow300,
  };

  Radius _radius(BuildContext context) => switch (radius) {
    OptimusCardCornerRadius.small => context.tokens.borderRadius100,
    OptimusCardCornerRadius.medium => context.tokens.borderRadius200,
  };

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final tokens = theme.tokens;

    return _Card(
      spacing: padding,
      attachment: attachment,
      border: _border(context),
      shadows: _getShadows(tokens),
      contentWrapperBuilder: contentWrapperBuilder,
      color: tokens.backgroundStaticFlat,
      radius: _radius(context),
      child: child,
    );
  }
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
    this.isOutlined = false,
    this.radius = OptimusCardCornerRadius.medium,
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

  /// Whether card should be outlined.
  final bool isOutlined;

  /// The radius of the card.
  final OptimusCardCornerRadius radius;

  Radius _radius(BuildContext context) => switch (radius) {
    OptimusCardCornerRadius.small => context.tokens.borderRadius100,
    OptimusCardCornerRadius.medium => context.tokens.borderRadius200,
  };

  Border? _border(BuildContext context) => isOutlined
      ? Border.all(
          width: context.tokens.borderWidth150,
          color: context.tokens.borderStaticPrimary,
        )
      : null;

  Color _color(BuildContext context) => switch (variant) {
    OptimusNestedCardVariant.emphasized =>
      context.tokens.backgroundInteractiveNeutralDefault,
    OptimusNestedCardVariant.highlighted =>
      context.tokens.backgroundInteractiveSecondaryDefault,
    OptimusNestedCardVariant.normal => context.tokens.backgroundStaticFlat,
  };

  @override
  Widget build(BuildContext context) => _Card(
    spacing: padding,
    attachment: attachment,
    border: _border(context),
    color: _color(context),
    radius: _radius(context),
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
    required this.radius,
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
  final Radius radius;

  BorderRadius get _borderRadius => switch (attachment) {
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

  @override
  Widget build(BuildContext context) {
    final contentWrapperBuilder = this.contentWrapperBuilder;
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
