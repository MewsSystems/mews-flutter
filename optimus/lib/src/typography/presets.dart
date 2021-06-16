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
  fontFamily: 'OpenSans',
  package: 'optimus',
  fontWeight: FontWeight.w400,
  height: 1.3,
);

TextStyle preset700b(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 26, fontWeight: FontWeight.w700);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 40, fontWeight: FontWeight.w700);
  }
}

TextStyle preset600b(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 23, fontWeight: FontWeight.w700);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w700);
  }
}

TextStyle preset500b(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 21, fontWeight: FontWeight.w700);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.w700);
  }
}

TextStyle preset400b(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w700);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w700);
  }
}

TextStyle preset400s(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600);
  }
}

TextStyle preset400r(Breakpoint breakpoint) {
  switch (breakpoint.scale) {
    case _Scale.dense:
      return baseTextStyle.copyWith(fontSize: 18);
    case _Scale.light:
      return baseTextStyle.copyWith(fontSize: 20);
  }
}

TextStyle get preset300b => baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );

TextStyle get preset300s => baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );

TextStyle get preset300r => baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.5,
    );

TextStyle get preset200b => baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );

TextStyle get preset200s => baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );

TextStyle get preset200r => baseTextStyle.copyWith(fontSize: 14, height: 1.5);

TextStyle get preset100b => baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );

TextStyle get preset100s => baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );

TextStyle get preset100r => baseTextStyle.copyWith(fontSize: 12, height: 1.5);

extension on Breakpoint {
  _Scale get scale {
    switch (this) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
      case Breakpoint.medium:
        return _Scale.dense;
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return _Scale.light;
    }
  }
}
