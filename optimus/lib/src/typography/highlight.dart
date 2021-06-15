import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Highlights are used to emphasize specific parts of the content that need to
/// stand out from the rest. Highlights serve as a guide when users skim
/// through the content, searching for relevant information,
/// such as price or dates.
///
/// [OptimusHighlightMajor] - The highest form of emphasis. Use sporadically
/// for maximum impact.
class OptimusHighlightMajor extends StatelessWidget {
  const OptimusHighlightMajor({Key? key, required this.child})
      : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset600b,
        child: child,
      );
}

/// Highlights are used to emphasize specific parts of the content that need to
/// stand out from the rest. Highlights serve as a guide when users skim
/// through the content, searching for relevant information,
/// such as price or dates.
///
/// [OptimusHighlightModerate] - Medium level of emphasis. Used without
/// limitations across the page.
class OptimusHighlightModerate extends StatelessWidget {
  const OptimusHighlightModerate({Key? key, required this.child})
      : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset500b,
        child: child,
      );
}

/// Highlights are used to emphasize specific parts of the content that need to
/// stand out from the rest. Highlights serve as a guide when users skim
/// through the content, searching for relevant information,
/// such as price or dates.
///
/// [OptimusHighlightMinor] - Low level of emphasis. Used without limitations
/// across the page.
class OptimusHighlightMinor extends StatelessWidget {
  const OptimusHighlightMinor({Key? key, required this.child})
      : super(key: key);

  /// The content of the highlight.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset400b,
        child: child,
      );
}
