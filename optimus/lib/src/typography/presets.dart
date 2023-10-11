import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:optimus/optimus.dart';

/// To make the overall experience convenient and useful.
/// We use dynamic typography scales that serve different needs.
/// We currently maintain two separate scales. Dense and Light, and each
/// serves a different purpose.
enum _Scale {
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

const TextStyle baseTextStyle = TextStyle(
  fontFamily: 'Inter',
  package: 'optimus',
  fontWeight: FontWeight.w400,
  fontFeatures: <FontFeature>[
    FontFeature('calt'),
    FontFeature('tnum'),
    FontFeature('ss01'),
    FontFeature('ss03'),
    FontFeature('cv01'),
    FontFeature('cv02'),
    FontFeature('cv03'),
    FontFeature('cv04'),
    FontFeature('cv05'),
    FontFeature('cv06'),
    FontFeature('cv07'),
    FontFeature('cv08'),
    FontFeature('cv09'),
    FontFeature('cv10'),
    FontFeature('zero'),
  ],
  height: 1.5,
  leadingDistribution: TextLeadingDistribution.even,
);

TextStyle preset700b(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense =>
        baseTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
      _Scale.light =>
        baseTextStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w600),
    };

TextStyle preset600b(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense =>
        baseTextStyle.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
      _Scale.light =>
        baseTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w600),
    };

TextStyle preset500b(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense =>
        baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
      _Scale.light =>
        baseTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w500),
    };

TextStyle preset400b(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense =>
        baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
      _Scale.light =>
        baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
    };

TextStyle preset400s(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense => baseTextStyle.copyWith(fontSize: 18),
      _Scale.light => baseTextStyle.copyWith(fontSize: 20),
    };

TextStyle preset400r(Breakpoint breakpoint) => switch (breakpoint.scale) {
      _Scale.dense => baseTextStyle.copyWith(fontSize: 18),
      _Scale.light => baseTextStyle.copyWith(fontSize: 20),
    };

TextStyle get preset300b => baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );

TextStyle get preset300s => baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

TextStyle get preset300r => baseTextStyle.copyWith(
      fontSize: 16,
    );

TextStyle get preset200b => baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );

TextStyle get preset200s => baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );

TextStyle get preset200r => baseTextStyle.copyWith(fontSize: 14);

TextStyle get preset100b => baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );

TextStyle get preset100s => baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );

TextStyle get preset100r => baseTextStyle.copyWith(fontSize: 12);

TextStyle get preset50b => baseTextStyle.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      height: 1.0,
    );

extension on Breakpoint {
  _Scale get scale => switch (this) {
        Breakpoint.extraSmall ||
        Breakpoint.small ||
        Breakpoint.medium =>
          _Scale.dense,
        Breakpoint.large || Breakpoint.extraLarge => _Scale.light,
      };
}
