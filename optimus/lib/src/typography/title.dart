import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// {@template optimus.typography.title}
/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
/// {@endtemplate}
///
/// [OptimusPageTitle] - is used only once per page (with exceptions).
class OptimusPageTitle extends StatelessWidget {
  const OptimusPageTitle({
    Key? key,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset700b,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusSectionTitle] - is used to divide individual sections of the page.
class OptimusSectionTitle extends StatelessWidget {
  const OptimusSectionTitle({
    Key? key,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset600b,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusSubsectionTitle] is used to further divide a specific section
/// into subsections.
class OptimusSubsectionTitle extends StatelessWidget {
  const OptimusSubsectionTitle({
    Key? key,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset500b,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.title}
///
/// [OptimusSubtitle] is used in combination with one of the titles.
class OptimusSubtitle extends StatelessWidget {
  const OptimusSubtitle({
    Key? key,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        color: OptimusTypographyColor.secondary,
        resolveStyle: preset400b,
        align: align,
        child: child,
      );
}
