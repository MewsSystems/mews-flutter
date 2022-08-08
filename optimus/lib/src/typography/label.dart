import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Labels are informative text that describes the function or purpose of an
/// element. Labels are usually actionless and should always be visible in the
/// interface. Precise labels contribute to a more convenient experience.
///
/// [OptimusLabel] with [Variation.variationNormal] is coupled with another
/// element to describe its function.
///
/// [OptimusLabel] with [Variation.variationSecondary] is coupled with another
/// element to describe its function with less emphasis.
class OptimusLabel extends StatelessWidget {
  const OptimusLabel({
    Key? key,
    this.variation = Variation.variationNormal,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// The content of the label.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the label.
  final Variation variation;

  /// The alignment of the label.
  ///
  /// Defaults to [TextAlign.left].
  final TextAlign align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset200s,
        color: variation.color,
        align: align,
        child: child,
      );
}

/// Labels are informative text that describes the function or purpose of an
/// element. Labels are usually actionless and should always be visible in the
/// interface. Precise labels contribute to a more convenient experience.
///
/// [OptimusLabelSmall] with [Variation.variationNormal] is coupled with
/// another element to describe its function.
///
/// [OptimusLabelSmall] with [Variation.variationSecondary] is coupled with
/// another element to describe its function with less emphasis.
class OptimusLabelSmall extends StatelessWidget {
  const OptimusLabelSmall({
    Key? key,
    this.variation = Variation.variationNormal,
    this.align = TextAlign.left,
    required this.child,
  }) : super(key: key);

  /// The content of the label.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The alignment of the label.
  ///
  /// Defaults to [TextAlign.left].
  final TextAlign align;

  /// The variation of the label.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: variation.color,
        align: align,
        child: child,
      );
}
