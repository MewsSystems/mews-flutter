import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/alignment.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Paragraphs are blocks of text that group related content concerning one
/// topic or idea.
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
    this.align = OptimusTypographyAlignment.left,
    required this.child,
  }) : super(key: key);

  /// The content of the paragraph.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The alignment of the paragraph.
  ///
  /// Defaults to [OptimusTypographyAlignment.left].
  final OptimusTypographyAlignment align;

  /// The variation of the paragraph.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset300r,
        color: variation.color,
        align: align,
        child: child,
      );
}

/// Paragraphs are blocks of text that group related content concerning one
/// topic or idea.
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
    this.align = OptimusTypographyAlignment.left,
    required this.child,
  }) : super(key: key);

  /// The content of the paragraph.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The alignment of the paragraph.
  ///
  /// Defaults to [OptimusTypographyAlignment.left].
  final OptimusTypographyAlignment align;

  /// The variation of the paragraph.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset200r,
        color: variation.color,
        align: align,
        child: child,
      );
}
