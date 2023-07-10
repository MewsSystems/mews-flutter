import 'package:flutter/material.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Font variant used for the tile. Will be set to [FontVariant.normal], if
/// not provided.
/// [FontVariant.normal] - default typography preset
/// [FontVariant.bold] - bold typography preset
enum FontVariant { normal, bold }

extension FontStyles on FontVariant {
  TextStyle get primaryStyle => switch (this) {
        FontVariant.normal => preset300s,
        FontVariant.bold => preset300b,
      };

  OptimusTypographyColor get secondaryColor => switch (this) {
        FontVariant.normal => OptimusTypographyColor.secondary,
        FontVariant.bold => OptimusTypographyColor.primary,
      };
}
