import 'package:flutter/widgets.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/typography/typography.dart';

/// Titles provide content hierarchy in any interface, they should be short
/// and precise to deliver key information about a page, screen or modal.
/// In Optimus, titles are available in 3 different sizes per scale, 6 in total.
///
/// [OptimusPageTitle] is largest of the titles. Should be used only once per
/// page (with exceptions).
class OptimusPageTitle extends StatelessWidget {
  const OptimusPageTitle({Key? key, required this.child}) : super(key: key);

  /// The content of the title.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: _resolvePageTitleStyle,
        child: child,
      );
}

// ignore: missing_return
TextStyle _resolvePageTitleStyle(Breakpoint size) {
  switch (size) {
    case Breakpoint.extraSmall:
    case Breakpoint.small:
    case Breakpoint.medium:
      return preset500s;
    case Breakpoint.large:
    case Breakpoint.extraLarge:
      return preset600s;
  }
}

TextStyle optimusPageTitleStyle(BuildContext context) =>
    _resolvePageTitleStyle(MediaQuery.of(context).screenBreakpoint);

/// Titles provide content hierarchy in any interface, they should be short
/// and precise to deliver key information about a page, screen or modal.
/// In Optimus, titles are available in 3 different sizes per scale, 6 in total.
///
/// [OptimusSectionTitle] is used to divide individual sections of the page.
class OptimusSectionTitle extends StatelessWidget {
  const OptimusSectionTitle({Key? key, required this.child}) : super(key: key);

  /// The content of the title.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        resolveStyle: _resolveSectionTitleStyle,
        child: child,
      );
}

// ignore: missing_return
TextStyle _resolveSectionTitleStyle(Breakpoint size) {
  switch (size) {
    case Breakpoint.extraSmall:
    case Breakpoint.small:
    case Breakpoint.medium:
      return preset400s;
    case Breakpoint.large:
    case Breakpoint.extraLarge:
      return preset500s;
  }
}

TextStyle optimusSectionTitleStyle(BuildContext context) =>
    _resolveSectionTitleStyle(MediaQuery.of(context).screenBreakpoint);

/// Titles provide content hierarchy in any interface, they should be short
/// and precise to deliver key information about a page, screen or modal.
/// In Optimus, titles are available in 3 different sizes per scale, 6 in total.
///
/// [OptimusSubsectionTitle] is used to further divide the specific section
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
        resolveStyle: _resolveSubsectionTitleStyle,
        child: child,
      );
}

// ignore: missing_return
TextStyle _resolveSubsectionTitleStyle(Breakpoint size) {
  switch (size) {
    case Breakpoint.extraSmall:
    case Breakpoint.small:
    case Breakpoint.medium:
      return preset300s;
    case Breakpoint.large:
    case Breakpoint.extraLarge:
      return preset400s;
  }
}

TextStyle optimusSubSectionTitleStyle(BuildContext context) =>
    _resolveSubsectionTitleStyle(MediaQuery.of(context).screenBreakpoint);
