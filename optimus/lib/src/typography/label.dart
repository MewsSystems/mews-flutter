import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Labels are informative text that tell users the function or purpose of
/// an element.
///
/// Labels are usually actionless and should always be visible in the interface.
/// Simple and understandable labels contribute to more accessible UIs.
class OptimusLabel extends StatelessWidget {
  const OptimusLabel({
    Key? key,
    this.variation = Variation.variationDefault,
    required this.child,
  }) : super(key: key);

  /// The content of the label.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the label.
  ///
  /// - [Variation.variationDefault]: used as an accessory with another element
  ///   to describe its function with greater emphasis.
  /// - [Variation.variationSecondary]: used as an accessory with another
  ///   element to describe its function with lower emphasis.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset200r,
        color: variation.color,
        child: child,
      );
}

/// Labels are informative text that tell users the function or purpose of
/// an element.
///
/// Labels are usually actionless and should always be visible in the interface.
/// Simple and understandable labels contribute to more accessible UIs.
class OptimusLabelSmall extends StatelessWidget {
  const OptimusLabelSmall({
    Key? key,
    this.variation = Variation.variationDefault,
    required this.child,
  }) : super(key: key);

  /// The content of the label.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// The variation of the label.
  ///
  /// - [Variation.variationDefault]: with the same usage as its larger
  ///   counterpart, the small label is intended for the content-heavy
  ///   environment (with exceptions).
  /// - [Variation.variationSecondary]: with the same usage as its larger
  ///   counterpart, the small label is intended for the content-heavy
  ///   environment (with exceptions).
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: variation.color,
        child: child,
      );
}
