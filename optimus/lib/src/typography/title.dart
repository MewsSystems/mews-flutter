import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
///
/// [OptimusPageTitle] - is used only once per page (with exceptions).
class OptimusPageTitle extends StatelessWidget {
  const OptimusPageTitle({Key? key, required this.child}) : super(key: key);

  /// The content of the title.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset700b,
        child: child,
      );
}

/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
///
/// [OptimusSectionTitle] - is used to divide individual sections of the page.
class OptimusSectionTitle extends StatelessWidget {
  const OptimusSectionTitle({Key? key, required this.child}) : super(key: key);

  /// The content of the title.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset600b,
        child: child,
      );
}

/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
///
/// [OptimusSubsectionTitle] is used to further divide a specific section
/// into subsections.
class OptimusSubsectionTitle extends StatelessWidget {
  const OptimusSubsectionTitle({Key? key, required this.child})
      : super(key: key);

  /// The content of the title.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: preset500b,
        child: child,
      );
}

/// Titles provide a content hierarchy in any interface.
/// These should be concise, precise, and easily scannable to deliver
/// essential information quickly.
///
/// [OptimusSubtitle] is used in combination with one of the titles.
class OptimusSubtitle extends StatelessWidget {
  const OptimusSubtitle({Key? key, required this.child}) : super(key: key);

  /// The content of the subtitle.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        color: OptimusTypographyColor.secondary,
        resolveStyle: preset400b,
        child: child,
      );
}
