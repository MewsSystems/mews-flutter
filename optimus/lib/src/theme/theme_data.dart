import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/src/colors/colors.dart';

part 'theme_data.freezed.dart';

@freezed
abstract class OptimusThemeData implements _$OptimusThemeData {
  const factory OptimusThemeData({
    @required Brightness brightness,
    @required OptimusColors colors,
  }) = _OptimusThemeData;

  const OptimusThemeData._();

  bool get isDark => brightness == Brightness.dark;

  Color get borderColor => isDark ? colors.neutral400 : colors.neutral50;
}
