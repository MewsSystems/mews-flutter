import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

extension TextInputStyle on OptimusThemeData {
  TextStyle getTextInputStyle({bool isEnabled = true}) =>
      tokens.bodyMedium.copyWith(
        color: isEnabled ? tokens.textStaticPrimary : tokens.textDisabled,
      );

  TextStyle getPlaceholderStyle({bool isEnabled = true}) =>
      tokens.bodyMedium.copyWith(
        color: isEnabled ? tokens.textStaticTertiary : tokens.textDisabled,
        overflow: .ellipsis,
      );
}
