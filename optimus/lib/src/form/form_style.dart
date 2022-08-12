import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

TextStyle getTextStyle(OptimusThemeData theme, OptimusWidgetSize size) {
  final color = theme.colors.defaultTextColor;
  switch (size) {
    case OptimusWidgetSize.small:
      return preset200s.copyWith(color: color);
    case OptimusWidgetSize.medium:
    case OptimusWidgetSize.large:
      return preset300s.copyWith(color: color);
  }
}

TextStyle getPlaceholderTextStyle(
  OptimusThemeData theme,
  OptimusWidgetSize size,
) {
  final color =
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;
  switch (size) {
    case OptimusWidgetSize.small:
      return preset200s.copyWith(color: color);
    case OptimusWidgetSize.medium:
    case OptimusWidgetSize.large:
      return preset300s.copyWith(color: color);
  }
}
