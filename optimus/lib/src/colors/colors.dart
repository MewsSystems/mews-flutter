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
/// Indigo
///
/// This color serves as a primary action color across all products for
/// elements like buttons, links, and as an indication of progress and some
/// interactive components. Use sparingly to keep the maximum impact.
///
/// Green
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of success, safety, and confirmation to the user.
///
/// Blue
///
/// One of the "alert" colors, its purpose is to communicate and convey an
/// informative and supportive message or feedback.
///
/// Yellow
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of warning, problem, or something that requires attention.
///
/// Danger colors
///
/// One of the "alert" colors, its purpose is to communicate and convey a
/// sense of danger, error, or destructive action.
abstract final class OptimusSemanticColors {
  const OptimusSemanticColors._();

  static const white = Color(0xFFFFFFFF);

  static const whitet32 = Color(0x51FFFFFF);
  static const whitet64 = Color(0xA3FFFFFF);

  static const night100 = Color(0xFFF5F5F5);
  static const night200 = Color(0xFFE7E7E7);
  static const night300 = Color(0xFFBCBBC2);
  static const night400 = Color(0xFFA4A3AC);
  static const night500 = Color(0xFF8B8A94);
  static const night600 = Color(0xFF72717D);
  static const night700 = Color(0xFF5E5D6B);
  static const night800 = Color(0xFF4A4959);
  static const night900 = Color(0xFF242435);

  static const night600t24 = Color(0x3D72717D);

  static const night700t8 = Color(0x145E5D6B);
  static const night700t16 = Color(0x285E5D6B);
  static const night700t24 = Color(0x3D5E5D6B);
  static const night700t32 = Color(0x515E5D6B);
  static const night700t40 = Color(0x665E5D6B);
  static const night700t48 = Color(0x7A5E5D6B);

  static const night900t32 = Color(0x51242435);
  static const night900t64 = Color(0xA3242435);

  static const grey100 = Color(0xFFEBEBED);
  static const grey200 = Color(0xFFD5D4D8);
  static const grey300 = Color(0xFFACAAB3);
  static const grey400 = Color(0xFF787583);
  static const grey500 = Color(0xFF585565);
  static const grey600 = Color(0xFF4C495A);
  static const grey700 = Color(0xFF403E4F);
  static const grey800 = Color(0xFF2E2C3F);
  static const grey900 = Color(0xFF1E1C2B);
  static const grey1000 = Color(0xFF181621);
  static const grey1100 = Color(0xFF08070C);

  static const grey700t24 = Color(0x3D403E4F);

  static const grey1000t8 = Color(0x14181621);
  static const grey1000t16 = Color(0x28181621);
  static const grey1000t24 = Color(0x3D181621);
  static const grey1000t32 = Color(0x51181621);
  static const grey1000t40 = Color(0x66181621);
  static const grey1000t48 = Color(0x7A181621);

  static const grey1100t32 = Color(0x5108070C);
  static const grey1100t64 = Color(0xA308070C);

  static const indigo100 = Color(0xFFEFEFFF);
  static const indigo200 = Color(0xFFB3B2FB);
  static const indigo300 = Color(0xFF8B89F3);
  static const indigo400 = Color(0xFF6C69E8);
  static const indigo500 = Color(0xFF3E3BD9);
  static const indigo600 = Color(0xFF2D2BBA);
  static const indigo700 = Color(0xFF1F1D9C);
  static const indigo800 = Color(0xFF14127D);
  static const indigo900 = Color(0xFF0C0B68);

  static const indigo300t8 = Color(0x148B89F3);
  static const indigo300t16 = Color(0x288B89F3);
  static const indigo300t24 = Color(0x3D8B89F3);
  static const indigo300t32 = Color(0x518B89F3);
  static const indigo300t40 = Color(0x668B89F3);
  static const indigo300t48 = Color(0x7A8B89F3);

  static const indigo500t8 = Color(0x143E3BD9);
  static const indigo500t16 = Color(0x283E3BD9);
  static const indigo500t24 = Color(0x3D3E3BD9);
  static const indigo500t32 = Color(0x513E3BD9);
  static const indigo500t40 = Color(0x663E3BD9);
  static const indigo500t48 = Color(0x7A3E3BD9);

  static const green100 = Color(0xFFEFFDE3);
  static const green200 = Color(0xFFDDFBC9);
  static const green300 = Color(0xFFC2F4AB);
  static const green400 = Color(0xFFA8EA92);
  static const green500 = Color(0xFF81DD6E);
  static const green600 = Color(0xFF5BBE51);
  static const green700 = Color(0xFF39A037);
  static const green800 = Color(0xFF237F28);
  static const green900 = Color(0xFF166A1F);

  static const green500t8 = Color(0x1481DD6E);
  static const green500t16 = Color(0x2881DD6E);
  static const green500t24 = Color(0x3D81DD6E);
  static const green500t32 = Color(0x5181DD6E);
  static const green500t40 = Color(0x6681DD6E);
  static const green500t48 = Color(0x7A81DD6E);

  static const green700t8 = Color(0x1439A037);
  static const green700t16 = Color(0x2839A037);
  static const green700t24 = Color(0x3D39A037);
  static const green700t32 = Color(0x5139A037);
  static const green700t40 = Color(0x6639A037);
  static const green700t48 = Color(0x7A39A037);

  static const blue100 = Color(0xFFE7EEFD);
  static const blue200 = Color(0xFFD6E2FC);
  static const blue300 = Color(0xFFA2BEE8);
  static const blue400 = Color(0xFF80A6DF);
  static const blue500 = Color(0xFF5A8CD6);
  static const blue600 = Color(0xFF2365C8);
  static const blue700 = Color(0xFF205CB6);
  static const blue800 = Color(0xFF194990);
  static const blue900 = Color(0xFF143A72);

  static const blue300t8 = Color(0x14A2BEE8);
  static const blue300t16 = Color(0x28A2BEE8);
  static const blue300t24 = Color(0x3DA2BEE8);
  static const blue300t32 = Color(0x51A2BEE8);
  static const blue300t40 = Color(0x66A2BEE8);
  static const blue300t48 = Color(0x7AA2BEE8);

  static const blue500t8 = Color(0x145A8CD6);
  static const blue500t16 = Color(0x285A8CD6);
  static const blue500t24 = Color(0x3D5A8CD6);
  static const blue500t32 = Color(0x515A8CD6);
  static const blue500t40 = Color(0x665A8CD6);
  static const blue500t48 = Color(0x7A5A8CD6);

  static const blue600t8 = Color(0x142365C8);
  static const blue600t16 = Color(0x282365C8);
  static const blue600t24 = Color(0x3D2365C8);
  static const blue600t32 = Color(0x512365C8);
  static const blue600t40 = Color(0x662365C8);
  static const blue600t48 = Color(0x7A2365C8);

  static const yellow100 = Color(0xFFFFFAE1);
  static const yellow200 = Color(0xFFFFEFB3);
  static const yellow300 = Color(0xFFFFE48D);
  static const yellow400 = Color(0xFFFFD871);
  static const yellow500 = Color(0xFFFFC641);
  static const yellow600 = Color(0xFFDBA22F);
  static const yellow700 = Color(0xFFB78121);
  static const yellow800 = Color(0xFF926115);
  static const yellow900 = Color(0xFF7B4B0D);

  static const yellow500t8 = Color(0x14FFC641);
  static const yellow500t16 = Color(0x28FFC641);
  static const yellow500t24 = Color(0x3DFFC641);
  static const yellow500t32 = Color(0x51FFC641);
  static const yellow500t40 = Color(0x66FFC641);
  static const yellow500t48 = Color(0x7AFFC641);

  static const red100 = Color(0xFFFEDDD8);
  static const red200 = Color(0xFFFFBBB2);
  static const red300 = Color(0xFFFD9789);
  static const red400 = Color(0xFFFC736A);
  static const red500 = Color(0xFFED4646);
  static const red600 = Color(0xFFD62F29);
  static const red700 = Color(0xFFB31C23);
  static const red800 = Color(0xFF901122);
  static const red900 = Color(0xFF770A21);

  static const red500t8 = Color(0x14ED4646);
  static const red500t16 = Color(0x28ED4646);
  static const red500t24 = Color(0x3DED4646);
  static const red500t32 = Color(0x51ED4646);
  static const red500t40 = Color(0x66ED4646);
  static const red500t48 = Color(0x7AED4646);

  static const red600t8 = Color(0x14D62F29);
  static const red600t16 = Color(0x28D62F29);
  static const red600t24 = Color(0x3DD62F29);
  static const red600t32 = Color(0x51D62F29);
  static const red600t40 = Color(0x66D62F29);
  static const red600t48 = Color(0x7AD62F29);
}

abstract final class OptimusLightColors {
  const OptimusLightColors._();

  static const neutral0 = OptimusSemanticColors.white;
  static const neutral25 = OptimusSemanticColors.night100;
  static const neutral50 = OptimusSemanticColors.night200;
  static const neutral100 = OptimusSemanticColors.night300;
  static const neutral200 = OptimusSemanticColors.night400;
  static const neutral300 = OptimusSemanticColors.night500;
  static const neutral400 = OptimusSemanticColors.night600;
  static const neutral500 = OptimusSemanticColors.night700;
  static const neutral700 = OptimusSemanticColors.night800;
  static const neutral800 = OptimusSemanticColors.night900;
  static const neutral900 = OptimusSemanticColors.night900;
  static const neutral1000 = OptimusSemanticColors.night900;

  static const neutral0t32 = OptimusSemanticColors.whitet32;
  static const neutral0t64 = OptimusSemanticColors.whitet64;
  static const neutral400t24 = OptimusSemanticColors.night600t24;
  static const neutral500t8 = OptimusSemanticColors.night700t8;
  static const neutral500t16 = OptimusSemanticColors.night700t16;
  static const neutral500t24 = OptimusSemanticColors.night700t24;
  static const neutral500t32 = OptimusSemanticColors.night700t32;
  static const neutral500t40 = OptimusSemanticColors.night700t40;
  static const neutral500t48 = OptimusSemanticColors.night700t48;
  static const neutral1000t32 = OptimusSemanticColors.night900t32;
  static const neutral1000t64 = OptimusSemanticColors.night900t64;

  static const primary50 = OptimusSemanticColors.indigo100;
  static const primary100 = OptimusSemanticColors.indigo200;
  static const primary200 = OptimusSemanticColors.indigo200;
  static const primary300 = OptimusSemanticColors.indigo300;
  static const primary400 = OptimusSemanticColors.indigo400;
  static const primary500 = OptimusSemanticColors.indigo500;
  static const primary700 = OptimusSemanticColors.indigo600;
  static const primary800 = OptimusSemanticColors.indigo800;
  static const primary900 = OptimusSemanticColors.indigo900;

  static const primary500t8 = OptimusSemanticColors.indigo500t8;
  static const primary500t16 = OptimusSemanticColors.indigo500t16;
  static const primary500t24 = OptimusSemanticColors.indigo500t24;
  static const primary500t32 = OptimusSemanticColors.indigo500t32;
  static const primary500t40 = OptimusSemanticColors.indigo500t40;
  static const primary500t48 = OptimusSemanticColors.indigo500t48;

  static const success50 = OptimusSemanticColors.green100;
  static const success100 = OptimusSemanticColors.green200;
  static const success200 = OptimusSemanticColors.green300;
  static const success300 = OptimusSemanticColors.green400;
  static const success400 = OptimusSemanticColors.green500;
  static const success500 = OptimusSemanticColors.green700;
  static const success700 = OptimusSemanticColors.green800;
  static const success800 = OptimusSemanticColors.green800;
  static const success900 = OptimusSemanticColors.green900;

  static const success500t8 = OptimusSemanticColors.green700t8;
  static const success500t16 = OptimusSemanticColors.green700t16;
  static const success500t24 = OptimusSemanticColors.green700t24;
  static const success500t32 = OptimusSemanticColors.green700t32;
  static const success500t40 = OptimusSemanticColors.green700t40;
  static const success500t48 = OptimusSemanticColors.green700t48;

  static const info50 = OptimusSemanticColors.blue100;
  static const info100 = OptimusSemanticColors.blue200;
  static const info200 = OptimusSemanticColors.blue300;
  static const info300 = OptimusSemanticColors.blue400;
  static const info400 = OptimusSemanticColors.blue500;
  static const info500 = OptimusSemanticColors.blue600;
  static const info700 = OptimusSemanticColors.blue700;
  static const info800 = OptimusSemanticColors.blue800;
  static const info900 = OptimusSemanticColors.blue900;

  static const info500t8 = OptimusSemanticColors.blue600t8;
  static const info500t16 = OptimusSemanticColors.blue600t16;
  static const info500t24 = OptimusSemanticColors.blue600t24;
  static const info500t32 = OptimusSemanticColors.blue600t32;
  static const info500t40 = OptimusSemanticColors.blue600t40;
  static const info500t48 = OptimusSemanticColors.blue600t48;

  static const warning50 = OptimusSemanticColors.yellow100;
  static const warning100 = OptimusSemanticColors.yellow200;
  static const warning200 = OptimusSemanticColors.yellow200;
  static const warning300 = OptimusSemanticColors.yellow300;
  static const warning400 = OptimusSemanticColors.yellow400;
  static const warning500 = OptimusSemanticColors.yellow500;
  static const warning700 = OptimusSemanticColors.yellow600;
  static const warning800 = OptimusSemanticColors.yellow800;
  static const warning900 = OptimusSemanticColors.yellow900;

  static const warning500t8 = OptimusSemanticColors.yellow500t8;
  static const warning500t16 = OptimusSemanticColors.yellow500t16;
  static const warning500t24 = OptimusSemanticColors.yellow500t24;
  static const warning500t32 = OptimusSemanticColors.yellow500t32;
  static const warning500t40 = OptimusSemanticColors.yellow500t40;
  static const warning500t48 = OptimusSemanticColors.yellow500t48;

  static const danger50 = OptimusSemanticColors.red100;
  static const danger100 = OptimusSemanticColors.red200;
  static const danger200 = OptimusSemanticColors.red300;
  static const danger300 = OptimusSemanticColors.red400;
  static const danger400 = OptimusSemanticColors.red500;
  static const danger500 = OptimusSemanticColors.red600;
  static const danger700 = OptimusSemanticColors.red700;
  static const danger800 = OptimusSemanticColors.red800;
  static const danger900 = OptimusSemanticColors.red900;

  static const danger500t8 = OptimusSemanticColors.red600t8;
  static const danger500t16 = OptimusSemanticColors.red600t16;
  static const danger500t24 = OptimusSemanticColors.red600t24;
  static const danger500t32 = OptimusSemanticColors.red600t32;
  static const danger500t40 = OptimusSemanticColors.red600t40;
  static const danger500t48 = OptimusSemanticColors.red600t48;

  static const basic = neutral500;
  static const primary = primary500;
  static const success = success500;
  static const info = info500;
  static const warning = warning500;
  static const danger = danger500;
}

abstract final class OptimusDarkColors {
  const OptimusDarkColors._();

  static const neutral0 = OptimusSemanticColors.white;
  static const neutral25 = OptimusSemanticColors.grey100;
  static const neutral50 = OptimusSemanticColors.grey200;
  static const neutral100 = OptimusSemanticColors.grey300;
  static const neutral200 = OptimusSemanticColors.grey500;
  static const neutral300 = OptimusSemanticColors.grey600;
  static const neutral400 = OptimusSemanticColors.grey700;
  static const neutral500 = OptimusSemanticColors.grey1000;
  static const neutral700 = OptimusSemanticColors.grey1000;
  static const neutral800 = OptimusSemanticColors.grey1000;
  static const neutral900 = OptimusSemanticColors.grey1100;
  static const neutral1000 = OptimusSemanticColors.grey1100;

  static const neutral0t32 = OptimusSemanticColors.whitet32;
  static const neutral0t64 = OptimusSemanticColors.whitet64;
  static const neutral400t24 = OptimusSemanticColors.grey700t24;
  static const neutral500t8 = OptimusSemanticColors.grey1000t8;
  static const neutral500t16 = OptimusSemanticColors.grey1000t16;
  static const neutral500t24 = OptimusSemanticColors.grey1000t24;
  static const neutral500t32 = OptimusSemanticColors.grey1000t32;
  static const neutral500t40 = OptimusSemanticColors.grey1000t40;
  static const neutral500t48 = OptimusSemanticColors.grey1000t48;
  static const neutral1000t32 = OptimusSemanticColors.grey1100t32;
  static const neutral1000t64 = OptimusSemanticColors.grey1100t64;

  static const primary50 = OptimusSemanticColors.indigo100;
  static const primary100 = OptimusSemanticColors.indigo100;
  static const primary200 = OptimusSemanticColors.indigo100;
  static const primary300 = OptimusSemanticColors.indigo100;
  static const primary400 = OptimusSemanticColors.indigo200;
  static const primary500 = OptimusSemanticColors.indigo300;
  static const primary700 = OptimusSemanticColors.indigo400;
  static const primary800 = OptimusSemanticColors.indigo500;
  static const primary900 = OptimusSemanticColors.indigo600;

  static const primary500t8 = OptimusSemanticColors.indigo300t8;
  static const primary500t16 = OptimusSemanticColors.indigo300t16;
  static const primary500t24 = OptimusSemanticColors.indigo300t24;
  static const primary500t32 = OptimusSemanticColors.indigo300t32;
  static const primary500t40 = OptimusSemanticColors.indigo300t40;
  static const primary500t48 = OptimusSemanticColors.indigo300t48;

  static const success50 = OptimusSemanticColors.green100;
  static const success100 = OptimusSemanticColors.green100;
  static const success200 = OptimusSemanticColors.green200;
  static const success300 = OptimusSemanticColors.green300;
  static const success400 = OptimusSemanticColors.green400;
  static const success500 = OptimusSemanticColors.green500;
  static const success700 = OptimusSemanticColors.green600;
  static const success800 = OptimusSemanticColors.green700;
  static const success900 = OptimusSemanticColors.green800;

  static const success500t8 = OptimusSemanticColors.green500t8;
  static const success500t16 = OptimusSemanticColors.green500t16;
  static const success500t24 = OptimusSemanticColors.green500t24;
  static const success500t32 = OptimusSemanticColors.green500t32;
  static const success500t40 = OptimusSemanticColors.green500t40;
  static const success500t48 = OptimusSemanticColors.green500t48;

  static const info50 = OptimusSemanticColors.blue100;
  static const info100 = OptimusSemanticColors.blue100;
  static const info200 = OptimusSemanticColors.blue200;
  static const info300 = OptimusSemanticColors.blue300;
  static const info400 = OptimusSemanticColors.blue400;
  static const info500 = OptimusSemanticColors.blue500;
  static const info700 = OptimusSemanticColors.blue600;
  static const info800 = OptimusSemanticColors.blue700;
  static const info900 = OptimusSemanticColors.blue800;

  static const info500t8 = OptimusSemanticColors.blue500t8;
  static const info500t16 = OptimusSemanticColors.blue500t16;
  static const info500t24 = OptimusSemanticColors.blue500t24;
  static const info500t32 = OptimusSemanticColors.blue500t32;
  static const info500t40 = OptimusSemanticColors.blue500t40;
  static const info500t48 = OptimusSemanticColors.blue500t48;

  static const warning50 = OptimusSemanticColors.yellow100;
  static const warning100 = OptimusSemanticColors.yellow200;
  static const warning200 = OptimusSemanticColors.yellow200;
  static const warning300 = OptimusSemanticColors.yellow300;
  static const warning400 = OptimusSemanticColors.yellow400;
  static const warning500 = OptimusSemanticColors.yellow500;
  static const warning700 = OptimusSemanticColors.yellow600;
  static const warning800 = OptimusSemanticColors.yellow700;
  static const warning900 = OptimusSemanticColors.yellow800;

  static const warning500t8 = OptimusSemanticColors.yellow500t8;
  static const warning500t16 = OptimusSemanticColors.yellow500t16;
  static const warning500t24 = OptimusSemanticColors.yellow500t24;
  static const warning500t32 = OptimusSemanticColors.yellow500t32;
  static const warning500t40 = OptimusSemanticColors.yellow500t40;
  static const warning500t48 = OptimusSemanticColors.yellow500t48;

  static const danger50 = OptimusSemanticColors.red100;
  static const danger100 = OptimusSemanticColors.red100;
  static const danger200 = OptimusSemanticColors.red200;
  static const danger300 = OptimusSemanticColors.red300;
  static const danger400 = OptimusSemanticColors.red400;
  static const danger500 = OptimusSemanticColors.red500;
  static const danger700 = OptimusSemanticColors.red600;
  static const danger800 = OptimusSemanticColors.red700;
  static const danger900 = OptimusSemanticColors.red800;

  static const danger500t8 = OptimusSemanticColors.red500t8;
  static const danger500t16 = OptimusSemanticColors.red500t16;
  static const danger500t24 = OptimusSemanticColors.red500t24;
  static const danger500t32 = OptimusSemanticColors.red500t32;
  static const danger500t40 = OptimusSemanticColors.red500t40;
  static const danger500t48 = OptimusSemanticColors.red500t48;

  static const basic = neutral500;
  static const primary = primary500;
  static const success = success500;
  static const info = info500;
  static const warning = warning500;
  static const danger = danger500;
}

class OptimusColors {
  const OptimusColors(this.brightness);

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

  Color get neutral400t24 => _isLight
      ? OptimusLightColors.neutral400t24
      : OptimusDarkColors.neutral400t24;

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
