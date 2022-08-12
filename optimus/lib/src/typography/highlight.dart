import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// {@template optimus.typography.highlight}
/// Highlights are used to emphasize specific parts of the content that need to
/// stand out from the rest. Highlights serve as a guide when users skim
/// through the content, searching for relevant information,
/// such as price or dates.
/// {@endtemplate}
///
/// [OptimusHighlightMajor] - The highest form of emphasis. Use sporadically
/// for maximum impact.
class OptimusHighlightMajor extends StatelessWidget {
  const OptimusHighlightMajor({
    Key? key,
    this.align,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset600b,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.highlight}
///
/// [OptimusHighlightModerate] - Medium level of emphasis. Used without
/// limitations across the page.
class OptimusHighlightModerate extends StatelessWidget {
  const OptimusHighlightModerate({
    Key? key,
    this.align,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset500b,
        align: align,
        child: child,
      );
}

/// {@macro optimus.typography.highlight}
///
/// [OptimusHighlightMinor] - Low level of emphasis. Used without limitations
/// across the page.
class OptimusHighlightMinor extends StatelessWidget {
  const OptimusHighlightMinor({
    Key? key,
    this.align,
    required this.child,
  }) : super(key: key);

  /// {@macro optimus.typography.child}
  final Widget child;

  /// {@macro optimus.typography.align}
  final TextAlign? align;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset400b,
        align: align,
        child: child,
      );
}
