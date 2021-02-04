import 'package:flutter/material.dart';

/// Brand colors
///
/// Separate from the semantic colors, this group contains
/// brand-specific colors. These colors are reserved to establish a
/// brand connection across products.
abstract class OptimusBrandColors {
  OptimusBrandColors._();

  /// Accent colors
  ///
  /// This color needs to be used in either brand-specific variation
  /// of the system components or sparingly as an accent element to avoid
  /// conflict with the semantic danger color.
  static const coral500 = Color(0xFFFF5E64);
  static const coral500t8 = Color(0x14FF5E64);
  static const coral500t16 = Color(0x28FF5E64);
  static const coral500t24 = Color(0x3DFF5E64);

  /// Secondary colors
  ///
  /// The brand secondary colors are the most versatile and can be used for
  /// brand-specific components, system backgrounds, and other neutral
  /// elements like cards.
  static const lightGrey = Color(0xFFEDECEB);
  static const mediumGrey = Color(0xFFE7E6E4);
  static const blueGrey = Color(0xFFC5CED6);
  static const pinkGrey = Color(0xFFD6C9D0);

  static const coral = coral500;
}
