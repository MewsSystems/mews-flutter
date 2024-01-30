import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/typography/typography.dart';

/// {@template optimus.typography.title}
/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
/// {@endtemplate}
///
/// [OptimusTitleLarge] - is used only once per page (with exceptions).
class OptimusTitleLarge extends StatelessWidget {
  const OptimusTitleLarge({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens.titleLargeStrong,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusTitleMedium] - is used to divide individual sections of the page.
class OptimusTitleMedium extends StatelessWidget {
  const OptimusTitleMedium({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens.titleMediumStrong,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusTitleSmall] is used to further divide a specific section
/// into subsections.
class OptimusTitleSmall extends StatelessWidget {
  const OptimusTitleSmall({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens.titleSmallStrong,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusSubtitle] is used in combination with one of the titles.
class OptimusSubtitle extends StatelessWidget {
  const OptimusSubtitle({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        color: OptimusTypographyColor.secondary,
        resolveStyle: (_) => context.tokens.titleSmallStrong,
        align: align,
        child: child,
      );
}
