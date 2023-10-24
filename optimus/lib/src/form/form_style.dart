import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

extension TextInputStyle on OptimusThemeData {
  TextStyle getTextInputStyle({bool isEnabled = true}) => preset200r.copyWith(
        color: isEnabled ? tokens.textStaticPrimary : tokens.textDisabled,
      );

  TextStyle getPlaceholderStyle({bool isEnabled = true}) => preset200r.copyWith(
        color: isEnabled ? tokens.textStaticTertiary : tokens.textDisabled,
      );
}
