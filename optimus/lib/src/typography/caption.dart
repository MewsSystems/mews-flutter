import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Captions provide a concise explanation of certain elements. Captions are
/// most effective when they give new information to the user rather than
/// describing the obvious.
///
/// [OptimusCaption] with [Variation.variationNormal] is used as a brief
/// description or explanation of the element.
///
/// [OptimusCaption] with [Variation.variationSecondary] is used as a brief
/// description or explanation of the element with less emphasis.
class OptimusCaption extends StatelessWidget {
  const OptimusCaption({
    super.key,
    this.variation = Variation.variationNormal,
    this.align,
    required this.child,
  });

  /// {@template optimus.typography.child}
  /// The content of this widget.
  ///
  /// Typically a [Text] widget.
  /// {@endtemplate}
  final Widget child;

  /// {@template optimus.typography.variation}
  /// The variation of this widget.
  /// {@endtemplate}
  final Variation variation;

  /// {@template optimus.typography.align}
  /// The alignment of the content within this widget.
  ///
  /// Defaults to [TextAlign.start].
  /// {@endtemplate}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: variation.color,
        align: align,
        child: child,
      );
}
