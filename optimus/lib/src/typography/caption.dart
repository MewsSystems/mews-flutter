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
    Key? key,
    this.variation = Variation.variationNormal,
    required this.child,
  }) : super(key: key);

  /// The content of the caption.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the caption.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: variation.color,
        child: child,
      );
}
