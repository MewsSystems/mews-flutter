import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/typography/typography.dart';
import 'package:optimus/src/typography/variation.dart';

/// Captions give users a brief explanation of certain elements.
///
/// Captions are most effective when they give new information to the user
/// rather than describing the obvious.
class OptimusCaption extends StatelessWidget {
  const OptimusCaption({
    Key key,
    this.variation = Variation.variationDefault,
    this.child,
  }) : super(key: key);

  /// The content of the caption.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// Caption variation:
  ///
  /// - [Variation.variationDefault]: a brief accompanying description or
  ///   explanation to relay an additional piece of information.
  /// - [Variation.variationSecondary]: a brief accompanying description or
  ///   explanation to relay an additional piece of information. When less
  ///   emphasis is needed.
  final Variation variation;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => preset100m,
        color: variation.color,
        child: child,
      );
}
