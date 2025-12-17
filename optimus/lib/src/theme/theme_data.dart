import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';

part 'theme_data.freezed.dart';

@freezed
class OptimusThemeData with _$OptimusThemeData {
  const factory OptimusThemeData({
    required Brightness brightness,
    required OptimusTokens tokens,
  }) = _OptimusThemeData;

  const OptimusThemeData._();

  bool get isDark => brightness == .dark;
}
