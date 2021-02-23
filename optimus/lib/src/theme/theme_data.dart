import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_data.freezed.dart';

@freezed
abstract class OptimusThemeData implements _$OptimusThemeData {
  const factory OptimusThemeData({
    @required Brightness brightness,
    @required OptimusButtonTheme buttonTheme,
  }) = _OptimusThemeData;

  const OptimusThemeData._();
}

@freezed
abstract class OptimusButtonTheme implements _$OptimusButtonTheme {
  const factory OptimusButtonTheme({
    @required Color defaultButtonColor,
    @required Color primaryColor,
    @required Color textColor,
    @required Color destructiveColor,
    @required Color warningColor,
  }) = _OptimusButtonTheme;

  const OptimusButtonTheme._();
}
