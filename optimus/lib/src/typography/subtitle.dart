import 'package:flutter/widgets.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/typography/typography.dart';

/// Subtitles should not stand out as much as titles but they’re larger than
/// body text. Usually short and concise, subtitles organise information into
/// sections for users to quickly scan and understand the content of
/// each section. Subtitles are often used in conjunction with titles.
class OptimusSubtitle extends StatelessWidget {
  const OptimusSubtitle({Key? key, required this.child}) : super(key: key);

  /// The content of the subtitle.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => OptimusTypography(
        color: OptimusTypographyColor.secondary,
        resolveStyle: _resolveStyle,
        child: child,
      );
}

// ignore: missing_return
TextStyle _resolveStyle(Breakpoint size) {
  switch (size) {
    case Breakpoint.extraSmall:
    case Breakpoint.small:
    case Breakpoint.medium:
      return preset200m;
    case Breakpoint.large:
    case Breakpoint.extraLarge:
      return preset300m;
  }
}

TextStyle optimusSubtitleStyle(BuildContext context) =>
    _resolveStyle(MediaQuery.of(context).screenBreakpoint);
