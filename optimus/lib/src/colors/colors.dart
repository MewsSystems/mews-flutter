import 'package:flutter/material.dart';

/// Semantic Colors
///
/// The semantic group of colors consists of palettes dedicated
/// for system-specific usage. Each one of these colors and their
/// palettes carries a different meaning and function.
///
/// Its main goal is to convey a specific type of information.
///
/// Neutral
///
/// The palette is by name dedicated to the construction of elements that
/// carry no specific semantic information. It serves as a foundation for
/// the majority of the interface and typography.
///
/// Primary
///
/// This color serves as a primary action color across all products for
/// elements like buttons, links, and as an indication of progress and some
/// interactive components. Use sparingly to keep the maximum impact.
///
/// Success
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of success, safety, and confirmation to the user.
///
/// Info
///
/// One of the "alert" colors, its purpose is to communicate and convey an
/// informative and supportive message or feedback.
///
/// Warning
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of warning, problem, or something that requires attention.
///
/// Danger colors
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of danger, error, or destructive action.
abstract class OptimusLightColors {
  OptimusLightColors._();

  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral25 = Color(0xFFF3F3F4);
  static const neutral50 = Color(0xFFE6E6E6);
  static const neutral100 = Color(0xFFBFBFC0);
  static const neutral200 = Color(0xFF959597);
  static const neutral300 = Color(0xFF6B6B6D);
  static const neutral400 = Color(0xFF4B4B4D);
  static const neutral500 = Color(0xFF2B2B2E);
  static const neutral700 = Color(0xFF202023);
  static const neutral800 = Color(0xFF1A1A1D);
  static const neutral900 = Color(0xFF101012);
  static const neutral1000 = Color(0xFF000000);

  static const neutral0t32 = Color(0x52FFFFFF);
  static const neutral0t64 = Color(0xA3FFFFFF);
  static const neutral500t8 = Color(0x142B2B2E);
  static const neutral500t16 = Color(0x282B2B2E);
  static const neutral500t24 = Color(0x3D2B2B2E);
  static const neutral500t32 = Color(0x512B2B2E);
  static const neutral500t40 = Color(0x662B2B2E);
  static const neutral500t48 = Color(0x7A2B2B2E);
  static const neutral1000t32 = Color(0x51000000);
  static const neutral1000t64 = Color(0xA3000000);

  static const primary50 = Color(0xFFE9EDF8);
  static const primary100 = Color(0xFFC8D1ED);
  static const primary200 = Color(0xFFA3B3E1);
  static const primary300 = Color(0xFF7E95D5);
  static const primary400 = Color(0xFF627ECC);
  static const primary500 = Color(0xFF4667C3);
  static const primary700 = Color(0xFF3754B5);
  static const primary800 = Color(0xFF2F4AAE);
  static const primary900 = Color(0xFF2039A1);

  static const primary500t8 = Color(0x144667C3);
  static const primary500t16 = Color(0x284667C3);
  static const primary500t24 = Color(0x3D4667C3);
  static const primary500t32 = Color(0x514667C3);
  static const primary500t40 = Color(0x664667C3);
  static const primary500t48 = Color(0x7A4667C3);

  static const success50 = Color(0xFFE6EFEC);
  static const success100 = Color(0xFFBFD7D1);
  static const success200 = Color(0xFF95BCB2);
  static const success300 = Color(0xFF6BA193);
  static const success400 = Color(0xFF4B8D7B);
  static const success500 = Color(0xFF2B7964);
  static const success700 = Color(0xFF206652);
  static const success800 = Color(0xFF1A5C48);
  static const success900 = Color(0xFF104936);

  static const success500t8 = Color(0x142B7964);
  static const success500t16 = Color(0x282B7964);
  static const success500t24 = Color(0x3D2B7964);
  static const success500t32 = Color(0x512B7964);
  static const success500t40 = Color(0x662B7964);
  static const success500t48 = Color(0x7A2B7964);

  static const info50 = Color(0xFFE6EEF1);
  static const info100 = Color(0xFFC1D5DC);
  static const info200 = Color(0xFF98BAC4);
  static const info300 = Color(0xFF6F9EAC);
  static const info400 = Color(0xFF50899B);
  static const info500 = Color(0xFF317489);
  static const info700 = Color(0xFF256176);
  static const info800 = Color(0xFF1F576C);
  static const info900 = Color(0xFF134459);

  static const info500t8 = Color(0x14317489);
  static const info500t16 = Color(0x28317489);
  static const info500t24 = Color(0x3D317489);
  static const info500t32 = Color(0x51317489);
  static const info500t40 = Color(0x66317489);
  static const info500t48 = Color(0x7A317489);

  static const warning50 = Color(0xFFFEF3EB);
  static const warning100 = Color(0xFFFCE0CD);
  static const warning200 = Color(0xFFFACBAC);
  static const warning300 = Color(0xFFF8B68B);
  static const warning400 = Color(0xFFF7A772);
  static const warning500 = Color(0xFFF59759);
  static const warning700 = Color(0xFFF28448);
  static const warning800 = Color(0xFFF07A3E);
  static const warning900 = Color(0xFFEE692E);

  static const warning500t8 = Color(0x14F59759);
  static const warning500t16 = Color(0x28F59759);
  static const warning500t24 = Color(0x3DF59759);
  static const warning500t32 = Color(0x51F59759);
  static const warning500t40 = Color(0x66F59759);
  static const warning500t48 = Color(0x7AF59759);

  static const danger50 = Color(0xFFFAE7E9);
  static const danger100 = Color(0xFFF3C3C8);
  static const danger200 = Color(0xFFEB9CA4);
  static const danger300 = Color(0xFFE2747F);
  static const danger400 = Color(0xFFDC5663);
  static const danger500 = Color(0xFFD63848);
  static const danger700 = Color(0xFFCC2B38);
  static const danger800 = Color(0xFFC62430);
  static const danger900 = Color(0xFFBC1721);

  static const danger500t8 = Color(0x14D63848);
  static const danger500t16 = Color(0x28D63848);
  static const danger500t24 = Color(0x3DD63848);
  static const danger500t32 = Color(0x51D63848);
  static const danger500t40 = Color(0x66D63848);
  static const danger500t48 = Color(0x7AD63848);

  static const basic = neutral500;
  static const primary = primary500;
  static const success = success500;
  static const info = info500;
  static const warning = warning500;
  static const danger = danger500;
}

abstract class OptimusDarkColors {
  OptimusDarkColors._();

  static const neutral0 = Color(0xFFFFFFFF);
  static const neutral25 = Color(0xFFF3F3F4);
  static const neutral50 = Color(0xFFE6E6E6);
  static const neutral100 = Color(0xFFBFBFC0);
  static const neutral200 = Color(0xFF959597);
  static const neutral300 = Color(0xFF6B6B6D);
  static const neutral400 = Color(0xFF4B4B4D);
  static const neutral500 = Color(0xFF2B2B2E);
  static const neutral700 = Color(0xFF202023);
  static const neutral800 = Color(0xFF1A1A1D);
  static const neutral900 = Color(0xFF101012);
  static const neutral1000 = Color(0xFF000000);

  static const neutral0t32 = Color(0x52FFFFFF);
  static const neutral0t64 = Color(0xA3FFFFFF);
  static const neutral500t8 = Color(0x142B2B2E);
  static const neutral500t16 = Color(0x282B2B2E);
  static const neutral500t24 = Color(0x3D2B2B2E);
  static const neutral500t32 = Color(0x512B2B2E);
  static const neutral500t40 = Color(0x662B2B2E);
  static const neutral500t48 = Color(0x7A2B2B2E);
  static const neutral1000t32 = Color(0x51000000);
  static const neutral1000t64 = Color(0xA3000000);

  static const primary50 = Color(0xFFF0F2FA);
  static const primary100 = Color(0xFFD8DFF2);
  static const primary200 = Color(0xFFBFCAEA);
  static const primary300 = Color(0xFFA5B5E2);
  static const primary400 = Color(0xFF91A5DB);
  static const primary500 = Color(0xFF7E95D5);
  static const primary700 = Color(0xFF6B82CA);
  static const primary800 = Color(0xFF6178C4);
  static const primary900 = Color(0xFF4E67BA);

  static const primary500t8 = Color(0x147E95D5);
  static const primary500t16 = Color(0x287E95D5);
  static const primary500t24 = Color(0x3D7E95D5);
  static const primary500t32 = Color(0x517E95D5);
  static const primary500t40 = Color(0x667E95D5);
  static const primary500t48 = Color(0x7A7E95D5);

  static const success50 = Color(0xFFEDF4F2);
  static const success100 = Color(0xFFD3E3DF);
  static const success200 = Color(0xFFB5D0C9);
  static const success300 = Color(0xFF97BDB3);
  static const success400 = Color(0xFF81AFA3);
  static const success500 = Color(0xFF6BA193);
  static const success700 = Color(0xFF588F80);
  static const success800 = Color(0xFF4E8576);
  static const success900 = Color(0xFF3C7464);

  static const success500t8 = Color(0x146BA193);
  static const success500t16 = Color(0x286BA193);
  static const success500t24 = Color(0x3D6BA193);
  static const success500t32 = Color(0x516BA193);
  static const success500t40 = Color(0x666BA193);
  static const success500t48 = Color(0x7A6BA193);

  static const info50 = Color(0xFFEEF3F5);
  static const info100 = Color(0xFFD4E2E6);
  static const info200 = Color(0xFFB7CFD6);
  static const info300 = Color(0xFF9ABBC5);
  static const info400 = Color(0xFF85ADB8);
  static const info500 = Color(0xFF6F9EAC);
  static const info700 = Color(0xFF5C8C9B);
  static const info800 = Color(0xFF528292);
  static const info900 = Color(0xFF407082);

  static const info500t8 = Color(0x146F9EAC);
  static const info500t16 = Color(0x286F9EAC);
  static const info500t24 = Color(0x3D6F9EAC);
  static const info500t32 = Color(0x516F9EAC);
  static const info500t40 = Color(0x666F9EAC);
  static const info500t48 = Color(0x7A6F9EAC);

  static const warning50 = Color(0xFFFEF6F1);
  static const warning100 = Color(0xFFFDE9DC);
  static const warning200 = Color(0xFFFCDBC5);
  static const warning300 = Color(0xFFFACCAE);
  static const warning400 = Color(0xFFF9C19C);
  static const warning500 = Color(0xFFF8B68B);
  static const warning700 = Color(0xFFF6A678);
  static const warning800 = Color(0xFFF59E6E);
  static const warning900 = Color(0xFFF38E5B);

  static const warning500t8 = Color(0x14F8B68B);
  static const warning500t16 = Color(0x28F8B68B);
  static const warning500t24 = Color(0x3DF8B68B);
  static const warning500t32 = Color(0x51F8B68B);
  static const warning500t40 = Color(0x66F8B68B);
  static const warning500t48 = Color(0x7AF8B68B);

  static const danger50 = Color(0xFFFCEEF0);
  static const danger100 = Color(0xFFF6D5D9);
  static const danger200 = Color(0xFFF1BABF);
  static const danger300 = Color(0xFFEB9EA5);
  static const danger400 = Color(0xFFE68992);
  static const danger500 = Color(0xFFE2747F);
  static const danger700 = Color(0xFFDA616C);
  static const danger800 = Color(0xFFD65762);
  static const danger900 = Color(0xFFCF444F);

  static const danger500t8 = Color(0x14E2747F);
  static const danger500t16 = Color(0x28E2747F);
  static const danger500t24 = Color(0x3DE2747F);
  static const danger500t32 = Color(0x51E2747F);
  static const danger500t40 = Color(0x66E2747F);
  static const danger500t48 = Color(0x7AE2747F);

  static const basic = neutral500;
  static const primary = primary500;
  static const success = success500;
  static const info = info500;
  static const warning = warning500;
  static const danger = danger500;
}

class OptimusColors {
  OptimusColors(this.brightness);

  final Brightness brightness;

  Color get defaultTextColor => _isLight ? neutral1000 : neutral0;

  Color get invertedTextColor => _isLight ? neutral0 : neutral1000;

  Color get secondaryTextColor => _isLight ? neutral1000t64 : neutral0t64;

  Color get invertedSecondaryTextColor =>
      _isLight ? neutral0t64 : neutral1000t64;

  bool get _isLight => brightness == Brightness.light;

  Color get selectedTabItemColor =>
      _isLight ? OptimusLightColors.neutral1000 : OptimusDarkColors.neutral0;

  Color get unselectedTabItemColor => _isLight
      ? OptimusLightColors.neutral1000t64
      : OptimusDarkColors.neutral0t64;

  Color get bottomTabBarBackground =>
      _isLight ? OptimusLightColors.neutral0 : OptimusDarkColors.neutral800;

  Color get background =>
      _isLight ? OptimusLightColors.neutral0 : OptimusDarkColors.neutral1000;

  Color get horizontalBorder =>
      _isLight ? OptimusLightColors.neutral50 : OptimusDarkColors.neutral400;

  Color get neutral0 =>
      _isLight ? OptimusLightColors.neutral0 : OptimusDarkColors.neutral0;

  Color get neutral25 =>
      _isLight ? OptimusLightColors.neutral25 : OptimusDarkColors.neutral25;

  Color get neutral50 =>
      _isLight ? OptimusLightColors.neutral50 : OptimusDarkColors.neutral50;

  Color get neutral100 =>
      _isLight ? OptimusLightColors.neutral100 : OptimusDarkColors.neutral100;

  Color get neutral200 =>
      _isLight ? OptimusLightColors.neutral200 : OptimusDarkColors.neutral200;

  Color get neutral300 =>
      _isLight ? OptimusLightColors.neutral300 : OptimusDarkColors.neutral300;

  Color get neutral400 =>
      _isLight ? OptimusLightColors.neutral400 : OptimusDarkColors.neutral400;

  Color get neutral500 =>
      _isLight ? OptimusLightColors.neutral500 : OptimusDarkColors.neutral500;

  Color get neutral700 =>
      _isLight ? OptimusLightColors.neutral700 : OptimusDarkColors.neutral700;

  Color get neutral800 =>
      _isLight ? OptimusLightColors.neutral800 : OptimusDarkColors.neutral800;

  Color get neutral900 =>
      _isLight ? OptimusLightColors.neutral900 : OptimusDarkColors.neutral900;

  Color get neutral1000 =>
      _isLight ? OptimusLightColors.neutral1000 : OptimusDarkColors.neutral1000;

  Color get neutral0t32 =>
      _isLight ? OptimusLightColors.neutral0t32 : OptimusDarkColors.neutral0t32;

  Color get neutral0t64 =>
      _isLight ? OptimusLightColors.neutral0t64 : OptimusDarkColors.neutral0t64;

  Color get neutral500t8 => _isLight
      ? OptimusLightColors.neutral500t8
      : OptimusDarkColors.neutral500t8;

  Color get neutral500t16 => _isLight
      ? OptimusLightColors.neutral500t16
      : OptimusDarkColors.neutral500t16;

  Color get neutral500t24 => _isLight
      ? OptimusLightColors.neutral500t24
      : OptimusDarkColors.neutral500t24;

  Color get neutral500t32 => _isLight
      ? OptimusLightColors.neutral500t32
      : OptimusDarkColors.neutral500t32;

  Color get neutral500t40 => _isLight
      ? OptimusLightColors.neutral500t40
      : OptimusDarkColors.neutral500t40;

  Color get neutral500t48 => _isLight
      ? OptimusLightColors.neutral500t48
      : OptimusDarkColors.neutral500t48;

  Color get neutral1000t32 => _isLight
      ? OptimusLightColors.neutral1000t32
      : OptimusDarkColors.neutral1000t32;

  Color get neutral1000t64 => _isLight
      ? OptimusLightColors.neutral1000t64
      : OptimusDarkColors.neutral1000t64;

  Color get primary50 =>
      _isLight ? OptimusLightColors.primary50 : OptimusDarkColors.primary50;

  Color get primary100 =>
      _isLight ? OptimusLightColors.primary100 : OptimusDarkColors.primary100;

  Color get primary200 =>
      _isLight ? OptimusLightColors.primary200 : OptimusDarkColors.primary200;

  Color get primary300 =>
      _isLight ? OptimusLightColors.primary300 : OptimusDarkColors.primary300;

  Color get primary400 =>
      _isLight ? OptimusLightColors.primary400 : OptimusDarkColors.primary400;

  Color get primary500 =>
      _isLight ? OptimusLightColors.primary500 : OptimusDarkColors.primary500;

  Color get primary700 =>
      _isLight ? OptimusLightColors.primary700 : OptimusDarkColors.primary700;

  Color get primary800 =>
      _isLight ? OptimusLightColors.primary800 : OptimusDarkColors.primary800;

  Color get primary900 =>
      _isLight ? OptimusLightColors.primary900 : OptimusDarkColors.primary900;

  Color get primary500t8 => _isLight
      ? OptimusLightColors.primary500t8
      : OptimusDarkColors.primary500t8;

  Color get primary500t16 => _isLight
      ? OptimusLightColors.primary500t16
      : OptimusDarkColors.primary500t16;

  Color get primary500t24 => _isLight
      ? OptimusLightColors.primary500t24
      : OptimusDarkColors.primary500t24;

  Color get primary500t32 => _isLight
      ? OptimusLightColors.primary500t32
      : OptimusDarkColors.primary500t32;

  Color get primary500t40 => _isLight
      ? OptimusLightColors.primary500t40
      : OptimusDarkColors.primary500t40;

  Color get primary500t48 => _isLight
      ? OptimusLightColors.primary500t48
      : OptimusDarkColors.primary500t48;

  Color get success50 =>
      _isLight ? OptimusLightColors.success50 : OptimusDarkColors.success50;

  Color get success100 =>
      _isLight ? OptimusLightColors.success100 : OptimusDarkColors.success100;

  Color get success200 =>
      _isLight ? OptimusLightColors.success200 : OptimusDarkColors.success200;

  Color get success300 =>
      _isLight ? OptimusLightColors.success300 : OptimusDarkColors.success300;

  Color get success400 =>
      _isLight ? OptimusLightColors.success400 : OptimusDarkColors.success400;

  Color get success500 =>
      _isLight ? OptimusLightColors.success500 : OptimusDarkColors.success500;

  Color get success700 =>
      _isLight ? OptimusLightColors.success700 : OptimusDarkColors.success700;

  Color get success800 =>
      _isLight ? OptimusLightColors.success800 : OptimusDarkColors.success800;

  Color get success900 =>
      _isLight ? OptimusLightColors.success900 : OptimusDarkColors.success900;

  Color get success500t8 => _isLight
      ? OptimusLightColors.success500t8
      : OptimusDarkColors.success500t8;

  Color get success500t16 => _isLight
      ? OptimusLightColors.success500t16
      : OptimusDarkColors.success500t16;

  Color get success500t24 => _isLight
      ? OptimusLightColors.success500t24
      : OptimusDarkColors.success500t24;

  Color get success500t32 => _isLight
      ? OptimusLightColors.success500t32
      : OptimusDarkColors.success500t32;

  Color get success500t40 => _isLight
      ? OptimusLightColors.success500t40
      : OptimusDarkColors.success500t40;

  Color get success500t48 => _isLight
      ? OptimusLightColors.success500t48
      : OptimusDarkColors.success500t48;

  Color get info50 =>
      _isLight ? OptimusLightColors.info50 : OptimusDarkColors.info50;

  Color get info100 =>
      _isLight ? OptimusLightColors.info100 : OptimusDarkColors.info100;

  Color get info200 =>
      _isLight ? OptimusLightColors.info200 : OptimusDarkColors.info200;

  Color get info300 =>
      _isLight ? OptimusLightColors.info300 : OptimusDarkColors.info300;

  Color get info400 =>
      _isLight ? OptimusLightColors.info400 : OptimusDarkColors.info400;

  Color get info500 =>
      _isLight ? OptimusLightColors.info500 : OptimusDarkColors.info500;

  Color get info700 =>
      _isLight ? OptimusLightColors.info700 : OptimusDarkColors.info700;

  Color get info800 =>
      _isLight ? OptimusLightColors.info800 : OptimusDarkColors.info800;

  Color get info900 =>
      _isLight ? OptimusLightColors.info900 : OptimusDarkColors.info900;

  Color get info500t8 =>
      _isLight ? OptimusLightColors.info500t8 : OptimusDarkColors.info500t8;

  Color get info500t16 =>
      _isLight ? OptimusLightColors.info500t16 : OptimusDarkColors.info500t16;

  Color get info500t24 =>
      _isLight ? OptimusLightColors.info500t24 : OptimusDarkColors.info500t24;

  Color get info500t32 =>
      _isLight ? OptimusLightColors.info500t32 : OptimusDarkColors.info500t32;

  Color get info500t40 =>
      _isLight ? OptimusLightColors.info500t40 : OptimusDarkColors.info500t40;

  Color get info500t48 =>
      _isLight ? OptimusLightColors.info500t48 : OptimusDarkColors.info500t48;

  Color get warning50 =>
      _isLight ? OptimusLightColors.warning50 : OptimusDarkColors.warning50;

  Color get warning100 =>
      _isLight ? OptimusLightColors.warning100 : OptimusDarkColors.warning100;

  Color get warning200 =>
      _isLight ? OptimusLightColors.warning200 : OptimusDarkColors.warning200;

  Color get warning300 =>
      _isLight ? OptimusLightColors.warning300 : OptimusDarkColors.warning300;

  Color get warning400 =>
      _isLight ? OptimusLightColors.warning400 : OptimusDarkColors.warning400;

  Color get warning500 =>
      _isLight ? OptimusLightColors.warning500 : OptimusDarkColors.warning500;

  Color get warning700 =>
      _isLight ? OptimusLightColors.warning700 : OptimusDarkColors.warning700;

  Color get warning800 =>
      _isLight ? OptimusLightColors.warning800 : OptimusDarkColors.warning800;

  Color get warning900 =>
      _isLight ? OptimusLightColors.warning900 : OptimusDarkColors.warning900;

  Color get warning500t8 => _isLight
      ? OptimusLightColors.warning500t8
      : OptimusDarkColors.warning500t8;

  Color get warning500t16 => _isLight
      ? OptimusLightColors.warning500t16
      : OptimusDarkColors.warning500t16;

  Color get warning500t24 => _isLight
      ? OptimusLightColors.warning500t24
      : OptimusDarkColors.warning500t24;

  Color get warning500t32 => _isLight
      ? OptimusLightColors.warning500t32
      : OptimusDarkColors.warning500t32;

  Color get warning500t40 => _isLight
      ? OptimusLightColors.warning500t40
      : OptimusDarkColors.warning500t40;

  Color get warning500t48 => _isLight
      ? OptimusLightColors.warning500t48
      : OptimusDarkColors.warning500t48;

  Color get danger50 =>
      _isLight ? OptimusLightColors.danger50 : OptimusDarkColors.danger50;

  Color get danger100 =>
      _isLight ? OptimusLightColors.danger100 : OptimusDarkColors.danger100;

  Color get danger200 =>
      _isLight ? OptimusLightColors.danger200 : OptimusDarkColors.danger200;

  Color get danger300 =>
      _isLight ? OptimusLightColors.danger300 : OptimusDarkColors.danger300;

  Color get danger400 =>
      _isLight ? OptimusLightColors.danger400 : OptimusDarkColors.danger400;

  Color get danger500 =>
      _isLight ? OptimusLightColors.danger500 : OptimusDarkColors.danger500;

  Color get danger700 =>
      _isLight ? OptimusLightColors.danger700 : OptimusDarkColors.danger700;

  Color get danger800 =>
      _isLight ? OptimusLightColors.danger800 : OptimusDarkColors.danger800;

  Color get danger900 =>
      _isLight ? OptimusLightColors.danger900 : OptimusDarkColors.danger900;

  Color get danger500t8 =>
      _isLight ? OptimusLightColors.danger500t8 : OptimusDarkColors.danger500t8;

  Color get danger500t16 => _isLight
      ? OptimusLightColors.danger500t16
      : OptimusDarkColors.danger500t16;

  Color get danger500t24 => _isLight
      ? OptimusLightColors.danger500t24
      : OptimusDarkColors.danger500t24;

  Color get danger500t32 => _isLight
      ? OptimusLightColors.danger500t32
      : OptimusDarkColors.danger500t32;

  Color get danger500t40 => _isLight
      ? OptimusLightColors.danger500t40
      : OptimusDarkColors.danger500t40;

  Color get danger500t48 => _isLight
      ? OptimusLightColors.danger500t48
      : OptimusDarkColors.danger500t48;

  Color get basic =>
      _isLight ? OptimusLightColors.basic : OptimusDarkColors.basic;

  Color get primary =>
      _isLight ? OptimusLightColors.primary : OptimusDarkColors.primary;

  Color get success =>
      _isLight ? OptimusLightColors.success : OptimusDarkColors.success;

  Color get info => _isLight ? OptimusLightColors.info : OptimusDarkColors.info;

  Color get warning =>
      _isLight ? OptimusLightColors.warning : OptimusDarkColors.warning;

  Color get danger =>
      _isLight ? OptimusLightColors.danger : OptimusDarkColors.danger;
}
