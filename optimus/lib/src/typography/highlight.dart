import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/styles.dart';

/// Highlights are used to emphasize specific parts in the content that need to
/// stand out from the rest of the text. Highlights serve as a guide when users
/// skim through the content searching for relevant information, such as price
/// or dates.
///
/// Intended for the highest emphasis and should be used sporadically for
/// maximum impact.
class OptimusHighlightHigh extends StatelessWidget {
  const OptimusHighlightHigh({Key? key, required this.child}) : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
        style: preset500s,
        child: child,
      );
}

/// Highlights are used to emphasize specific parts in the content that need to
/// stand out from the rest of the text. Highlights serve as a guide when users
/// skim through the content searching for relevant information, such as price
/// or dates.
///
/// Intended for a medium level of emphasis and can be used without limitations
/// across the page.
class OptimusHighlightMedium extends StatelessWidget {
  const OptimusHighlightMedium({Key? key, required this.child})
      : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
        style: preset400s,
        child: child,
      );
}

/// Highlights are used to emphasize specific parts in the content that need to
/// stand out from the rest of the text. Highlights serve as a guide when users
/// skim through the content searching for relevant information, such as price
/// or dates.
///
/// Intended for a low level of emphasis but and can be used without limitations
/// across the page.
class OptimusHighlightLow extends StatelessWidget {
  const OptimusHighlightLow({Key? key, required this.child}) : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => DefaultTextStyle.merge(
        style: preset300m,
        child: child,
      );
}
