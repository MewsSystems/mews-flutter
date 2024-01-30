import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/typography.dart';

/// Font variant used for the tile. Will be set to [FontVariant.normal], if
/// not provided.
/// [FontVariant.normal] - default typography preset
/// [FontVariant.bold] - bold typography preset
enum FontVariant { normal, bold }

extension FontStyles on FontVariant {
  TextStyle getPrimaryStyle(OptimusTokens tokens) => switch (this) {
        FontVariant.normal => tokens.bodyLargeStrong,
        FontVariant.bold =>
          tokens.bodyLargeStrong.copyWith(fontWeight: FontWeight.w700),
      };

  OptimusTypographyColor get secondaryColor => switch (this) {
        FontVariant.normal => OptimusTypographyColor.secondary,
        FontVariant.bold => OptimusTypographyColor.primary,
      };
}
