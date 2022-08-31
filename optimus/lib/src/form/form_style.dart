import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

extension TextInputStyle on OptimusThemeData {
  TextStyle getTextInputStyle(OptimusWidgetSize size) {
    switch (size) {
      case OptimusWidgetSize.small:
        return preset200s.copyWith(color: colors.defaultTextColor);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300s.copyWith(color: colors.defaultTextColor);
    }
  }

  TextStyle getPlaceholderStyle(OptimusWidgetSize size) {
    final color = isDark ? colors.neutral0t64 : colors.neutral1000t64;
    switch (size) {
      case OptimusWidgetSize.small:
        return preset200s.copyWith(color: color);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300s.copyWith(color: color);
    }
  }
}
