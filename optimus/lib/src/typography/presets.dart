import 'package:optimus/optimus.dart';

/// To make the overall experience convenient and useful.
/// We use dynamic typography scales that serve different needs.
/// We currently maintain two separate scales. Dense and Light, and each
/// serves a different purpose.
enum Scale {
  /// The system's default option. It uses the interval 1.125 to generate
  /// the upper part of the scale.
  /// It is intended to be used in complex interfaces, content-dense
  /// environments, or smaller viewport using breakpoint presets of ≤1023px.
  dense,

  /// The more spacious option. It uses the interval 1.250to generate the
  /// upper part of the scale. Used in environments with more space and
  /// freedom, or larger viewports using breakpoint presets of ≥1024px.
  light,
}

extension Scaled on Breakpoint {
  Scale get scale => switch (this) {
        Breakpoint.extraSmall ||
        Breakpoint.small ||
        Breakpoint.medium =>
          Scale.dense,
        Breakpoint.large || Breakpoint.extraLarge => Scale.light,
      };
}
