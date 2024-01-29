import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/typography/typography.dart';

/// {@template optimus.typography.highlight}
/// Highlights are used to emphasize specific parts of the content that need to
/// stand out from the rest. Highlights serve as a guide when users skim
/// through the content, searching for relevant information,
/// such as price or dates.
/// {@endtemplate}
///
/// [OptimusHighlightLarge] - The highest form of emphasis. Use sporadically
/// for maximum impact.
class OptimusHighlightLarge extends StatelessWidget {
  const OptimusHighlightLarge({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens
            .highlightLarge, // TODO(witwash): mobile typography with breakpoints
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.highlight}
///
/// [OptimusHighlightMedium] - Medium level of emphasis. Used without
/// limitations across the page.
class OptimusHighlightMedium extends StatelessWidget {
  const OptimusHighlightMedium({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens
            .highlightMedium, // TODO(witwash): mobile typography with breakpoints
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.highlight}
///
/// [OptimusHighlightSmall] - Low level of emphasis. Used without limitations
/// across the page.
class OptimusHighlightSmall extends StatelessWidget {
  const OptimusHighlightSmall({
    super.key,
    this.align,
    required this.child,
  });

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: (_) => context.tokens
            .highlightSmall, // TODO(witwash): mobile typography with breakpoints
        align: align,
        child: child,
      );
}
