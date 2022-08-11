import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// {@template optimus.typography.paragraph}
/// Paragraphs are blocks of text that group related content concerning one
/// topic or idea.
/// {@endtemplate}
///
/// [OptimusParagraph] with [Variation.variationNormal] is used as a distinct
/// section of text dealing with a single topic.
///
/// [OptimusParagraph] with [Variation.variationSecondary] is used as a
/// distinct section of text dealing with a single topic of less emphasis.
class OptimusParagraph extends StatelessWidget {
  const OptimusParagraph({
    Key? key,
    this.variation = Variation.variationNormal,
    this.align,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  /// {@macro optimus.typography.variation}
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset300r,
        color: variation.color,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.paragraph}
///
/// [OptimusParagraphSmall] with [Variation.variationNormal] Used as a distinct
/// section of text dealing with a single topic.
///
/// [OptimusParagraphSmall] with [Variation.variationSecondary] is used as a
/// distinct section of text dealing with a single topic of less emphasis.
class OptimusParagraphSmall extends StatelessWidget {
  const OptimusParagraphSmall({
    Key? key,
    this.variation = Variation.variationNormal,
    this.align,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  /// {@macro optimus.typography.variation}
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset200r,
        color: variation.color,
        align: align,
        child: child,
      );
}
