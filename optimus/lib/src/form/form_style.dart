import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

extension TextInputStyle on OptimusThemeData {
  TextStyle getTextInputStyle(OptimusWidgetSize size) => switch (size) {
        OptimusWidgetSize.small =>
          preset200s.copyWith(color: colors.defaultTextColor),
        OptimusWidgetSize.medium ||
        OptimusWidgetSize.large =>
          preset300s.copyWith(color: colors.defaultTextColor),
      };

  TextStyle getPlaceholderStyle(OptimusWidgetSize size) {
    final color = isDark ? colors.neutral0t64 : colors.neutral1000t64;
    return switch (size) {
      OptimusWidgetSize.small => preset200s.copyWith(color: color),
      OptimusWidgetSize.medium ||
      OptimusWidgetSize.large =>
        preset300s.copyWith(color: color),
    };
  }
}
