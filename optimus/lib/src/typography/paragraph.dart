import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Paragraphs are blocks of text that group related content.
///
/// It should be used as a distinct section of text dealing with a single topic.
class OptimusParagraph extends StatelessWidget {
  const OptimusParagraph({
    Key? key,
    this.variation = Variation.variationDefault,
    required this.child,
  }) : super(key: key);

  /// The content of the paragraph.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the paragraph.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset300r,
        color: variation.color,
        child: child,
      );
}

final TextStyle optimusParagraphStyle = preset300r;

/// Paragraphs are blocks of text that group related content.
///
/// Intended for the content-heavy environment (with exceptions).
class OptimusParagraphSmall extends StatelessWidget {
  const OptimusParagraphSmall({
    Key? key,
    this.variation = Variation.variationDefault,
    required this.child,
  }) : super(key: key);

  /// The content of the paragraph.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the paragraph.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset200r,
        color: variation.color,
        child: child,
      );
}

final TextStyle optimusParagraphSmallStyle = preset200r;
