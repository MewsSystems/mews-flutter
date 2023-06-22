import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';

part 'theme_data.freezed.dart';

@freezed
class OptimusThemeData with _$OptimusThemeData {
  const factory OptimusThemeData({
    required Brightness brightness,
    required OptimusColors colors,
    required OptimusTokens tokens,
  }) = _OptimusThemeData;

  const OptimusThemeData._();

  bool get isDark => brightness == Brightness.dark;

  Color get borderColor => isDark ? colors.neutral400 : colors.neutral50;
}
