// ignore_for_file: avoid-global-state

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/tokens/tokens_color_dark.dart';
import 'package:optimus/src/tokens/tokens_color_light.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'optimus_tokens.tailor.dart';

@Tailor(themeGetter: ThemeGetter.none)
class _$OptimusTokens {
  static List<Color> backgroundAccentPrimary = [
    DesignTokensColorLight.backgroundAccentPrimary,
    DesignTokensColorDark.backgroundAccentPrimary
  ];

  static List<Color> backgroundAccentSecondary = [
    DesignTokensColorLight.backgroundAccentSecondary,
    DesignTokensColorDark.backgroundAccentSecondary
  ];

  static List<Color> backgroundAlertBasicPrimary = [
    DesignTokensColorLight.backgroundAlertBasicPrimary,
    DesignTokensColorDark.backgroundAlertBasicPrimary
  ];

  static List<Color> backgroundInteractivePrimaryDefault = [
    DesignTokensColorLight.backgroundInteractivePrimaryDefault,
    DesignTokensColorDark.backgroundInteractivePrimaryDefault,
  ];

  static List<Color> textStaticInverse = [
    DesignTokensColorLight.textStaticInverse,
    DesignTokensColorDark.textStaticInverse,
  ];

  static List<Color> backgroundInteractivePrimaryHover = [
    DesignTokensColorLight.backgroundInteractivePrimaryHover,
    DesignTokensColorDark.backgroundInteractivePrimaryHover,
  ];

  static List<Color> backgroundInteractivePrimaryActive = [
    DesignTokensColorLight.backgroundInteractivePrimaryActive,
    DesignTokensColorDark.backgroundInteractivePrimaryActive,
  ];

  static List<Color> backgroundDisabled = [
    DesignTokensColorLight.backgroundDisabled,
    DesignTokensColorDark.backgroundDisabled,
  ];
}
