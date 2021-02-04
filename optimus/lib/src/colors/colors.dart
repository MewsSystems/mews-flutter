import 'package:flutter/material.dart';

abstract class OptimusColors {
  OptimusColors._();

  //todo: change to neutral
  static const basic0 = Color(0xFFFFFFFF);
  static const basic25 = Color(0xFFF3F3F4);
  static const basic50 = Color(0xFFE6E6E6);
  static const basic100 = Color(0xFFBFBFC0);
  static const basic200 = Color(0xFF959597);
  static const basic300 = Color(0xFF6B6B6D);
  static const basic400 = Color(0xFF4B4B4D);
  static const basic500 = Color(0xFF2B2B2E);
  static const basic700 = Color(0xFF202023);
  static const basic800 = Color(0xFF1A1A1D);
  static const basic900 = Color(0xFF101012);
  static const basic1000 = Color(0xFF000000);

  //todo: change to neutral
  static const basic0t32 = Color(0x52FFFFFF);
  static const basic0t64 = Color(0xA3FFFFFF);
  static const basic500t8 = Color(0x142B2B2E);
  static const basic500t16 = Color(0x282B2B2E);
  static const basic500t24 = Color(0x3D2B2B2E);
  static const basic500t32 = Color(0x512B2B2E);
  static const basic500t40 = Color(0x662B2B2E);
  static const basic500t48 = Color(0x7A2B2B2E);
  static const basic900t32 = Color(0x51000000); //todo: change to 10000
  static const basic900t64 = Color(0xA3000000); //todo: change to 10000

  static const primary50 = Color(0xFFE0EDFF);
  static const primary100 = Color(0xFFB3D1FF);
  static const primary200 = Color(0xFF80B3FF);
  static const primary300 = Color(0xFF4D95FF);
  static const primary400 = Color(0xFF267EFF);
  static const primary500 = Color(0xFF0067FF);
  static const primary700 = Color(0xFF0054FF);
  static const primary800 = Color(0xFF004AFF);
  static const primary900 = Color(0xFF0039FF);

  static const primary500t8 = Color(0x140067FF);
  static const primary500t16 = Color(0x290067FF);
  static const primary500t24 = Color(0x3D0067FF);
  static const primary500t32 = Color(0x520067FF);
  static const primary500t40 = Color(0x660067FF);
  static const primary500t48 = Color(0x7A0067FF);

  static const success50 = Color(0xFFE2F1E0);
  static const success100 = Color(0xFFB6DCB3);
  static const success200 = Color(0xFF85C580);
  static const success300 = Color(0xFF54AD4D);
  static const success400 = Color(0xFF309C26);
  static const success500 = Color(0xFF0B8A00);
  static const success700 = Color(0xFF087700);
  static const success800 = Color(0xFF066D00);
  static const success900 = Color(0xFF035A00);

  static const success500t8 = Color(0x140B8A00);
  static const success500t16 = Color(0x290B8A00);
  static const success500t24 = Color(0x3D0B8A00);
  static const success500t32 = Color(0x520B8A00);
  static const success500t40 = Color(0x660B8A00);
  static const success500t48 = Color(0x7A0B8A00);

  static const warning50 = Color(0xFFFEF0E0);
  static const warning100 = Color(0xFFFCDAB3);
  static const warning200 = Color(0xFFFBC180);
  static const warning300 = Color(0xFFF9A84D);
  static const warning400 = Color(0xFFF79526);
  static const warning500 = Color(0xFFF68200);
  static const warning700 = Color(0xFFF36F00);
  static const warning800 = Color(0xFFF26500);
  static const warning900 = Color(0xFFEF5200);

  static const warning500t8 = Color(0x14F68200);
  static const warning500t16 = Color(0x29F68200);
  static const warning500t24 = Color(0x3DF68200);
  static const warning500t32 = Color(0x52F68200);
  static const warning500t40 = Color(0x66F68200);
  static const warning500t48 = Color(0x7AF68200);

  static const danger50 = Color(0xFFFCE1E5);
  static const danger100 = Color(0xFFF8B3BE);
  static const danger200 = Color(0xFFF48192);
  static const danger300 = Color(0xFFEF4F66);
  static const danger400 = Color(0xFFEB2946);
  static const danger500 = Color(0xFFE80325);
  static const danger700 = Color(0xFFE2021B);
  static const danger800 = Color(0xFFDE0216);
  static const danger900 = Color(0xFFD8010D);

  static const danger500t8 = Color(0x14E80325);
  static const danger500t16 = Color(0x29E80325);
  static const danger500t24 = Color(0x3DE80325);
  static const danger500t32 = Color(0x52E80325);
  static const danger500t40 = Color(0x66E80325);
  static const danger500t48 = Color(0x7AE80325);

  static const basic = basic500;
  static const primary = primary500;
  static const success = success500;
  static const warning = warning500;
  static const danger = danger500;
}
