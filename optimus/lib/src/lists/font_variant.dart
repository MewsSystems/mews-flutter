import 'package:flutter/material.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Font variant used for the tile. Will be set to [FontVariant.normal], if
/// not provided.
/// [FontVariant.normal] - default typography preset
/// [FontVariant.bold] - bold typography preset
enum FontVariant { normal, bold }

extension FontStyles on FontVariant {
  TextStyle get primaryStyle {
    switch (this) {
      case FontVariant.normal:
        return preset300s;
      case FontVariant.bold:
        return preset300b;
    }
  }

  OptimusTypographyColor get secondaryColor {
    switch (this) {
      case FontVariant.normal:
        return OptimusTypographyColor.secondary;
      case FontVariant.bold:
        return OptimusTypographyColor.primary;
    }
  }
}
