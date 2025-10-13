// ignore_for_file: avoid-global-state

import 'package:flutter/material.dart';
import 'package:optimus/src/tokens/b2b/tokens_dark.dart';
import 'package:optimus/src/tokens/b2b/tokens_light.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

//
// optimus_tokens.dart
//

// Do not edit directly
// Generated on Tue, 30 Sep 2025 08:34:58 GMT

part 'optimus_tokens.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.none)
class OptimusTokens extends ThemeExtension<OptimusTokens>
    with _$OptimusTokensTailorMixin {
  const OptimusTokens({
    required this.backgroundAccentBrand,
    required this.backgroundAccentDanger,
    required this.backgroundAccentGradient,
    required this.backgroundAccentInfo,
    required this.backgroundAccentPrimary,
    required this.backgroundAccentSecondary,
    required this.backgroundAccentSuccess,
    required this.backgroundAccentWarning,
    required this.backgroundAlertBasicPrimary,
    required this.backgroundAlertBasicSecondary,
    required this.backgroundAlertDangerPrimary,
    required this.backgroundAlertDangerSecondary,
    required this.backgroundAlertInfoPrimary,
    required this.backgroundAlertInfoSecondary,
    required this.backgroundAlertSuccessPrimary,
    required this.backgroundAlertSuccessSecondary,
    required this.backgroundAlertWarningPrimary,
    required this.backgroundAlertWarningSecondary,
    required this.backgroundBackdrop,
    required this.backgroundBrand,
    required this.backgroundDatavizBluePrimary,
    required this.backgroundDatavizBlueSecondary,
    required this.backgroundDatavizDanger,
    required this.backgroundDatavizGreenPrimary,
    required this.backgroundDatavizGreenSecondary,
    required this.backgroundDatavizInfo,
    required this.backgroundDatavizOrangePrimary,
    required this.backgroundDatavizOrangeSecondary,
    required this.backgroundDatavizPinkPrimary,
    required this.backgroundDatavizPinkSecondary,
    required this.backgroundDatavizPurplePrimary,
    required this.backgroundDatavizPurpleSecondary,
    required this.backgroundDatavizRedPrimary,
    required this.backgroundDatavizRedSecondary,
    required this.backgroundDatavizSuccess,
    required this.backgroundDatavizWarning,
    required this.backgroundDisabled,
    required this.backgroundInteractiveDangerActive,
    required this.backgroundInteractiveDangerDefault,
    required this.backgroundInteractiveDangerHover,
    required this.backgroundInteractiveNeutralActive,
    required this.backgroundInteractiveNeutralBoldActive,
    required this.backgroundInteractiveNeutralBoldDefault,
    required this.backgroundInteractiveNeutralBoldHover,
    required this.backgroundInteractiveNeutralDefault,
    required this.backgroundInteractiveNeutralHover,
    required this.backgroundInteractiveNeutralSubtleActive,
    required this.backgroundInteractiveNeutralSubtleDefault,
    required this.backgroundInteractiveNeutralSubtleHover,
    required this.backgroundInteractivePrimaryActive,
    required this.backgroundInteractivePrimaryDefault,
    required this.backgroundInteractivePrimaryHover,
    required this.backgroundInteractiveSecondaryActive,
    required this.backgroundInteractiveSecondaryDefault,
    required this.backgroundInteractiveSecondaryHover,
    required this.backgroundInteractiveSuccessActive,
    required this.backgroundInteractiveSuccessDefault,
    required this.backgroundInteractiveSuccessHover,
    required this.backgroundStaticFlat,
    required this.backgroundStaticFloating,
    required this.backgroundStaticInverse,
    required this.backgroundStaticInverseOnColor,
    required this.backgroundStaticOnColor,
    required this.backgroundStaticRaised,
    required this.backgroundStaticSunken,
    required this.borderAccent,
    required this.borderAlertBasic,
    required this.borderAlertDanger,
    required this.borderAlertInfo,
    required this.borderAlertSuccess,
    required this.borderAlertWarning,
    required this.borderBrand,
    required this.borderDisabled,
    required this.borderInteractiveBoldActive,
    required this.borderInteractiveBoldDefault,
    required this.borderInteractiveBoldHover,
    required this.borderInteractiveFocus,
    required this.borderInteractiveInputActive,
    required this.borderInteractiveInputDefault,
    required this.borderInteractiveInputError,
    required this.borderInteractiveInputHover,
    required this.borderInteractivePrimaryActive,
    required this.borderInteractivePrimaryDefault,
    required this.borderInteractivePrimaryHover,
    required this.borderInteractiveSecondaryActive,
    required this.borderInteractiveSecondaryDefault,
    required this.borderInteractiveSecondaryHover,
    required this.borderStaticInverse,
    required this.borderStaticOnColor,
    required this.borderStaticPrimary,
    required this.borderStaticSecondary,
    required this.borderStaticTertiary,
    required this.legacyDatavizDenim100,
    required this.legacyDatavizDenim200,
    required this.legacyDatavizDenim300,
    required this.legacyDatavizDenim400,
    required this.legacyDatavizDenim50,
    required this.legacyDatavizDenim500,
    required this.legacyDatavizDenim600,
    required this.legacyDatavizDenim700,
    required this.legacyDatavizDenim800,
    required this.legacyDatavizDenim900,
    required this.legacyDatavizLavender100,
    required this.legacyDatavizLavender200,
    required this.legacyDatavizLavender300,
    required this.legacyDatavizLavender400,
    required this.legacyDatavizLavender50,
    required this.legacyDatavizLavender500,
    required this.legacyDatavizLavender600,
    required this.legacyDatavizLavender700,
    required this.legacyDatavizLavender800,
    required this.legacyDatavizLavender900,
    required this.legacyDatavizLime100,
    required this.legacyDatavizLime200,
    required this.legacyDatavizLime300,
    required this.legacyDatavizLime400,
    required this.legacyDatavizLime50,
    required this.legacyDatavizLime500,
    required this.legacyDatavizLime600,
    required this.legacyDatavizLime700,
    required this.legacyDatavizLime800,
    required this.legacyDatavizLime900,
    required this.legacyDatavizMustard100,
    required this.legacyDatavizMustard200,
    required this.legacyDatavizMustard300,
    required this.legacyDatavizMustard400,
    required this.legacyDatavizMustard50,
    required this.legacyDatavizMustard500,
    required this.legacyDatavizMustard600,
    required this.legacyDatavizMustard700,
    required this.legacyDatavizMustard800,
    required this.legacyDatavizMustard900,
    required this.legacyDatavizRuby100,
    required this.legacyDatavizRuby200,
    required this.legacyDatavizRuby300,
    required this.legacyDatavizRuby400,
    required this.legacyDatavizRuby50,
    required this.legacyDatavizRuby500,
    required this.legacyDatavizRuby600,
    required this.legacyDatavizRuby700,
    required this.legacyDatavizRuby800,
    required this.legacyDatavizRuby900,
    required this.legacyDatavizTangerine100,
    required this.legacyDatavizTangerine200,
    required this.legacyDatavizTangerine300,
    required this.legacyDatavizTangerine400,
    required this.legacyDatavizTangerine50,
    required this.legacyDatavizTangerine500,
    required this.legacyDatavizTangerine600,
    required this.legacyDatavizTangerine700,
    required this.legacyDatavizTangerine800,
    required this.legacyDatavizTangerine900,
    required this.legacyTagBackgroundBasicBold,
    required this.legacyTagBackgroundDenim,
    required this.legacyTagBackgroundLavender,
    required this.legacyTagBackgroundLime,
    required this.legacyTagBackgroundMustard,
    required this.legacyTagBackgroundPrimary,
    required this.legacyTagBackgroundRuby,
    required this.legacyTagBackgroundTangerine,
    required this.legacyTagBorderBasicBold,
    required this.legacyTagBorderDenim,
    required this.legacyTagBorderLavender,
    required this.legacyTagBorderLime,
    required this.legacyTagBorderMustard,
    required this.legacyTagBorderPrimary,
    required this.legacyTagBorderRuby,
    required this.legacyTagBorderTangerine,
    required this.legacyTagTextBasicBold,
    required this.legacyTagTextDenim,
    required this.legacyTagTextLavender,
    required this.legacyTagTextLime,
    required this.legacyTagTextMustard,
    required this.legacyTagTextPrimary,
    required this.legacyTagTextRuby,
    required this.legacyTagTextTangerine,
    required this.paletteBasicsBlack,
    required this.paletteBasicsWhite,
    required this.paletteBasicsWhite64,
    required this.paletteBrandCoral0,
    required this.paletteBrandCoral100,
    required this.paletteBrandCoral1000,
    required this.paletteBrandCoral150,
    required this.paletteBrandCoral200,
    required this.paletteBrandCoral25,
    required this.paletteBrandCoral300,
    required this.paletteBrandCoral400,
    required this.paletteBrandCoral50,
    required this.paletteBrandCoral500,
    required this.paletteBrandCoral600,
    required this.paletteBrandCoral700,
    required this.paletteBrandCoral800,
    required this.paletteBrandCoral900,
    required this.paletteBrandGrey0,
    required this.paletteBrandGrey100,
    required this.paletteBrandGrey1000,
    required this.paletteBrandGrey150,
    required this.paletteBrandGrey200,
    required this.paletteBrandGrey25,
    required this.paletteBrandGrey300,
    required this.paletteBrandGrey400,
    required this.paletteBrandGrey50,
    required this.paletteBrandGrey500,
    required this.paletteBrandGrey600,
    required this.paletteBrandGrey700,
    required this.paletteBrandGrey800,
    required this.paletteBrandGrey900,
    required this.paletteBrandIndigo0,
    required this.paletteBrandIndigo100,
    required this.paletteBrandIndigo1000,
    required this.paletteBrandIndigo150,
    required this.paletteBrandIndigo200,
    required this.paletteBrandIndigo25,
    required this.paletteBrandIndigo300,
    required this.paletteBrandIndigo400,
    required this.paletteBrandIndigo50,
    required this.paletteBrandIndigo500,
    required this.paletteBrandIndigo600,
    required this.paletteBrandIndigo700,
    required this.paletteBrandIndigo800,
    required this.paletteBrandIndigo900,
    required this.paletteBrandNight0,
    required this.paletteBrandNight064,
    required this.paletteBrandNight100,
    required this.paletteBrandNight1000,
    required this.paletteBrandNight100012,
    required this.paletteBrandNight100016,
    required this.paletteBrandNight10008,
    required this.paletteBrandNight150,
    required this.paletteBrandNight200,
    required this.paletteBrandNight25,
    required this.paletteBrandNight300,
    required this.paletteBrandNight400,
    required this.paletteBrandNight50,
    required this.paletteBrandNight500,
    required this.paletteBrandNight600,
    required this.paletteBrandNight700,
    required this.paletteBrandNight800,
    required this.paletteBrandNight900,
    required this.paletteDatavizBlue50,
    required this.paletteDatavizBlue500,
    required this.paletteDatavizGreen50,
    required this.paletteDatavizGreen500,
    required this.paletteDatavizOrange50,
    required this.paletteDatavizOrange500,
    required this.paletteDatavizPink50,
    required this.paletteDatavizPink500,
    required this.paletteDatavizPurple50,
    required this.paletteDatavizPurple500,
    required this.paletteDatavizRed50,
    required this.paletteDatavizRed500,
    required this.paletteSemanticBlue0,
    required this.paletteSemanticBlue100,
    required this.paletteSemanticBlue1000,
    required this.paletteSemanticBlue150,
    required this.paletteSemanticBlue200,
    required this.paletteSemanticBlue25,
    required this.paletteSemanticBlue300,
    required this.paletteSemanticBlue400,
    required this.paletteSemanticBlue50,
    required this.paletteSemanticBlue500,
    required this.paletteSemanticBlue600,
    required this.paletteSemanticBlue700,
    required this.paletteSemanticBlue800,
    required this.paletteSemanticBlue900,
    required this.paletteSemanticGreen0,
    required this.paletteSemanticGreen100,
    required this.paletteSemanticGreen1000,
    required this.paletteSemanticGreen150,
    required this.paletteSemanticGreen200,
    required this.paletteSemanticGreen25,
    required this.paletteSemanticGreen300,
    required this.paletteSemanticGreen400,
    required this.paletteSemanticGreen50,
    required this.paletteSemanticGreen500,
    required this.paletteSemanticGreen600,
    required this.paletteSemanticGreen700,
    required this.paletteSemanticGreen800,
    required this.paletteSemanticGreen900,
    required this.paletteSemanticOrange0,
    required this.paletteSemanticOrange100,
    required this.paletteSemanticOrange1000,
    required this.paletteSemanticOrange150,
    required this.paletteSemanticOrange200,
    required this.paletteSemanticOrange25,
    required this.paletteSemanticOrange300,
    required this.paletteSemanticOrange400,
    required this.paletteSemanticOrange50,
    required this.paletteSemanticOrange500,
    required this.paletteSemanticOrange600,
    required this.paletteSemanticOrange700,
    required this.paletteSemanticOrange800,
    required this.paletteSemanticOrange900,
    required this.paletteSemanticRed0,
    required this.paletteSemanticRed100,
    required this.paletteSemanticRed1000,
    required this.paletteSemanticRed150,
    required this.paletteSemanticRed200,
    required this.paletteSemanticRed25,
    required this.paletteSemanticRed300,
    required this.paletteSemanticRed400,
    required this.paletteSemanticRed50,
    required this.paletteSemanticRed500,
    required this.paletteSemanticRed600,
    required this.paletteSemanticRed700,
    required this.paletteSemanticRed800,
    required this.paletteSemanticRed900,
    required this.textAlertBasic,
    required this.textAlertDanger,
    required this.textAlertInfo,
    required this.textAlertSuccess,
    required this.textAlertWarning,
    required this.textDisabled,
    required this.textInteractivePrimaryActive,
    required this.textInteractivePrimaryDefault,
    required this.textInteractivePrimaryHover,
    required this.textInteractiveSecondaryActive,
    required this.textInteractiveSecondaryDefault,
    required this.textInteractiveSecondaryHover,
    required this.textStaticInverse,
    required this.textStaticOnColor,
    required this.textStaticPrimary,
    required this.textStaticSecondary,
    required this.textStaticTertiary,
    required this.visualAssetsAccent,
    required this.visualAssetsNeutralBold,
    required this.visualAssetsNeutralBold0,
    required this.visualAssetsNeutralSubtle,
    required this.visualAssetsNeutralSubtle0,
    required this.visualAssetsSemanticDanger,
    required this.visualAssetsSemanticInfo,
    required this.visualAssetsSemanticSuccess,
    required this.visualAssetsSemanticWarning,

    required this.bodyExtraSmall,
    required this.bodyExtraSmallStrong,
    required this.bodyLarge,
    required this.bodyLargeStrong,
    required this.bodyMedium,
    required this.bodyMediumStrong,
    required this.bodySmall,
    required this.bodySmallStrong,
    required this.highlightLarge,
    required this.highlightMedium,
    required this.highlightSmall,
    required this.titleLarge,
    required this.titleLargeStrong,
    required this.titleMedium,
    required this.titleMediumStrong,
    required this.titleSmall,
    required this.titleSmallStrong,

    required this.borderRadius0,
    required this.borderRadius100,
    required this.borderRadius150,
    required this.borderRadius200,
    required this.borderRadius25,
    required this.borderRadius300,
    required this.borderRadius50,
    required this.borderRadiusBase,
    required this.borderRadiusRound,

    required this.borderWidth0,
    required this.borderWidth100,
    required this.borderWidth200,
    required this.borderWidth300,
    required this.borderWidth800,
    required this.fontSize100,
    required this.fontSize200,
    required this.fontSize300,
    required this.fontSize400,
    required this.fontSize50,
    required this.fontSize500,
    required this.fontSize600,
    required this.fontSize700,
    required this.fontSize75,
    required this.fontSize800,
    required this.fontSize900,
    required this.fontSizeBase,
    required this.fontSizeRatio,
    required this.letterSpacingCondensed,
    required this.letterSpacingDefault,
    required this.letterSpacingWide,
    required this.lineHeight100,
    required this.lineHeight200,
    required this.lineHeight300,
    required this.opacity0,
    required this.opacity100,
    required this.opacity1000,
    required this.opacity150,
    required this.opacity200,
    required this.opacity400,
    required this.opacity600,
    required this.opacity800,
    required this.sizing100,
    required this.sizing1000,
    required this.sizing1200,
    required this.sizing1300,
    required this.sizing200,
    required this.sizing300,
    required this.sizing400,
    required this.sizing50,
    required this.sizing500,
    required this.sizing550,
    required this.sizing600,
    required this.sizing700,
    required this.sizing75,
    required this.sizing800,
    required this.sizing900,
    required this.sizingBase,
    required this.spacing0,
    required this.spacing100,
    required this.spacing1000,
    required this.spacing1200,
    required this.spacing150,
    required this.spacing200,
    required this.spacing25,
    required this.spacing250,
    required this.spacing300,
    required this.spacing400,
    required this.spacing450,
    required this.spacing50,
    required this.spacing500,
    required this.spacing600,
    required this.spacing700,
    required this.spacing800,
    required this.spacing900,
    required this.spacingBase,

    required this.fontFamilyUi,

    required this.fontWeight300,
    required this.fontWeight400,
    required this.fontWeight500,
    required this.fontWeight600,

    required this.shadow0,
    required this.shadow100,
    required this.shadow200,
    required this.shadow300,

    required this.textDecorationNone,
    required this.textDecorationUnderline,
  });

  @override
  final Color backgroundAccentBrand;
  @override
  final Color backgroundAccentDanger;
  @override
  final Color backgroundAccentGradient;
  @override
  final Color backgroundAccentInfo;
  @override
  final Color backgroundAccentPrimary;
  @override
  final Color backgroundAccentSecondary;
  @override
  final Color backgroundAccentSuccess;
  @override
  final Color backgroundAccentWarning;
  @override
  final Color backgroundAlertBasicPrimary;
  @override
  final Color backgroundAlertBasicSecondary;
  @override
  final Color backgroundAlertDangerPrimary;
  @override
  final Color backgroundAlertDangerSecondary;
  @override
  final Color backgroundAlertInfoPrimary;
  @override
  final Color backgroundAlertInfoSecondary;
  @override
  final Color backgroundAlertSuccessPrimary;
  @override
  final Color backgroundAlertSuccessSecondary;
  @override
  final Color backgroundAlertWarningPrimary;
  @override
  final Color backgroundAlertWarningSecondary;
  @override
  final Color backgroundBackdrop;
  @override
  final Color backgroundBrand;
  @override
  final Color backgroundDatavizBluePrimary;
  @override
  final Color backgroundDatavizBlueSecondary;
  @override
  final Color backgroundDatavizDanger;
  @override
  final Color backgroundDatavizGreenPrimary;
  @override
  final Color backgroundDatavizGreenSecondary;
  @override
  final Color backgroundDatavizInfo;
  @override
  final Color backgroundDatavizOrangePrimary;
  @override
  final Color backgroundDatavizOrangeSecondary;
  @override
  final Color backgroundDatavizPinkPrimary;
  @override
  final Color backgroundDatavizPinkSecondary;
  @override
  final Color backgroundDatavizPurplePrimary;
  @override
  final Color backgroundDatavizPurpleSecondary;
  @override
  final Color backgroundDatavizRedPrimary;
  @override
  final Color backgroundDatavizRedSecondary;
  @override
  final Color backgroundDatavizSuccess;
  @override
  final Color backgroundDatavizWarning;
  @override
  final Color backgroundDisabled;
  @override
  final Color backgroundInteractiveDangerActive;
  @override
  final Color backgroundInteractiveDangerDefault;
  @override
  final Color backgroundInteractiveDangerHover;
  @override
  final Color backgroundInteractiveNeutralActive;
  @override
  final Color backgroundInteractiveNeutralBoldActive;
  @override
  final Color backgroundInteractiveNeutralBoldDefault;
  @override
  final Color backgroundInteractiveNeutralBoldHover;
  @override
  final Color backgroundInteractiveNeutralDefault;
  @override
  final Color backgroundInteractiveNeutralHover;
  @override
  final Color backgroundInteractiveNeutralSubtleActive;
  @override
  final Color backgroundInteractiveNeutralSubtleDefault;
  @override
  final Color backgroundInteractiveNeutralSubtleHover;
  @override
  final Color backgroundInteractivePrimaryActive;
  @override
  final Color backgroundInteractivePrimaryDefault;
  @override
  final Color backgroundInteractivePrimaryHover;
  @override
  final Color backgroundInteractiveSecondaryActive;
  @override
  final Color backgroundInteractiveSecondaryDefault;
  @override
  final Color backgroundInteractiveSecondaryHover;
  @override
  final Color backgroundInteractiveSuccessActive;
  @override
  final Color backgroundInteractiveSuccessDefault;
  @override
  final Color backgroundInteractiveSuccessHover;
  @override
  final Color backgroundStaticFlat;
  @override
  final Color backgroundStaticFloating;
  @override
  final Color backgroundStaticInverse;
  @override
  final Color backgroundStaticInverseOnColor;
  @override
  final Color backgroundStaticOnColor;
  @override
  final Color backgroundStaticRaised;
  @override
  final Color backgroundStaticSunken;
  @override
  final Color borderAccent;
  @override
  final Color borderAlertBasic;
  @override
  final Color borderAlertDanger;
  @override
  final Color borderAlertInfo;
  @override
  final Color borderAlertSuccess;
  @override
  final Color borderAlertWarning;
  @override
  final Color borderBrand;
  @override
  final Color borderDisabled;
  @override
  final Color borderInteractiveBoldActive;
  @override
  final Color borderInteractiveBoldDefault;
  @override
  final Color borderInteractiveBoldHover;
  @override
  final Color borderInteractiveFocus;
  @override
  final Color borderInteractiveInputActive;
  @override
  final Color borderInteractiveInputDefault;
  @override
  final Color borderInteractiveInputError;
  @override
  final Color borderInteractiveInputHover;
  @override
  final Color borderInteractivePrimaryActive;
  @override
  final Color borderInteractivePrimaryDefault;
  @override
  final Color borderInteractivePrimaryHover;
  @override
  final Color borderInteractiveSecondaryActive;
  @override
  final Color borderInteractiveSecondaryDefault;
  @override
  final Color borderInteractiveSecondaryHover;
  @override
  final Color borderStaticInverse;
  @override
  final Color borderStaticOnColor;
  @override
  final Color borderStaticPrimary;
  @override
  final Color borderStaticSecondary;
  @override
  final Color borderStaticTertiary;
  @override
  final Color legacyDatavizDenim100;
  @override
  final Color legacyDatavizDenim200;
  @override
  final Color legacyDatavizDenim300;
  @override
  final Color legacyDatavizDenim400;
  @override
  final Color legacyDatavizDenim50;
  @override
  final Color legacyDatavizDenim500;
  @override
  final Color legacyDatavizDenim600;
  @override
  final Color legacyDatavizDenim700;
  @override
  final Color legacyDatavizDenim800;
  @override
  final Color legacyDatavizDenim900;
  @override
  final Color legacyDatavizLavender100;
  @override
  final Color legacyDatavizLavender200;
  @override
  final Color legacyDatavizLavender300;
  @override
  final Color legacyDatavizLavender400;
  @override
  final Color legacyDatavizLavender50;
  @override
  final Color legacyDatavizLavender500;
  @override
  final Color legacyDatavizLavender600;
  @override
  final Color legacyDatavizLavender700;
  @override
  final Color legacyDatavizLavender800;
  @override
  final Color legacyDatavizLavender900;
  @override
  final Color legacyDatavizLime100;
  @override
  final Color legacyDatavizLime200;
  @override
  final Color legacyDatavizLime300;
  @override
  final Color legacyDatavizLime400;
  @override
  final Color legacyDatavizLime50;
  @override
  final Color legacyDatavizLime500;
  @override
  final Color legacyDatavizLime600;
  @override
  final Color legacyDatavizLime700;
  @override
  final Color legacyDatavizLime800;
  @override
  final Color legacyDatavizLime900;
  @override
  final Color legacyDatavizMustard100;
  @override
  final Color legacyDatavizMustard200;
  @override
  final Color legacyDatavizMustard300;
  @override
  final Color legacyDatavizMustard400;
  @override
  final Color legacyDatavizMustard50;
  @override
  final Color legacyDatavizMustard500;
  @override
  final Color legacyDatavizMustard600;
  @override
  final Color legacyDatavizMustard700;
  @override
  final Color legacyDatavizMustard800;
  @override
  final Color legacyDatavizMustard900;
  @override
  final Color legacyDatavizRuby100;
  @override
  final Color legacyDatavizRuby200;
  @override
  final Color legacyDatavizRuby300;
  @override
  final Color legacyDatavizRuby400;
  @override
  final Color legacyDatavizRuby50;
  @override
  final Color legacyDatavizRuby500;
  @override
  final Color legacyDatavizRuby600;
  @override
  final Color legacyDatavizRuby700;
  @override
  final Color legacyDatavizRuby800;
  @override
  final Color legacyDatavizRuby900;
  @override
  final Color legacyDatavizTangerine100;
  @override
  final Color legacyDatavizTangerine200;
  @override
  final Color legacyDatavizTangerine300;
  @override
  final Color legacyDatavizTangerine400;
  @override
  final Color legacyDatavizTangerine50;
  @override
  final Color legacyDatavizTangerine500;
  @override
  final Color legacyDatavizTangerine600;
  @override
  final Color legacyDatavizTangerine700;
  @override
  final Color legacyDatavizTangerine800;
  @override
  final Color legacyDatavizTangerine900;
  @override
  final Color legacyTagBackgroundBasicBold;
  @override
  final Color legacyTagBackgroundDenim;
  @override
  final Color legacyTagBackgroundLavender;
  @override
  final Color legacyTagBackgroundLime;
  @override
  final Color legacyTagBackgroundMustard;
  @override
  final Color legacyTagBackgroundPrimary;
  @override
  final Color legacyTagBackgroundRuby;
  @override
  final Color legacyTagBackgroundTangerine;
  @override
  final Color legacyTagBorderBasicBold;
  @override
  final Color legacyTagBorderDenim;
  @override
  final Color legacyTagBorderLavender;
  @override
  final Color legacyTagBorderLime;
  @override
  final Color legacyTagBorderMustard;
  @override
  final Color legacyTagBorderPrimary;
  @override
  final Color legacyTagBorderRuby;
  @override
  final Color legacyTagBorderTangerine;
  @override
  final Color legacyTagTextBasicBold;
  @override
  final Color legacyTagTextDenim;
  @override
  final Color legacyTagTextLavender;
  @override
  final Color legacyTagTextLime;
  @override
  final Color legacyTagTextMustard;
  @override
  final Color legacyTagTextPrimary;
  @override
  final Color legacyTagTextRuby;
  @override
  final Color legacyTagTextTangerine;
  @override
  final Color paletteBasicsBlack;
  @override
  final Color paletteBasicsWhite;
  @override
  final Color paletteBasicsWhite64;
  @override
  final Color paletteBrandCoral0;
  @override
  final Color paletteBrandCoral100;
  @override
  final Color paletteBrandCoral1000;
  @override
  final Color paletteBrandCoral150;
  @override
  final Color paletteBrandCoral200;
  @override
  final Color paletteBrandCoral25;
  @override
  final Color paletteBrandCoral300;
  @override
  final Color paletteBrandCoral400;
  @override
  final Color paletteBrandCoral50;
  @override
  final Color paletteBrandCoral500;
  @override
  final Color paletteBrandCoral600;
  @override
  final Color paletteBrandCoral700;
  @override
  final Color paletteBrandCoral800;
  @override
  final Color paletteBrandCoral900;
  @override
  final Color paletteBrandGrey0;
  @override
  final Color paletteBrandGrey100;
  @override
  final Color paletteBrandGrey1000;
  @override
  final Color paletteBrandGrey150;
  @override
  final Color paletteBrandGrey200;
  @override
  final Color paletteBrandGrey25;
  @override
  final Color paletteBrandGrey300;
  @override
  final Color paletteBrandGrey400;
  @override
  final Color paletteBrandGrey50;
  @override
  final Color paletteBrandGrey500;
  @override
  final Color paletteBrandGrey600;
  @override
  final Color paletteBrandGrey700;
  @override
  final Color paletteBrandGrey800;
  @override
  final Color paletteBrandGrey900;
  @override
  final Color paletteBrandIndigo0;
  @override
  final Color paletteBrandIndigo100;
  @override
  final Color paletteBrandIndigo1000;
  @override
  final Color paletteBrandIndigo150;
  @override
  final Color paletteBrandIndigo200;
  @override
  final Color paletteBrandIndigo25;
  @override
  final Color paletteBrandIndigo300;
  @override
  final Color paletteBrandIndigo400;
  @override
  final Color paletteBrandIndigo50;
  @override
  final Color paletteBrandIndigo500;
  @override
  final Color paletteBrandIndigo600;
  @override
  final Color paletteBrandIndigo700;
  @override
  final Color paletteBrandIndigo800;
  @override
  final Color paletteBrandIndigo900;
  @override
  final Color paletteBrandNight0;
  @override
  final Color paletteBrandNight064;
  @override
  final Color paletteBrandNight100;
  @override
  final Color paletteBrandNight1000;
  @override
  final Color paletteBrandNight100012;
  @override
  final Color paletteBrandNight100016;
  @override
  final Color paletteBrandNight10008;
  @override
  final Color paletteBrandNight150;
  @override
  final Color paletteBrandNight200;
  @override
  final Color paletteBrandNight25;
  @override
  final Color paletteBrandNight300;
  @override
  final Color paletteBrandNight400;
  @override
  final Color paletteBrandNight50;
  @override
  final Color paletteBrandNight500;
  @override
  final Color paletteBrandNight600;
  @override
  final Color paletteBrandNight700;
  @override
  final Color paletteBrandNight800;
  @override
  final Color paletteBrandNight900;
  @override
  final Color paletteDatavizBlue50;
  @override
  final Color paletteDatavizBlue500;
  @override
  final Color paletteDatavizGreen50;
  @override
  final Color paletteDatavizGreen500;
  @override
  final Color paletteDatavizOrange50;
  @override
  final Color paletteDatavizOrange500;
  @override
  final Color paletteDatavizPink50;
  @override
  final Color paletteDatavizPink500;
  @override
  final Color paletteDatavizPurple50;
  @override
  final Color paletteDatavizPurple500;
  @override
  final Color paletteDatavizRed50;
  @override
  final Color paletteDatavizRed500;
  @override
  final Color paletteSemanticBlue0;
  @override
  final Color paletteSemanticBlue100;
  @override
  final Color paletteSemanticBlue1000;
  @override
  final Color paletteSemanticBlue150;
  @override
  final Color paletteSemanticBlue200;
  @override
  final Color paletteSemanticBlue25;
  @override
  final Color paletteSemanticBlue300;
  @override
  final Color paletteSemanticBlue400;
  @override
  final Color paletteSemanticBlue50;
  @override
  final Color paletteSemanticBlue500;
  @override
  final Color paletteSemanticBlue600;
  @override
  final Color paletteSemanticBlue700;
  @override
  final Color paletteSemanticBlue800;
  @override
  final Color paletteSemanticBlue900;
  @override
  final Color paletteSemanticGreen0;
  @override
  final Color paletteSemanticGreen100;
  @override
  final Color paletteSemanticGreen1000;
  @override
  final Color paletteSemanticGreen150;
  @override
  final Color paletteSemanticGreen200;
  @override
  final Color paletteSemanticGreen25;
  @override
  final Color paletteSemanticGreen300;
  @override
  final Color paletteSemanticGreen400;
  @override
  final Color paletteSemanticGreen50;
  @override
  final Color paletteSemanticGreen500;
  @override
  final Color paletteSemanticGreen600;
  @override
  final Color paletteSemanticGreen700;
  @override
  final Color paletteSemanticGreen800;
  @override
  final Color paletteSemanticGreen900;
  @override
  final Color paletteSemanticOrange0;
  @override
  final Color paletteSemanticOrange100;
  @override
  final Color paletteSemanticOrange1000;
  @override
  final Color paletteSemanticOrange150;
  @override
  final Color paletteSemanticOrange200;
  @override
  final Color paletteSemanticOrange25;
  @override
  final Color paletteSemanticOrange300;
  @override
  final Color paletteSemanticOrange400;
  @override
  final Color paletteSemanticOrange50;
  @override
  final Color paletteSemanticOrange500;
  @override
  final Color paletteSemanticOrange600;
  @override
  final Color paletteSemanticOrange700;
  @override
  final Color paletteSemanticOrange800;
  @override
  final Color paletteSemanticOrange900;
  @override
  final Color paletteSemanticRed0;
  @override
  final Color paletteSemanticRed100;
  @override
  final Color paletteSemanticRed1000;
  @override
  final Color paletteSemanticRed150;
  @override
  final Color paletteSemanticRed200;
  @override
  final Color paletteSemanticRed25;
  @override
  final Color paletteSemanticRed300;
  @override
  final Color paletteSemanticRed400;
  @override
  final Color paletteSemanticRed50;
  @override
  final Color paletteSemanticRed500;
  @override
  final Color paletteSemanticRed600;
  @override
  final Color paletteSemanticRed700;
  @override
  final Color paletteSemanticRed800;
  @override
  final Color paletteSemanticRed900;
  @override
  final Color textAlertBasic;
  @override
  final Color textAlertDanger;
  @override
  final Color textAlertInfo;
  @override
  final Color textAlertSuccess;
  @override
  final Color textAlertWarning;
  @override
  final Color textDisabled;
  @override
  final Color textInteractivePrimaryActive;
  @override
  final Color textInteractivePrimaryDefault;
  @override
  final Color textInteractivePrimaryHover;
  @override
  final Color textInteractiveSecondaryActive;
  @override
  final Color textInteractiveSecondaryDefault;
  @override
  final Color textInteractiveSecondaryHover;
  @override
  final Color textStaticInverse;
  @override
  final Color textStaticOnColor;
  @override
  final Color textStaticPrimary;
  @override
  final Color textStaticSecondary;
  @override
  final Color textStaticTertiary;
  @override
  final Color visualAssetsAccent;
  @override
  final Color visualAssetsNeutralBold;
  @override
  final Color visualAssetsNeutralBold0;
  @override
  final Color visualAssetsNeutralSubtle;
  @override
  final Color visualAssetsNeutralSubtle0;
  @override
  final Color visualAssetsSemanticDanger;
  @override
  final Color visualAssetsSemanticInfo;
  @override
  final Color visualAssetsSemanticSuccess;
  @override
  final Color visualAssetsSemanticWarning;

  @override
  final TextStyle bodyExtraSmall;
  @override
  final TextStyle bodyExtraSmallStrong;
  @override
  final TextStyle bodyLarge;
  @override
  final TextStyle bodyLargeStrong;
  @override
  final TextStyle bodyMedium;
  @override
  final TextStyle bodyMediumStrong;
  @override
  final TextStyle bodySmall;
  @override
  final TextStyle bodySmallStrong;
  @override
  final TextStyle highlightLarge;
  @override
  final TextStyle highlightMedium;
  @override
  final TextStyle highlightSmall;
  @override
  final TextStyle titleLarge;
  @override
  final TextStyle titleLargeStrong;
  @override
  final TextStyle titleMedium;
  @override
  final TextStyle titleMediumStrong;
  @override
  final TextStyle titleSmall;
  @override
  final TextStyle titleSmallStrong;

  @override
  final Radius borderRadius0;
  @override
  final Radius borderRadius100;
  @override
  final Radius borderRadius150;
  @override
  final Radius borderRadius200;
  @override
  final Radius borderRadius25;
  @override
  final Radius borderRadius300;
  @override
  final Radius borderRadius50;
  @override
  final Radius borderRadiusBase;
  @override
  final Radius borderRadiusRound;

  @override
  final double borderWidth0;
  @override
  final double borderWidth100;
  @override
  final double borderWidth200;
  @override
  final double borderWidth300;
  @override
  final double borderWidth800;
  @override
  final double fontSize100;
  @override
  final double fontSize200;
  @override
  final double fontSize300;
  @override
  final double fontSize400;
  @override
  final double fontSize50;
  @override
  final double fontSize500;
  @override
  final double fontSize600;
  @override
  final double fontSize700;
  @override
  final double fontSize75;
  @override
  final double fontSize800;
  @override
  final double fontSize900;
  @override
  final double fontSizeBase;
  @override
  final double fontSizeRatio;
  @override
  final double letterSpacingCondensed;
  @override
  final double letterSpacingDefault;
  @override
  final double letterSpacingWide;
  @override
  final double lineHeight100;
  @override
  final double lineHeight200;
  @override
  final double lineHeight300;
  @override
  final double opacity0;
  @override
  final double opacity100;
  @override
  final double opacity1000;
  @override
  final double opacity150;
  @override
  final double opacity200;
  @override
  final double opacity400;
  @override
  final double opacity600;
  @override
  final double opacity800;
  @override
  final double sizing100;
  @override
  final double sizing1000;
  @override
  final double sizing1200;
  @override
  final double sizing1300;
  @override
  final double sizing200;
  @override
  final double sizing300;
  @override
  final double sizing400;
  @override
  final double sizing50;
  @override
  final double sizing500;
  @override
  final double sizing550;
  @override
  final double sizing600;
  @override
  final double sizing700;
  @override
  final double sizing75;
  @override
  final double sizing800;
  @override
  final double sizing900;
  @override
  final double sizingBase;
  @override
  final double spacing0;
  @override
  final double spacing100;
  @override
  final double spacing1000;
  @override
  final double spacing1200;
  @override
  final double spacing150;
  @override
  final double spacing200;
  @override
  final double spacing25;
  @override
  final double spacing250;
  @override
  final double spacing300;
  @override
  final double spacing400;
  @override
  final double spacing450;
  @override
  final double spacing50;
  @override
  final double spacing500;
  @override
  final double spacing600;
  @override
  final double spacing700;
  @override
  final double spacing800;
  @override
  final double spacing900;
  @override
  final double spacingBase;

  @override
  final String fontFamilyUi;

  @override
  final FontWeight fontWeight300;
  @override
  final FontWeight fontWeight400;
  @override
  final FontWeight fontWeight500;
  @override
  final FontWeight fontWeight600;

  @override
  final List<BoxShadow> shadow0;
  @override
  final List<BoxShadow> shadow100;
  @override
  final List<BoxShadow> shadow200;
  @override
  final List<BoxShadow> shadow300;

  @override
  final TextDecoration textDecorationNone;
  @override
  final TextDecoration textDecorationUnderline;

  static const OptimusTokens light = OptimusTokens(
    backgroundAccentBrand: DesignTokensLight.backgroundAccentBrand,
    backgroundAccentDanger: DesignTokensLight.backgroundAccentDanger,
    backgroundAccentGradient: DesignTokensLight.backgroundAccentGradient,
    backgroundAccentInfo: DesignTokensLight.backgroundAccentInfo,
    backgroundAccentPrimary: DesignTokensLight.backgroundAccentPrimary,
    backgroundAccentSecondary: DesignTokensLight.backgroundAccentSecondary,
    backgroundAccentSuccess: DesignTokensLight.backgroundAccentSuccess,
    backgroundAccentWarning: DesignTokensLight.backgroundAccentWarning,
    backgroundAlertBasicPrimary: DesignTokensLight.backgroundAlertBasicPrimary,
    backgroundAlertBasicSecondary:
        DesignTokensLight.backgroundAlertBasicSecondary,
    backgroundAlertDangerPrimary:
        DesignTokensLight.backgroundAlertDangerPrimary,
    backgroundAlertDangerSecondary:
        DesignTokensLight.backgroundAlertDangerSecondary,
    backgroundAlertInfoPrimary: DesignTokensLight.backgroundAlertInfoPrimary,
    backgroundAlertInfoSecondary:
        DesignTokensLight.backgroundAlertInfoSecondary,
    backgroundAlertSuccessPrimary:
        DesignTokensLight.backgroundAlertSuccessPrimary,
    backgroundAlertSuccessSecondary:
        DesignTokensLight.backgroundAlertSuccessSecondary,
    backgroundAlertWarningPrimary:
        DesignTokensLight.backgroundAlertWarningPrimary,
    backgroundAlertWarningSecondary:
        DesignTokensLight.backgroundAlertWarningSecondary,
    backgroundBackdrop: DesignTokensLight.backgroundBackdrop,
    backgroundBrand: DesignTokensLight.backgroundBrand,
    backgroundDatavizBluePrimary:
        DesignTokensLight.backgroundDatavizBluePrimary,
    backgroundDatavizBlueSecondary:
        DesignTokensLight.backgroundDatavizBlueSecondary,
    backgroundDatavizDanger: DesignTokensLight.backgroundDatavizDanger,
    backgroundDatavizGreenPrimary:
        DesignTokensLight.backgroundDatavizGreenPrimary,
    backgroundDatavizGreenSecondary:
        DesignTokensLight.backgroundDatavizGreenSecondary,
    backgroundDatavizInfo: DesignTokensLight.backgroundDatavizInfo,
    backgroundDatavizOrangePrimary:
        DesignTokensLight.backgroundDatavizOrangePrimary,
    backgroundDatavizOrangeSecondary:
        DesignTokensLight.backgroundDatavizOrangeSecondary,
    backgroundDatavizPinkPrimary:
        DesignTokensLight.backgroundDatavizPinkPrimary,
    backgroundDatavizPinkSecondary:
        DesignTokensLight.backgroundDatavizPinkSecondary,
    backgroundDatavizPurplePrimary:
        DesignTokensLight.backgroundDatavizPurplePrimary,
    backgroundDatavizPurpleSecondary:
        DesignTokensLight.backgroundDatavizPurpleSecondary,
    backgroundDatavizRedPrimary: DesignTokensLight.backgroundDatavizRedPrimary,
    backgroundDatavizRedSecondary:
        DesignTokensLight.backgroundDatavizRedSecondary,
    backgroundDatavizSuccess: DesignTokensLight.backgroundDatavizSuccess,
    backgroundDatavizWarning: DesignTokensLight.backgroundDatavizWarning,
    backgroundDisabled: DesignTokensLight.backgroundDisabled,
    backgroundInteractiveDangerActive:
        DesignTokensLight.backgroundInteractiveDangerActive,
    backgroundInteractiveDangerDefault:
        DesignTokensLight.backgroundInteractiveDangerDefault,
    backgroundInteractiveDangerHover:
        DesignTokensLight.backgroundInteractiveDangerHover,
    backgroundInteractiveNeutralActive:
        DesignTokensLight.backgroundInteractiveNeutralActive,
    backgroundInteractiveNeutralBoldActive:
        DesignTokensLight.backgroundInteractiveNeutralBoldActive,
    backgroundInteractiveNeutralBoldDefault:
        DesignTokensLight.backgroundInteractiveNeutralBoldDefault,
    backgroundInteractiveNeutralBoldHover:
        DesignTokensLight.backgroundInteractiveNeutralBoldHover,
    backgroundInteractiveNeutralDefault:
        DesignTokensLight.backgroundInteractiveNeutralDefault,
    backgroundInteractiveNeutralHover:
        DesignTokensLight.backgroundInteractiveNeutralHover,
    backgroundInteractiveNeutralSubtleActive:
        DesignTokensLight.backgroundInteractiveNeutralSubtleActive,
    backgroundInteractiveNeutralSubtleDefault:
        DesignTokensLight.backgroundInteractiveNeutralSubtleDefault,
    backgroundInteractiveNeutralSubtleHover:
        DesignTokensLight.backgroundInteractiveNeutralSubtleHover,
    backgroundInteractivePrimaryActive:
        DesignTokensLight.backgroundInteractivePrimaryActive,
    backgroundInteractivePrimaryDefault:
        DesignTokensLight.backgroundInteractivePrimaryDefault,
    backgroundInteractivePrimaryHover:
        DesignTokensLight.backgroundInteractivePrimaryHover,
    backgroundInteractiveSecondaryActive:
        DesignTokensLight.backgroundInteractiveSecondaryActive,
    backgroundInteractiveSecondaryDefault:
        DesignTokensLight.backgroundInteractiveSecondaryDefault,
    backgroundInteractiveSecondaryHover:
        DesignTokensLight.backgroundInteractiveSecondaryHover,
    backgroundInteractiveSuccessActive:
        DesignTokensLight.backgroundInteractiveSuccessActive,
    backgroundInteractiveSuccessDefault:
        DesignTokensLight.backgroundInteractiveSuccessDefault,
    backgroundInteractiveSuccessHover:
        DesignTokensLight.backgroundInteractiveSuccessHover,
    backgroundStaticFlat: DesignTokensLight.backgroundStaticFlat,
    backgroundStaticFloating: DesignTokensLight.backgroundStaticFloating,
    backgroundStaticInverse: DesignTokensLight.backgroundStaticInverse,
    backgroundStaticInverseOnColor:
        DesignTokensLight.backgroundStaticInverseOnColor,
    backgroundStaticOnColor: DesignTokensLight.backgroundStaticOnColor,
    backgroundStaticRaised: DesignTokensLight.backgroundStaticRaised,
    backgroundStaticSunken: DesignTokensLight.backgroundStaticSunken,
    borderAccent: DesignTokensLight.borderAccent,
    borderAlertBasic: DesignTokensLight.borderAlertBasic,
    borderAlertDanger: DesignTokensLight.borderAlertDanger,
    borderAlertInfo: DesignTokensLight.borderAlertInfo,
    borderAlertSuccess: DesignTokensLight.borderAlertSuccess,
    borderAlertWarning: DesignTokensLight.borderAlertWarning,
    borderBrand: DesignTokensLight.borderBrand,
    borderDisabled: DesignTokensLight.borderDisabled,
    borderInteractiveBoldActive: DesignTokensLight.borderInteractiveBoldActive,
    borderInteractiveBoldDefault:
        DesignTokensLight.borderInteractiveBoldDefault,
    borderInteractiveBoldHover: DesignTokensLight.borderInteractiveBoldHover,
    borderInteractiveFocus: DesignTokensLight.borderInteractiveFocus,
    borderInteractiveInputActive:
        DesignTokensLight.borderInteractiveInputActive,
    borderInteractiveInputDefault:
        DesignTokensLight.borderInteractiveInputDefault,
    borderInteractiveInputError: DesignTokensLight.borderInteractiveInputError,
    borderInteractiveInputHover: DesignTokensLight.borderInteractiveInputHover,
    borderInteractivePrimaryActive:
        DesignTokensLight.borderInteractivePrimaryActive,
    borderInteractivePrimaryDefault:
        DesignTokensLight.borderInteractivePrimaryDefault,
    borderInteractivePrimaryHover:
        DesignTokensLight.borderInteractivePrimaryHover,
    borderInteractiveSecondaryActive:
        DesignTokensLight.borderInteractiveSecondaryActive,
    borderInteractiveSecondaryDefault:
        DesignTokensLight.borderInteractiveSecondaryDefault,
    borderInteractiveSecondaryHover:
        DesignTokensLight.borderInteractiveSecondaryHover,
    borderStaticInverse: DesignTokensLight.borderStaticInverse,
    borderStaticOnColor: DesignTokensLight.borderStaticOnColor,
    borderStaticPrimary: DesignTokensLight.borderStaticPrimary,
    borderStaticSecondary: DesignTokensLight.borderStaticSecondary,
    borderStaticTertiary: DesignTokensLight.borderStaticTertiary,
    legacyDatavizDenim100: DesignTokensLight.legacyDatavizDenim100,
    legacyDatavizDenim200: DesignTokensLight.legacyDatavizDenim200,
    legacyDatavizDenim300: DesignTokensLight.legacyDatavizDenim300,
    legacyDatavizDenim400: DesignTokensLight.legacyDatavizDenim400,
    legacyDatavizDenim50: DesignTokensLight.legacyDatavizDenim50,
    legacyDatavizDenim500: DesignTokensLight.legacyDatavizDenim500,
    legacyDatavizDenim600: DesignTokensLight.legacyDatavizDenim600,
    legacyDatavizDenim700: DesignTokensLight.legacyDatavizDenim700,
    legacyDatavizDenim800: DesignTokensLight.legacyDatavizDenim800,
    legacyDatavizDenim900: DesignTokensLight.legacyDatavizDenim900,
    legacyDatavizLavender100: DesignTokensLight.legacyDatavizLavender100,
    legacyDatavizLavender200: DesignTokensLight.legacyDatavizLavender200,
    legacyDatavizLavender300: DesignTokensLight.legacyDatavizLavender300,
    legacyDatavizLavender400: DesignTokensLight.legacyDatavizLavender400,
    legacyDatavizLavender50: DesignTokensLight.legacyDatavizLavender50,
    legacyDatavizLavender500: DesignTokensLight.legacyDatavizLavender500,
    legacyDatavizLavender600: DesignTokensLight.legacyDatavizLavender600,
    legacyDatavizLavender700: DesignTokensLight.legacyDatavizLavender700,
    legacyDatavizLavender800: DesignTokensLight.legacyDatavizLavender800,
    legacyDatavizLavender900: DesignTokensLight.legacyDatavizLavender900,
    legacyDatavizLime100: DesignTokensLight.legacyDatavizLime100,
    legacyDatavizLime200: DesignTokensLight.legacyDatavizLime200,
    legacyDatavizLime300: DesignTokensLight.legacyDatavizLime300,
    legacyDatavizLime400: DesignTokensLight.legacyDatavizLime400,
    legacyDatavizLime50: DesignTokensLight.legacyDatavizLime50,
    legacyDatavizLime500: DesignTokensLight.legacyDatavizLime500,
    legacyDatavizLime600: DesignTokensLight.legacyDatavizLime600,
    legacyDatavizLime700: DesignTokensLight.legacyDatavizLime700,
    legacyDatavizLime800: DesignTokensLight.legacyDatavizLime800,
    legacyDatavizLime900: DesignTokensLight.legacyDatavizLime900,
    legacyDatavizMustard100: DesignTokensLight.legacyDatavizMustard100,
    legacyDatavizMustard200: DesignTokensLight.legacyDatavizMustard200,
    legacyDatavizMustard300: DesignTokensLight.legacyDatavizMustard300,
    legacyDatavizMustard400: DesignTokensLight.legacyDatavizMustard400,
    legacyDatavizMustard50: DesignTokensLight.legacyDatavizMustard50,
    legacyDatavizMustard500: DesignTokensLight.legacyDatavizMustard500,
    legacyDatavizMustard600: DesignTokensLight.legacyDatavizMustard600,
    legacyDatavizMustard700: DesignTokensLight.legacyDatavizMustard700,
    legacyDatavizMustard800: DesignTokensLight.legacyDatavizMustard800,
    legacyDatavizMustard900: DesignTokensLight.legacyDatavizMustard900,
    legacyDatavizRuby100: DesignTokensLight.legacyDatavizRuby100,
    legacyDatavizRuby200: DesignTokensLight.legacyDatavizRuby200,
    legacyDatavizRuby300: DesignTokensLight.legacyDatavizRuby300,
    legacyDatavizRuby400: DesignTokensLight.legacyDatavizRuby400,
    legacyDatavizRuby50: DesignTokensLight.legacyDatavizRuby50,
    legacyDatavizRuby500: DesignTokensLight.legacyDatavizRuby500,
    legacyDatavizRuby600: DesignTokensLight.legacyDatavizRuby600,
    legacyDatavizRuby700: DesignTokensLight.legacyDatavizRuby700,
    legacyDatavizRuby800: DesignTokensLight.legacyDatavizRuby800,
    legacyDatavizRuby900: DesignTokensLight.legacyDatavizRuby900,
    legacyDatavizTangerine100: DesignTokensLight.legacyDatavizTangerine100,
    legacyDatavizTangerine200: DesignTokensLight.legacyDatavizTangerine200,
    legacyDatavizTangerine300: DesignTokensLight.legacyDatavizTangerine300,
    legacyDatavizTangerine400: DesignTokensLight.legacyDatavizTangerine400,
    legacyDatavizTangerine50: DesignTokensLight.legacyDatavizTangerine50,
    legacyDatavizTangerine500: DesignTokensLight.legacyDatavizTangerine500,
    legacyDatavizTangerine600: DesignTokensLight.legacyDatavizTangerine600,
    legacyDatavizTangerine700: DesignTokensLight.legacyDatavizTangerine700,
    legacyDatavizTangerine800: DesignTokensLight.legacyDatavizTangerine800,
    legacyDatavizTangerine900: DesignTokensLight.legacyDatavizTangerine900,
    legacyTagBackgroundBasicBold:
        DesignTokensLight.legacyTagBackgroundBasicBold,
    legacyTagBackgroundDenim: DesignTokensLight.legacyTagBackgroundDenim,
    legacyTagBackgroundLavender: DesignTokensLight.legacyTagBackgroundLavender,
    legacyTagBackgroundLime: DesignTokensLight.legacyTagBackgroundLime,
    legacyTagBackgroundMustard: DesignTokensLight.legacyTagBackgroundMustard,
    legacyTagBackgroundPrimary: DesignTokensLight.legacyTagBackgroundPrimary,
    legacyTagBackgroundRuby: DesignTokensLight.legacyTagBackgroundRuby,
    legacyTagBackgroundTangerine:
        DesignTokensLight.legacyTagBackgroundTangerine,
    legacyTagBorderBasicBold: DesignTokensLight.legacyTagBorderBasicBold,
    legacyTagBorderDenim: DesignTokensLight.legacyTagBorderDenim,
    legacyTagBorderLavender: DesignTokensLight.legacyTagBorderLavender,
    legacyTagBorderLime: DesignTokensLight.legacyTagBorderLime,
    legacyTagBorderMustard: DesignTokensLight.legacyTagBorderMustard,
    legacyTagBorderPrimary: DesignTokensLight.legacyTagBorderPrimary,
    legacyTagBorderRuby: DesignTokensLight.legacyTagBorderRuby,
    legacyTagBorderTangerine: DesignTokensLight.legacyTagBorderTangerine,
    legacyTagTextBasicBold: DesignTokensLight.legacyTagTextBasicBold,
    legacyTagTextDenim: DesignTokensLight.legacyTagTextDenim,
    legacyTagTextLavender: DesignTokensLight.legacyTagTextLavender,
    legacyTagTextLime: DesignTokensLight.legacyTagTextLime,
    legacyTagTextMustard: DesignTokensLight.legacyTagTextMustard,
    legacyTagTextPrimary: DesignTokensLight.legacyTagTextPrimary,
    legacyTagTextRuby: DesignTokensLight.legacyTagTextRuby,
    legacyTagTextTangerine: DesignTokensLight.legacyTagTextTangerine,
    paletteBasicsBlack: DesignTokensLight.paletteBasicsBlack,
    paletteBasicsWhite: DesignTokensLight.paletteBasicsWhite,
    paletteBasicsWhite64: DesignTokensLight.paletteBasicsWhite64,
    paletteBrandCoral0: DesignTokensLight.paletteBrandCoral0,
    paletteBrandCoral100: DesignTokensLight.paletteBrandCoral100,
    paletteBrandCoral1000: DesignTokensLight.paletteBrandCoral1000,
    paletteBrandCoral150: DesignTokensLight.paletteBrandCoral150,
    paletteBrandCoral200: DesignTokensLight.paletteBrandCoral200,
    paletteBrandCoral25: DesignTokensLight.paletteBrandCoral25,
    paletteBrandCoral300: DesignTokensLight.paletteBrandCoral300,
    paletteBrandCoral400: DesignTokensLight.paletteBrandCoral400,
    paletteBrandCoral50: DesignTokensLight.paletteBrandCoral50,
    paletteBrandCoral500: DesignTokensLight.paletteBrandCoral500,
    paletteBrandCoral600: DesignTokensLight.paletteBrandCoral600,
    paletteBrandCoral700: DesignTokensLight.paletteBrandCoral700,
    paletteBrandCoral800: DesignTokensLight.paletteBrandCoral800,
    paletteBrandCoral900: DesignTokensLight.paletteBrandCoral900,
    paletteBrandGrey0: DesignTokensLight.paletteBrandGrey0,
    paletteBrandGrey100: DesignTokensLight.paletteBrandGrey100,
    paletteBrandGrey1000: DesignTokensLight.paletteBrandGrey1000,
    paletteBrandGrey150: DesignTokensLight.paletteBrandGrey150,
    paletteBrandGrey200: DesignTokensLight.paletteBrandGrey200,
    paletteBrandGrey25: DesignTokensLight.paletteBrandGrey25,
    paletteBrandGrey300: DesignTokensLight.paletteBrandGrey300,
    paletteBrandGrey400: DesignTokensLight.paletteBrandGrey400,
    paletteBrandGrey50: DesignTokensLight.paletteBrandGrey50,
    paletteBrandGrey500: DesignTokensLight.paletteBrandGrey500,
    paletteBrandGrey600: DesignTokensLight.paletteBrandGrey600,
    paletteBrandGrey700: DesignTokensLight.paletteBrandGrey700,
    paletteBrandGrey800: DesignTokensLight.paletteBrandGrey800,
    paletteBrandGrey900: DesignTokensLight.paletteBrandGrey900,
    paletteBrandIndigo0: DesignTokensLight.paletteBrandIndigo0,
    paletteBrandIndigo100: DesignTokensLight.paletteBrandIndigo100,
    paletteBrandIndigo1000: DesignTokensLight.paletteBrandIndigo1000,
    paletteBrandIndigo150: DesignTokensLight.paletteBrandIndigo150,
    paletteBrandIndigo200: DesignTokensLight.paletteBrandIndigo200,
    paletteBrandIndigo25: DesignTokensLight.paletteBrandIndigo25,
    paletteBrandIndigo300: DesignTokensLight.paletteBrandIndigo300,
    paletteBrandIndigo400: DesignTokensLight.paletteBrandIndigo400,
    paletteBrandIndigo50: DesignTokensLight.paletteBrandIndigo50,
    paletteBrandIndigo500: DesignTokensLight.paletteBrandIndigo500,
    paletteBrandIndigo600: DesignTokensLight.paletteBrandIndigo600,
    paletteBrandIndigo700: DesignTokensLight.paletteBrandIndigo700,
    paletteBrandIndigo800: DesignTokensLight.paletteBrandIndigo800,
    paletteBrandIndigo900: DesignTokensLight.paletteBrandIndigo900,
    paletteBrandNight0: DesignTokensLight.paletteBrandNight0,
    paletteBrandNight064: DesignTokensLight.paletteBrandNight064,
    paletteBrandNight100: DesignTokensLight.paletteBrandNight100,
    paletteBrandNight1000: DesignTokensLight.paletteBrandNight1000,
    paletteBrandNight100012: DesignTokensLight.paletteBrandNight100012,
    paletteBrandNight100016: DesignTokensLight.paletteBrandNight100016,
    paletteBrandNight10008: DesignTokensLight.paletteBrandNight10008,
    paletteBrandNight150: DesignTokensLight.paletteBrandNight150,
    paletteBrandNight200: DesignTokensLight.paletteBrandNight200,
    paletteBrandNight25: DesignTokensLight.paletteBrandNight25,
    paletteBrandNight300: DesignTokensLight.paletteBrandNight300,
    paletteBrandNight400: DesignTokensLight.paletteBrandNight400,
    paletteBrandNight50: DesignTokensLight.paletteBrandNight50,
    paletteBrandNight500: DesignTokensLight.paletteBrandNight500,
    paletteBrandNight600: DesignTokensLight.paletteBrandNight600,
    paletteBrandNight700: DesignTokensLight.paletteBrandNight700,
    paletteBrandNight800: DesignTokensLight.paletteBrandNight800,
    paletteBrandNight900: DesignTokensLight.paletteBrandNight900,
    paletteDatavizBlue50: DesignTokensLight.paletteDatavizBlue50,
    paletteDatavizBlue500: DesignTokensLight.paletteDatavizBlue500,
    paletteDatavizGreen50: DesignTokensLight.paletteDatavizGreen50,
    paletteDatavizGreen500: DesignTokensLight.paletteDatavizGreen500,
    paletteDatavizOrange50: DesignTokensLight.paletteDatavizOrange50,
    paletteDatavizOrange500: DesignTokensLight.paletteDatavizOrange500,
    paletteDatavizPink50: DesignTokensLight.paletteDatavizPink50,
    paletteDatavizPink500: DesignTokensLight.paletteDatavizPink500,
    paletteDatavizPurple50: DesignTokensLight.paletteDatavizPurple50,
    paletteDatavizPurple500: DesignTokensLight.paletteDatavizPurple500,
    paletteDatavizRed50: DesignTokensLight.paletteDatavizRed50,
    paletteDatavizRed500: DesignTokensLight.paletteDatavizRed500,
    paletteSemanticBlue0: DesignTokensLight.paletteSemanticBlue0,
    paletteSemanticBlue100: DesignTokensLight.paletteSemanticBlue100,
    paletteSemanticBlue1000: DesignTokensLight.paletteSemanticBlue1000,
    paletteSemanticBlue150: DesignTokensLight.paletteSemanticBlue150,
    paletteSemanticBlue200: DesignTokensLight.paletteSemanticBlue200,
    paletteSemanticBlue25: DesignTokensLight.paletteSemanticBlue25,
    paletteSemanticBlue300: DesignTokensLight.paletteSemanticBlue300,
    paletteSemanticBlue400: DesignTokensLight.paletteSemanticBlue400,
    paletteSemanticBlue50: DesignTokensLight.paletteSemanticBlue50,
    paletteSemanticBlue500: DesignTokensLight.paletteSemanticBlue500,
    paletteSemanticBlue600: DesignTokensLight.paletteSemanticBlue600,
    paletteSemanticBlue700: DesignTokensLight.paletteSemanticBlue700,
    paletteSemanticBlue800: DesignTokensLight.paletteSemanticBlue800,
    paletteSemanticBlue900: DesignTokensLight.paletteSemanticBlue900,
    paletteSemanticGreen0: DesignTokensLight.paletteSemanticGreen0,
    paletteSemanticGreen100: DesignTokensLight.paletteSemanticGreen100,
    paletteSemanticGreen1000: DesignTokensLight.paletteSemanticGreen1000,
    paletteSemanticGreen150: DesignTokensLight.paletteSemanticGreen150,
    paletteSemanticGreen200: DesignTokensLight.paletteSemanticGreen200,
    paletteSemanticGreen25: DesignTokensLight.paletteSemanticGreen25,
    paletteSemanticGreen300: DesignTokensLight.paletteSemanticGreen300,
    paletteSemanticGreen400: DesignTokensLight.paletteSemanticGreen400,
    paletteSemanticGreen50: DesignTokensLight.paletteSemanticGreen50,
    paletteSemanticGreen500: DesignTokensLight.paletteSemanticGreen500,
    paletteSemanticGreen600: DesignTokensLight.paletteSemanticGreen600,
    paletteSemanticGreen700: DesignTokensLight.paletteSemanticGreen700,
    paletteSemanticGreen800: DesignTokensLight.paletteSemanticGreen800,
    paletteSemanticGreen900: DesignTokensLight.paletteSemanticGreen900,
    paletteSemanticOrange0: DesignTokensLight.paletteSemanticOrange0,
    paletteSemanticOrange100: DesignTokensLight.paletteSemanticOrange100,
    paletteSemanticOrange1000: DesignTokensLight.paletteSemanticOrange1000,
    paletteSemanticOrange150: DesignTokensLight.paletteSemanticOrange150,
    paletteSemanticOrange200: DesignTokensLight.paletteSemanticOrange200,
    paletteSemanticOrange25: DesignTokensLight.paletteSemanticOrange25,
    paletteSemanticOrange300: DesignTokensLight.paletteSemanticOrange300,
    paletteSemanticOrange400: DesignTokensLight.paletteSemanticOrange400,
    paletteSemanticOrange50: DesignTokensLight.paletteSemanticOrange50,
    paletteSemanticOrange500: DesignTokensLight.paletteSemanticOrange500,
    paletteSemanticOrange600: DesignTokensLight.paletteSemanticOrange600,
    paletteSemanticOrange700: DesignTokensLight.paletteSemanticOrange700,
    paletteSemanticOrange800: DesignTokensLight.paletteSemanticOrange800,
    paletteSemanticOrange900: DesignTokensLight.paletteSemanticOrange900,
    paletteSemanticRed0: DesignTokensLight.paletteSemanticRed0,
    paletteSemanticRed100: DesignTokensLight.paletteSemanticRed100,
    paletteSemanticRed1000: DesignTokensLight.paletteSemanticRed1000,
    paletteSemanticRed150: DesignTokensLight.paletteSemanticRed150,
    paletteSemanticRed200: DesignTokensLight.paletteSemanticRed200,
    paletteSemanticRed25: DesignTokensLight.paletteSemanticRed25,
    paletteSemanticRed300: DesignTokensLight.paletteSemanticRed300,
    paletteSemanticRed400: DesignTokensLight.paletteSemanticRed400,
    paletteSemanticRed50: DesignTokensLight.paletteSemanticRed50,
    paletteSemanticRed500: DesignTokensLight.paletteSemanticRed500,
    paletteSemanticRed600: DesignTokensLight.paletteSemanticRed600,
    paletteSemanticRed700: DesignTokensLight.paletteSemanticRed700,
    paletteSemanticRed800: DesignTokensLight.paletteSemanticRed800,
    paletteSemanticRed900: DesignTokensLight.paletteSemanticRed900,
    textAlertBasic: DesignTokensLight.textAlertBasic,
    textAlertDanger: DesignTokensLight.textAlertDanger,
    textAlertInfo: DesignTokensLight.textAlertInfo,
    textAlertSuccess: DesignTokensLight.textAlertSuccess,
    textAlertWarning: DesignTokensLight.textAlertWarning,
    textDisabled: DesignTokensLight.textDisabled,
    textInteractivePrimaryActive:
        DesignTokensLight.textInteractivePrimaryActive,
    textInteractivePrimaryDefault:
        DesignTokensLight.textInteractivePrimaryDefault,
    textInteractivePrimaryHover: DesignTokensLight.textInteractivePrimaryHover,
    textInteractiveSecondaryActive:
        DesignTokensLight.textInteractiveSecondaryActive,
    textInteractiveSecondaryDefault:
        DesignTokensLight.textInteractiveSecondaryDefault,
    textInteractiveSecondaryHover:
        DesignTokensLight.textInteractiveSecondaryHover,
    textStaticInverse: DesignTokensLight.textStaticInverse,
    textStaticOnColor: DesignTokensLight.textStaticOnColor,
    textStaticPrimary: DesignTokensLight.textStaticPrimary,
    textStaticSecondary: DesignTokensLight.textStaticSecondary,
    textStaticTertiary: DesignTokensLight.textStaticTertiary,
    visualAssetsAccent: DesignTokensLight.visualAssetsAccent,
    visualAssetsNeutralBold: DesignTokensLight.visualAssetsNeutralBold,
    visualAssetsNeutralBold0: DesignTokensLight.visualAssetsNeutralBold0,
    visualAssetsNeutralSubtle: DesignTokensLight.visualAssetsNeutralSubtle,
    visualAssetsNeutralSubtle0: DesignTokensLight.visualAssetsNeutralSubtle0,
    visualAssetsSemanticDanger: DesignTokensLight.visualAssetsSemanticDanger,
    visualAssetsSemanticInfo: DesignTokensLight.visualAssetsSemanticInfo,
    visualAssetsSemanticSuccess: DesignTokensLight.visualAssetsSemanticSuccess,
    visualAssetsSemanticWarning: DesignTokensLight.visualAssetsSemanticWarning,

    bodyExtraSmall: DesignTokensLight.bodyExtraSmall,
    bodyExtraSmallStrong: DesignTokensLight.bodyExtraSmallStrong,
    bodyLarge: DesignTokensLight.bodyLarge,
    bodyLargeStrong: DesignTokensLight.bodyLargeStrong,
    bodyMedium: DesignTokensLight.bodyMedium,
    bodyMediumStrong: DesignTokensLight.bodyMediumStrong,
    bodySmall: DesignTokensLight.bodySmall,
    bodySmallStrong: DesignTokensLight.bodySmallStrong,
    highlightLarge: DesignTokensLight.highlightLarge,
    highlightMedium: DesignTokensLight.highlightMedium,
    highlightSmall: DesignTokensLight.highlightSmall,
    titleLarge: DesignTokensLight.titleLarge,
    titleLargeStrong: DesignTokensLight.titleLargeStrong,
    titleMedium: DesignTokensLight.titleMedium,
    titleMediumStrong: DesignTokensLight.titleMediumStrong,
    titleSmall: DesignTokensLight.titleSmall,
    titleSmallStrong: DesignTokensLight.titleSmallStrong,

    borderRadius0: DesignTokensLight.borderRadius0,
    borderRadius100: DesignTokensLight.borderRadius100,
    borderRadius150: DesignTokensLight.borderRadius150,
    borderRadius200: DesignTokensLight.borderRadius200,
    borderRadius25: DesignTokensLight.borderRadius25,
    borderRadius300: DesignTokensLight.borderRadius300,
    borderRadius50: DesignTokensLight.borderRadius50,
    borderRadiusBase: DesignTokensLight.borderRadiusBase,
    borderRadiusRound: DesignTokensLight.borderRadiusRound,

    borderWidth0: DesignTokensLight.borderWidth0,
    borderWidth100: DesignTokensLight.borderWidth100,
    borderWidth200: DesignTokensLight.borderWidth200,
    borderWidth300: DesignTokensLight.borderWidth300,
    borderWidth800: DesignTokensLight.borderWidth800,
    fontSize100: DesignTokensLight.fontSize100,
    fontSize200: DesignTokensLight.fontSize200,
    fontSize300: DesignTokensLight.fontSize300,
    fontSize400: DesignTokensLight.fontSize400,
    fontSize50: DesignTokensLight.fontSize50,
    fontSize500: DesignTokensLight.fontSize500,
    fontSize600: DesignTokensLight.fontSize600,
    fontSize700: DesignTokensLight.fontSize700,
    fontSize75: DesignTokensLight.fontSize75,
    fontSize800: DesignTokensLight.fontSize800,
    fontSize900: DesignTokensLight.fontSize900,
    fontSizeBase: DesignTokensLight.fontSizeBase,
    fontSizeRatio: DesignTokensLight.fontSizeRatio,
    letterSpacingCondensed: DesignTokensLight.letterSpacingCondensed,
    letterSpacingDefault: DesignTokensLight.letterSpacingDefault,
    letterSpacingWide: DesignTokensLight.letterSpacingWide,
    lineHeight100: DesignTokensLight.lineHeight100,
    lineHeight200: DesignTokensLight.lineHeight200,
    lineHeight300: DesignTokensLight.lineHeight300,
    opacity0: DesignTokensLight.opacity0,
    opacity100: DesignTokensLight.opacity100,
    opacity1000: DesignTokensLight.opacity1000,
    opacity150: DesignTokensLight.opacity150,
    opacity200: DesignTokensLight.opacity200,
    opacity400: DesignTokensLight.opacity400,
    opacity600: DesignTokensLight.opacity600,
    opacity800: DesignTokensLight.opacity800,
    sizing100: DesignTokensLight.sizing100,
    sizing1000: DesignTokensLight.sizing1000,
    sizing1200: DesignTokensLight.sizing1200,
    sizing1300: DesignTokensLight.sizing1300,
    sizing200: DesignTokensLight.sizing200,
    sizing300: DesignTokensLight.sizing300,
    sizing400: DesignTokensLight.sizing400,
    sizing50: DesignTokensLight.sizing50,
    sizing500: DesignTokensLight.sizing500,
    sizing550: DesignTokensLight.sizing550,
    sizing600: DesignTokensLight.sizing600,
    sizing700: DesignTokensLight.sizing700,
    sizing75: DesignTokensLight.sizing75,
    sizing800: DesignTokensLight.sizing800,
    sizing900: DesignTokensLight.sizing900,
    sizingBase: DesignTokensLight.sizingBase,
    spacing0: DesignTokensLight.spacing0,
    spacing100: DesignTokensLight.spacing100,
    spacing1000: DesignTokensLight.spacing1000,
    spacing1200: DesignTokensLight.spacing1200,
    spacing150: DesignTokensLight.spacing150,
    spacing200: DesignTokensLight.spacing200,
    spacing25: DesignTokensLight.spacing25,
    spacing250: DesignTokensLight.spacing250,
    spacing300: DesignTokensLight.spacing300,
    spacing400: DesignTokensLight.spacing400,
    spacing450: DesignTokensLight.spacing450,
    spacing50: DesignTokensLight.spacing50,
    spacing500: DesignTokensLight.spacing500,
    spacing600: DesignTokensLight.spacing600,
    spacing700: DesignTokensLight.spacing700,
    spacing800: DesignTokensLight.spacing800,
    spacing900: DesignTokensLight.spacing900,
    spacingBase: DesignTokensLight.spacingBase,

    fontFamilyUi: DesignTokensLight.fontFamilyUi,

    fontWeight300: DesignTokensLight.fontWeight300,
    fontWeight400: DesignTokensLight.fontWeight400,
    fontWeight500: DesignTokensLight.fontWeight500,
    fontWeight600: DesignTokensLight.fontWeight600,

    shadow0: DesignTokensLight.shadow0,
    shadow100: DesignTokensLight.shadow100,
    shadow200: DesignTokensLight.shadow200,
    shadow300: DesignTokensLight.shadow300,

    textDecorationNone: DesignTokensLight.textDecorationNone,
    textDecorationUnderline: DesignTokensLight.textDecorationUnderline,
  );

  static const OptimusTokens dark = OptimusTokens(
    backgroundAccentBrand: DesignTokensDark.backgroundAccentBrand,
    backgroundAccentDanger: DesignTokensDark.backgroundAccentDanger,
    backgroundAccentGradient: DesignTokensDark.backgroundAccentGradient,
    backgroundAccentInfo: DesignTokensDark.backgroundAccentInfo,
    backgroundAccentPrimary: DesignTokensDark.backgroundAccentPrimary,
    backgroundAccentSecondary: DesignTokensDark.backgroundAccentSecondary,
    backgroundAccentSuccess: DesignTokensDark.backgroundAccentSuccess,
    backgroundAccentWarning: DesignTokensDark.backgroundAccentWarning,
    backgroundAlertBasicPrimary: DesignTokensDark.backgroundAlertBasicPrimary,
    backgroundAlertBasicSecondary:
        DesignTokensDark.backgroundAlertBasicSecondary,
    backgroundAlertDangerPrimary: DesignTokensDark.backgroundAlertDangerPrimary,
    backgroundAlertDangerSecondary:
        DesignTokensDark.backgroundAlertDangerSecondary,
    backgroundAlertInfoPrimary: DesignTokensDark.backgroundAlertInfoPrimary,
    backgroundAlertInfoSecondary: DesignTokensDark.backgroundAlertInfoSecondary,
    backgroundAlertSuccessPrimary:
        DesignTokensDark.backgroundAlertSuccessPrimary,
    backgroundAlertSuccessSecondary:
        DesignTokensDark.backgroundAlertSuccessSecondary,
    backgroundAlertWarningPrimary:
        DesignTokensDark.backgroundAlertWarningPrimary,
    backgroundAlertWarningSecondary:
        DesignTokensDark.backgroundAlertWarningSecondary,
    backgroundBackdrop: DesignTokensDark.backgroundBackdrop,
    backgroundBrand: DesignTokensDark.backgroundBrand,
    backgroundDatavizBluePrimary: DesignTokensDark.backgroundDatavizBluePrimary,
    backgroundDatavizBlueSecondary:
        DesignTokensDark.backgroundDatavizBlueSecondary,
    backgroundDatavizDanger: DesignTokensDark.backgroundDatavizDanger,
    backgroundDatavizGreenPrimary:
        DesignTokensDark.backgroundDatavizGreenPrimary,
    backgroundDatavizGreenSecondary:
        DesignTokensDark.backgroundDatavizGreenSecondary,
    backgroundDatavizInfo: DesignTokensDark.backgroundDatavizInfo,
    backgroundDatavizOrangePrimary:
        DesignTokensDark.backgroundDatavizOrangePrimary,
    backgroundDatavizOrangeSecondary:
        DesignTokensDark.backgroundDatavizOrangeSecondary,
    backgroundDatavizPinkPrimary: DesignTokensDark.backgroundDatavizPinkPrimary,
    backgroundDatavizPinkSecondary:
        DesignTokensDark.backgroundDatavizPinkSecondary,
    backgroundDatavizPurplePrimary:
        DesignTokensDark.backgroundDatavizPurplePrimary,
    backgroundDatavizPurpleSecondary:
        DesignTokensDark.backgroundDatavizPurpleSecondary,
    backgroundDatavizRedPrimary: DesignTokensDark.backgroundDatavizRedPrimary,
    backgroundDatavizRedSecondary:
        DesignTokensDark.backgroundDatavizRedSecondary,
    backgroundDatavizSuccess: DesignTokensDark.backgroundDatavizSuccess,
    backgroundDatavizWarning: DesignTokensDark.backgroundDatavizWarning,
    backgroundDisabled: DesignTokensDark.backgroundDisabled,
    backgroundInteractiveDangerActive:
        DesignTokensDark.backgroundInteractiveDangerActive,
    backgroundInteractiveDangerDefault:
        DesignTokensDark.backgroundInteractiveDangerDefault,
    backgroundInteractiveDangerHover:
        DesignTokensDark.backgroundInteractiveDangerHover,
    backgroundInteractiveNeutralActive:
        DesignTokensDark.backgroundInteractiveNeutralActive,
    backgroundInteractiveNeutralBoldActive:
        DesignTokensDark.backgroundInteractiveNeutralBoldActive,
    backgroundInteractiveNeutralBoldDefault:
        DesignTokensDark.backgroundInteractiveNeutralBoldDefault,
    backgroundInteractiveNeutralBoldHover:
        DesignTokensDark.backgroundInteractiveNeutralBoldHover,
    backgroundInteractiveNeutralDefault:
        DesignTokensDark.backgroundInteractiveNeutralDefault,
    backgroundInteractiveNeutralHover:
        DesignTokensDark.backgroundInteractiveNeutralHover,
    backgroundInteractiveNeutralSubtleActive:
        DesignTokensDark.backgroundInteractiveNeutralSubtleActive,
    backgroundInteractiveNeutralSubtleDefault:
        DesignTokensDark.backgroundInteractiveNeutralSubtleDefault,
    backgroundInteractiveNeutralSubtleHover:
        DesignTokensDark.backgroundInteractiveNeutralSubtleHover,
    backgroundInteractivePrimaryActive:
        DesignTokensDark.backgroundInteractivePrimaryActive,
    backgroundInteractivePrimaryDefault:
        DesignTokensDark.backgroundInteractivePrimaryDefault,
    backgroundInteractivePrimaryHover:
        DesignTokensDark.backgroundInteractivePrimaryHover,
    backgroundInteractiveSecondaryActive:
        DesignTokensDark.backgroundInteractiveSecondaryActive,
    backgroundInteractiveSecondaryDefault:
        DesignTokensDark.backgroundInteractiveSecondaryDefault,
    backgroundInteractiveSecondaryHover:
        DesignTokensDark.backgroundInteractiveSecondaryHover,
    backgroundInteractiveSuccessActive:
        DesignTokensDark.backgroundInteractiveSuccessActive,
    backgroundInteractiveSuccessDefault:
        DesignTokensDark.backgroundInteractiveSuccessDefault,
    backgroundInteractiveSuccessHover:
        DesignTokensDark.backgroundInteractiveSuccessHover,
    backgroundStaticFlat: DesignTokensDark.backgroundStaticFlat,
    backgroundStaticFloating: DesignTokensDark.backgroundStaticFloating,
    backgroundStaticInverse: DesignTokensDark.backgroundStaticInverse,
    backgroundStaticInverseOnColor:
        DesignTokensDark.backgroundStaticInverseOnColor,
    backgroundStaticOnColor: DesignTokensDark.backgroundStaticOnColor,
    backgroundStaticRaised: DesignTokensDark.backgroundStaticRaised,
    backgroundStaticSunken: DesignTokensDark.backgroundStaticSunken,
    borderAccent: DesignTokensDark.borderAccent,
    borderAlertBasic: DesignTokensDark.borderAlertBasic,
    borderAlertDanger: DesignTokensDark.borderAlertDanger,
    borderAlertInfo: DesignTokensDark.borderAlertInfo,
    borderAlertSuccess: DesignTokensDark.borderAlertSuccess,
    borderAlertWarning: DesignTokensDark.borderAlertWarning,
    borderBrand: DesignTokensDark.borderBrand,
    borderDisabled: DesignTokensDark.borderDisabled,
    borderInteractiveBoldActive: DesignTokensDark.borderInteractiveBoldActive,
    borderInteractiveBoldDefault: DesignTokensDark.borderInteractiveBoldDefault,
    borderInteractiveBoldHover: DesignTokensDark.borderInteractiveBoldHover,
    borderInteractiveFocus: DesignTokensDark.borderInteractiveFocus,
    borderInteractiveInputActive: DesignTokensDark.borderInteractiveInputActive,
    borderInteractiveInputDefault:
        DesignTokensDark.borderInteractiveInputDefault,
    borderInteractiveInputError: DesignTokensDark.borderInteractiveInputError,
    borderInteractiveInputHover: DesignTokensDark.borderInteractiveInputHover,
    borderInteractivePrimaryActive:
        DesignTokensDark.borderInteractivePrimaryActive,
    borderInteractivePrimaryDefault:
        DesignTokensDark.borderInteractivePrimaryDefault,
    borderInteractivePrimaryHover:
        DesignTokensDark.borderInteractivePrimaryHover,
    borderInteractiveSecondaryActive:
        DesignTokensDark.borderInteractiveSecondaryActive,
    borderInteractiveSecondaryDefault:
        DesignTokensDark.borderInteractiveSecondaryDefault,
    borderInteractiveSecondaryHover:
        DesignTokensDark.borderInteractiveSecondaryHover,
    borderStaticInverse: DesignTokensDark.borderStaticInverse,
    borderStaticOnColor: DesignTokensDark.borderStaticOnColor,
    borderStaticPrimary: DesignTokensDark.borderStaticPrimary,
    borderStaticSecondary: DesignTokensDark.borderStaticSecondary,
    borderStaticTertiary: DesignTokensDark.borderStaticTertiary,
    legacyDatavizDenim100: DesignTokensDark.legacyDatavizDenim100,
    legacyDatavizDenim200: DesignTokensDark.legacyDatavizDenim200,
    legacyDatavizDenim300: DesignTokensDark.legacyDatavizDenim300,
    legacyDatavizDenim400: DesignTokensDark.legacyDatavizDenim400,
    legacyDatavizDenim50: DesignTokensDark.legacyDatavizDenim50,
    legacyDatavizDenim500: DesignTokensDark.legacyDatavizDenim500,
    legacyDatavizDenim600: DesignTokensDark.legacyDatavizDenim600,
    legacyDatavizDenim700: DesignTokensDark.legacyDatavizDenim700,
    legacyDatavizDenim800: DesignTokensDark.legacyDatavizDenim800,
    legacyDatavizDenim900: DesignTokensDark.legacyDatavizDenim900,
    legacyDatavizLavender100: DesignTokensDark.legacyDatavizLavender100,
    legacyDatavizLavender200: DesignTokensDark.legacyDatavizLavender200,
    legacyDatavizLavender300: DesignTokensDark.legacyDatavizLavender300,
    legacyDatavizLavender400: DesignTokensDark.legacyDatavizLavender400,
    legacyDatavizLavender50: DesignTokensDark.legacyDatavizLavender50,
    legacyDatavizLavender500: DesignTokensDark.legacyDatavizLavender500,
    legacyDatavizLavender600: DesignTokensDark.legacyDatavizLavender600,
    legacyDatavizLavender700: DesignTokensDark.legacyDatavizLavender700,
    legacyDatavizLavender800: DesignTokensDark.legacyDatavizLavender800,
    legacyDatavizLavender900: DesignTokensDark.legacyDatavizLavender900,
    legacyDatavizLime100: DesignTokensDark.legacyDatavizLime100,
    legacyDatavizLime200: DesignTokensDark.legacyDatavizLime200,
    legacyDatavizLime300: DesignTokensDark.legacyDatavizLime300,
    legacyDatavizLime400: DesignTokensDark.legacyDatavizLime400,
    legacyDatavizLime50: DesignTokensDark.legacyDatavizLime50,
    legacyDatavizLime500: DesignTokensDark.legacyDatavizLime500,
    legacyDatavizLime600: DesignTokensDark.legacyDatavizLime600,
    legacyDatavizLime700: DesignTokensDark.legacyDatavizLime700,
    legacyDatavizLime800: DesignTokensDark.legacyDatavizLime800,
    legacyDatavizLime900: DesignTokensDark.legacyDatavizLime900,
    legacyDatavizMustard100: DesignTokensDark.legacyDatavizMustard100,
    legacyDatavizMustard200: DesignTokensDark.legacyDatavizMustard200,
    legacyDatavizMustard300: DesignTokensDark.legacyDatavizMustard300,
    legacyDatavizMustard400: DesignTokensDark.legacyDatavizMustard400,
    legacyDatavizMustard50: DesignTokensDark.legacyDatavizMustard50,
    legacyDatavizMustard500: DesignTokensDark.legacyDatavizMustard500,
    legacyDatavizMustard600: DesignTokensDark.legacyDatavizMustard600,
    legacyDatavizMustard700: DesignTokensDark.legacyDatavizMustard700,
    legacyDatavizMustard800: DesignTokensDark.legacyDatavizMustard800,
    legacyDatavizMustard900: DesignTokensDark.legacyDatavizMustard900,
    legacyDatavizRuby100: DesignTokensDark.legacyDatavizRuby100,
    legacyDatavizRuby200: DesignTokensDark.legacyDatavizRuby200,
    legacyDatavizRuby300: DesignTokensDark.legacyDatavizRuby300,
    legacyDatavizRuby400: DesignTokensDark.legacyDatavizRuby400,
    legacyDatavizRuby50: DesignTokensDark.legacyDatavizRuby50,
    legacyDatavizRuby500: DesignTokensDark.legacyDatavizRuby500,
    legacyDatavizRuby600: DesignTokensDark.legacyDatavizRuby600,
    legacyDatavizRuby700: DesignTokensDark.legacyDatavizRuby700,
    legacyDatavizRuby800: DesignTokensDark.legacyDatavizRuby800,
    legacyDatavizRuby900: DesignTokensDark.legacyDatavizRuby900,
    legacyDatavizTangerine100: DesignTokensDark.legacyDatavizTangerine100,
    legacyDatavizTangerine200: DesignTokensDark.legacyDatavizTangerine200,
    legacyDatavizTangerine300: DesignTokensDark.legacyDatavizTangerine300,
    legacyDatavizTangerine400: DesignTokensDark.legacyDatavizTangerine400,
    legacyDatavizTangerine50: DesignTokensDark.legacyDatavizTangerine50,
    legacyDatavizTangerine500: DesignTokensDark.legacyDatavizTangerine500,
    legacyDatavizTangerine600: DesignTokensDark.legacyDatavizTangerine600,
    legacyDatavizTangerine700: DesignTokensDark.legacyDatavizTangerine700,
    legacyDatavizTangerine800: DesignTokensDark.legacyDatavizTangerine800,
    legacyDatavizTangerine900: DesignTokensDark.legacyDatavizTangerine900,
    legacyTagBackgroundBasicBold: DesignTokensDark.legacyTagBackgroundBasicBold,
    legacyTagBackgroundDenim: DesignTokensDark.legacyTagBackgroundDenim,
    legacyTagBackgroundLavender: DesignTokensDark.legacyTagBackgroundLavender,
    legacyTagBackgroundLime: DesignTokensDark.legacyTagBackgroundLime,
    legacyTagBackgroundMustard: DesignTokensDark.legacyTagBackgroundMustard,
    legacyTagBackgroundPrimary: DesignTokensDark.legacyTagBackgroundPrimary,
    legacyTagBackgroundRuby: DesignTokensDark.legacyTagBackgroundRuby,
    legacyTagBackgroundTangerine: DesignTokensDark.legacyTagBackgroundTangerine,
    legacyTagBorderBasicBold: DesignTokensDark.legacyTagBorderBasicBold,
    legacyTagBorderDenim: DesignTokensDark.legacyTagBorderDenim,
    legacyTagBorderLavender: DesignTokensDark.legacyTagBorderLavender,
    legacyTagBorderLime: DesignTokensDark.legacyTagBorderLime,
    legacyTagBorderMustard: DesignTokensDark.legacyTagBorderMustard,
    legacyTagBorderPrimary: DesignTokensDark.legacyTagBorderPrimary,
    legacyTagBorderRuby: DesignTokensDark.legacyTagBorderRuby,
    legacyTagBorderTangerine: DesignTokensDark.legacyTagBorderTangerine,
    legacyTagTextBasicBold: DesignTokensDark.legacyTagTextBasicBold,
    legacyTagTextDenim: DesignTokensDark.legacyTagTextDenim,
    legacyTagTextLavender: DesignTokensDark.legacyTagTextLavender,
    legacyTagTextLime: DesignTokensDark.legacyTagTextLime,
    legacyTagTextMustard: DesignTokensDark.legacyTagTextMustard,
    legacyTagTextPrimary: DesignTokensDark.legacyTagTextPrimary,
    legacyTagTextRuby: DesignTokensDark.legacyTagTextRuby,
    legacyTagTextTangerine: DesignTokensDark.legacyTagTextTangerine,
    paletteBasicsBlack: DesignTokensDark.paletteBasicsBlack,
    paletteBasicsWhite: DesignTokensDark.paletteBasicsWhite,
    paletteBasicsWhite64: DesignTokensDark.paletteBasicsWhite64,
    paletteBrandCoral0: DesignTokensDark.paletteBrandCoral0,
    paletteBrandCoral100: DesignTokensDark.paletteBrandCoral100,
    paletteBrandCoral1000: DesignTokensDark.paletteBrandCoral1000,
    paletteBrandCoral150: DesignTokensDark.paletteBrandCoral150,
    paletteBrandCoral200: DesignTokensDark.paletteBrandCoral200,
    paletteBrandCoral25: DesignTokensDark.paletteBrandCoral25,
    paletteBrandCoral300: DesignTokensDark.paletteBrandCoral300,
    paletteBrandCoral400: DesignTokensDark.paletteBrandCoral400,
    paletteBrandCoral50: DesignTokensDark.paletteBrandCoral50,
    paletteBrandCoral500: DesignTokensDark.paletteBrandCoral500,
    paletteBrandCoral600: DesignTokensDark.paletteBrandCoral600,
    paletteBrandCoral700: DesignTokensDark.paletteBrandCoral700,
    paletteBrandCoral800: DesignTokensDark.paletteBrandCoral800,
    paletteBrandCoral900: DesignTokensDark.paletteBrandCoral900,
    paletteBrandGrey0: DesignTokensDark.paletteBrandGrey0,
    paletteBrandGrey100: DesignTokensDark.paletteBrandGrey100,
    paletteBrandGrey1000: DesignTokensDark.paletteBrandGrey1000,
    paletteBrandGrey150: DesignTokensDark.paletteBrandGrey150,
    paletteBrandGrey200: DesignTokensDark.paletteBrandGrey200,
    paletteBrandGrey25: DesignTokensDark.paletteBrandGrey25,
    paletteBrandGrey300: DesignTokensDark.paletteBrandGrey300,
    paletteBrandGrey400: DesignTokensDark.paletteBrandGrey400,
    paletteBrandGrey50: DesignTokensDark.paletteBrandGrey50,
    paletteBrandGrey500: DesignTokensDark.paletteBrandGrey500,
    paletteBrandGrey600: DesignTokensDark.paletteBrandGrey600,
    paletteBrandGrey700: DesignTokensDark.paletteBrandGrey700,
    paletteBrandGrey800: DesignTokensDark.paletteBrandGrey800,
    paletteBrandGrey900: DesignTokensDark.paletteBrandGrey900,
    paletteBrandIndigo0: DesignTokensDark.paletteBrandIndigo0,
    paletteBrandIndigo100: DesignTokensDark.paletteBrandIndigo100,
    paletteBrandIndigo1000: DesignTokensDark.paletteBrandIndigo1000,
    paletteBrandIndigo150: DesignTokensDark.paletteBrandIndigo150,
    paletteBrandIndigo200: DesignTokensDark.paletteBrandIndigo200,
    paletteBrandIndigo25: DesignTokensDark.paletteBrandIndigo25,
    paletteBrandIndigo300: DesignTokensDark.paletteBrandIndigo300,
    paletteBrandIndigo400: DesignTokensDark.paletteBrandIndigo400,
    paletteBrandIndigo50: DesignTokensDark.paletteBrandIndigo50,
    paletteBrandIndigo500: DesignTokensDark.paletteBrandIndigo500,
    paletteBrandIndigo600: DesignTokensDark.paletteBrandIndigo600,
    paletteBrandIndigo700: DesignTokensDark.paletteBrandIndigo700,
    paletteBrandIndigo800: DesignTokensDark.paletteBrandIndigo800,
    paletteBrandIndigo900: DesignTokensDark.paletteBrandIndigo900,
    paletteBrandNight0: DesignTokensDark.paletteBrandNight0,
    paletteBrandNight064: DesignTokensDark.paletteBrandNight064,
    paletteBrandNight100: DesignTokensDark.paletteBrandNight100,
    paletteBrandNight1000: DesignTokensDark.paletteBrandNight1000,
    paletteBrandNight100012: DesignTokensDark.paletteBrandNight100012,
    paletteBrandNight100016: DesignTokensDark.paletteBrandNight100016,
    paletteBrandNight10008: DesignTokensDark.paletteBrandNight10008,
    paletteBrandNight150: DesignTokensDark.paletteBrandNight150,
    paletteBrandNight200: DesignTokensDark.paletteBrandNight200,
    paletteBrandNight25: DesignTokensDark.paletteBrandNight25,
    paletteBrandNight300: DesignTokensDark.paletteBrandNight300,
    paletteBrandNight400: DesignTokensDark.paletteBrandNight400,
    paletteBrandNight50: DesignTokensDark.paletteBrandNight50,
    paletteBrandNight500: DesignTokensDark.paletteBrandNight500,
    paletteBrandNight600: DesignTokensDark.paletteBrandNight600,
    paletteBrandNight700: DesignTokensDark.paletteBrandNight700,
    paletteBrandNight800: DesignTokensDark.paletteBrandNight800,
    paletteBrandNight900: DesignTokensDark.paletteBrandNight900,
    paletteDatavizBlue50: DesignTokensDark.paletteDatavizBlue50,
    paletteDatavizBlue500: DesignTokensDark.paletteDatavizBlue500,
    paletteDatavizGreen50: DesignTokensDark.paletteDatavizGreen50,
    paletteDatavizGreen500: DesignTokensDark.paletteDatavizGreen500,
    paletteDatavizOrange50: DesignTokensDark.paletteDatavizOrange50,
    paletteDatavizOrange500: DesignTokensDark.paletteDatavizOrange500,
    paletteDatavizPink50: DesignTokensDark.paletteDatavizPink50,
    paletteDatavizPink500: DesignTokensDark.paletteDatavizPink500,
    paletteDatavizPurple50: DesignTokensDark.paletteDatavizPurple50,
    paletteDatavizPurple500: DesignTokensDark.paletteDatavizPurple500,
    paletteDatavizRed50: DesignTokensDark.paletteDatavizRed50,
    paletteDatavizRed500: DesignTokensDark.paletteDatavizRed500,
    paletteSemanticBlue0: DesignTokensDark.paletteSemanticBlue0,
    paletteSemanticBlue100: DesignTokensDark.paletteSemanticBlue100,
    paletteSemanticBlue1000: DesignTokensDark.paletteSemanticBlue1000,
    paletteSemanticBlue150: DesignTokensDark.paletteSemanticBlue150,
    paletteSemanticBlue200: DesignTokensDark.paletteSemanticBlue200,
    paletteSemanticBlue25: DesignTokensDark.paletteSemanticBlue25,
    paletteSemanticBlue300: DesignTokensDark.paletteSemanticBlue300,
    paletteSemanticBlue400: DesignTokensDark.paletteSemanticBlue400,
    paletteSemanticBlue50: DesignTokensDark.paletteSemanticBlue50,
    paletteSemanticBlue500: DesignTokensDark.paletteSemanticBlue500,
    paletteSemanticBlue600: DesignTokensDark.paletteSemanticBlue600,
    paletteSemanticBlue700: DesignTokensDark.paletteSemanticBlue700,
    paletteSemanticBlue800: DesignTokensDark.paletteSemanticBlue800,
    paletteSemanticBlue900: DesignTokensDark.paletteSemanticBlue900,
    paletteSemanticGreen0: DesignTokensDark.paletteSemanticGreen0,
    paletteSemanticGreen100: DesignTokensDark.paletteSemanticGreen100,
    paletteSemanticGreen1000: DesignTokensDark.paletteSemanticGreen1000,
    paletteSemanticGreen150: DesignTokensDark.paletteSemanticGreen150,
    paletteSemanticGreen200: DesignTokensDark.paletteSemanticGreen200,
    paletteSemanticGreen25: DesignTokensDark.paletteSemanticGreen25,
    paletteSemanticGreen300: DesignTokensDark.paletteSemanticGreen300,
    paletteSemanticGreen400: DesignTokensDark.paletteSemanticGreen400,
    paletteSemanticGreen50: DesignTokensDark.paletteSemanticGreen50,
    paletteSemanticGreen500: DesignTokensDark.paletteSemanticGreen500,
    paletteSemanticGreen600: DesignTokensDark.paletteSemanticGreen600,
    paletteSemanticGreen700: DesignTokensDark.paletteSemanticGreen700,
    paletteSemanticGreen800: DesignTokensDark.paletteSemanticGreen800,
    paletteSemanticGreen900: DesignTokensDark.paletteSemanticGreen900,
    paletteSemanticOrange0: DesignTokensDark.paletteSemanticOrange0,
    paletteSemanticOrange100: DesignTokensDark.paletteSemanticOrange100,
    paletteSemanticOrange1000: DesignTokensDark.paletteSemanticOrange1000,
    paletteSemanticOrange150: DesignTokensDark.paletteSemanticOrange150,
    paletteSemanticOrange200: DesignTokensDark.paletteSemanticOrange200,
    paletteSemanticOrange25: DesignTokensDark.paletteSemanticOrange25,
    paletteSemanticOrange300: DesignTokensDark.paletteSemanticOrange300,
    paletteSemanticOrange400: DesignTokensDark.paletteSemanticOrange400,
    paletteSemanticOrange50: DesignTokensDark.paletteSemanticOrange50,
    paletteSemanticOrange500: DesignTokensDark.paletteSemanticOrange500,
    paletteSemanticOrange600: DesignTokensDark.paletteSemanticOrange600,
    paletteSemanticOrange700: DesignTokensDark.paletteSemanticOrange700,
    paletteSemanticOrange800: DesignTokensDark.paletteSemanticOrange800,
    paletteSemanticOrange900: DesignTokensDark.paletteSemanticOrange900,
    paletteSemanticRed0: DesignTokensDark.paletteSemanticRed0,
    paletteSemanticRed100: DesignTokensDark.paletteSemanticRed100,
    paletteSemanticRed1000: DesignTokensDark.paletteSemanticRed1000,
    paletteSemanticRed150: DesignTokensDark.paletteSemanticRed150,
    paletteSemanticRed200: DesignTokensDark.paletteSemanticRed200,
    paletteSemanticRed25: DesignTokensDark.paletteSemanticRed25,
    paletteSemanticRed300: DesignTokensDark.paletteSemanticRed300,
    paletteSemanticRed400: DesignTokensDark.paletteSemanticRed400,
    paletteSemanticRed50: DesignTokensDark.paletteSemanticRed50,
    paletteSemanticRed500: DesignTokensDark.paletteSemanticRed500,
    paletteSemanticRed600: DesignTokensDark.paletteSemanticRed600,
    paletteSemanticRed700: DesignTokensDark.paletteSemanticRed700,
    paletteSemanticRed800: DesignTokensDark.paletteSemanticRed800,
    paletteSemanticRed900: DesignTokensDark.paletteSemanticRed900,
    textAlertBasic: DesignTokensDark.textAlertBasic,
    textAlertDanger: DesignTokensDark.textAlertDanger,
    textAlertInfo: DesignTokensDark.textAlertInfo,
    textAlertSuccess: DesignTokensDark.textAlertSuccess,
    textAlertWarning: DesignTokensDark.textAlertWarning,
    textDisabled: DesignTokensDark.textDisabled,
    textInteractivePrimaryActive: DesignTokensDark.textInteractivePrimaryActive,
    textInteractivePrimaryDefault:
        DesignTokensDark.textInteractivePrimaryDefault,
    textInteractivePrimaryHover: DesignTokensDark.textInteractivePrimaryHover,
    textInteractiveSecondaryActive:
        DesignTokensDark.textInteractiveSecondaryActive,
    textInteractiveSecondaryDefault:
        DesignTokensDark.textInteractiveSecondaryDefault,
    textInteractiveSecondaryHover:
        DesignTokensDark.textInteractiveSecondaryHover,
    textStaticInverse: DesignTokensDark.textStaticInverse,
    textStaticOnColor: DesignTokensDark.textStaticOnColor,
    textStaticPrimary: DesignTokensDark.textStaticPrimary,
    textStaticSecondary: DesignTokensDark.textStaticSecondary,
    textStaticTertiary: DesignTokensDark.textStaticTertiary,
    visualAssetsAccent: DesignTokensDark.visualAssetsAccent,
    visualAssetsNeutralBold: DesignTokensDark.visualAssetsNeutralBold,
    visualAssetsNeutralBold0: DesignTokensDark.visualAssetsNeutralBold0,
    visualAssetsNeutralSubtle: DesignTokensDark.visualAssetsNeutralSubtle,
    visualAssetsNeutralSubtle0: DesignTokensDark.visualAssetsNeutralSubtle0,
    visualAssetsSemanticDanger: DesignTokensDark.visualAssetsSemanticDanger,
    visualAssetsSemanticInfo: DesignTokensDark.visualAssetsSemanticInfo,
    visualAssetsSemanticSuccess: DesignTokensDark.visualAssetsSemanticSuccess,
    visualAssetsSemanticWarning: DesignTokensDark.visualAssetsSemanticWarning,

    bodyExtraSmall: DesignTokensDark.bodyExtraSmall,
    bodyExtraSmallStrong: DesignTokensDark.bodyExtraSmallStrong,
    bodyLarge: DesignTokensDark.bodyLarge,
    bodyLargeStrong: DesignTokensDark.bodyLargeStrong,
    bodyMedium: DesignTokensDark.bodyMedium,
    bodyMediumStrong: DesignTokensDark.bodyMediumStrong,
    bodySmall: DesignTokensDark.bodySmall,
    bodySmallStrong: DesignTokensDark.bodySmallStrong,
    highlightLarge: DesignTokensDark.highlightLarge,
    highlightMedium: DesignTokensDark.highlightMedium,
    highlightSmall: DesignTokensDark.highlightSmall,
    titleLarge: DesignTokensDark.titleLarge,
    titleLargeStrong: DesignTokensDark.titleLargeStrong,
    titleMedium: DesignTokensDark.titleMedium,
    titleMediumStrong: DesignTokensDark.titleMediumStrong,
    titleSmall: DesignTokensDark.titleSmall,
    titleSmallStrong: DesignTokensDark.titleSmallStrong,

    borderRadius0: DesignTokensDark.borderRadius0,
    borderRadius100: DesignTokensDark.borderRadius100,
    borderRadius150: DesignTokensDark.borderRadius150,
    borderRadius200: DesignTokensDark.borderRadius200,
    borderRadius25: DesignTokensDark.borderRadius25,
    borderRadius300: DesignTokensDark.borderRadius300,
    borderRadius50: DesignTokensDark.borderRadius50,
    borderRadiusBase: DesignTokensDark.borderRadiusBase,
    borderRadiusRound: DesignTokensDark.borderRadiusRound,

    borderWidth0: DesignTokensDark.borderWidth0,
    borderWidth100: DesignTokensDark.borderWidth100,
    borderWidth200: DesignTokensDark.borderWidth200,
    borderWidth300: DesignTokensDark.borderWidth300,
    borderWidth800: DesignTokensDark.borderWidth800,
    fontSize100: DesignTokensDark.fontSize100,
    fontSize200: DesignTokensDark.fontSize200,
    fontSize300: DesignTokensDark.fontSize300,
    fontSize400: DesignTokensDark.fontSize400,
    fontSize50: DesignTokensDark.fontSize50,
    fontSize500: DesignTokensDark.fontSize500,
    fontSize600: DesignTokensDark.fontSize600,
    fontSize700: DesignTokensDark.fontSize700,
    fontSize75: DesignTokensDark.fontSize75,
    fontSize800: DesignTokensDark.fontSize800,
    fontSize900: DesignTokensDark.fontSize900,
    fontSizeBase: DesignTokensDark.fontSizeBase,
    fontSizeRatio: DesignTokensDark.fontSizeRatio,
    letterSpacingCondensed: DesignTokensDark.letterSpacingCondensed,
    letterSpacingDefault: DesignTokensDark.letterSpacingDefault,
    letterSpacingWide: DesignTokensDark.letterSpacingWide,
    lineHeight100: DesignTokensDark.lineHeight100,
    lineHeight200: DesignTokensDark.lineHeight200,
    lineHeight300: DesignTokensDark.lineHeight300,
    opacity0: DesignTokensDark.opacity0,
    opacity100: DesignTokensDark.opacity100,
    opacity1000: DesignTokensDark.opacity1000,
    opacity150: DesignTokensDark.opacity150,
    opacity200: DesignTokensDark.opacity200,
    opacity400: DesignTokensDark.opacity400,
    opacity600: DesignTokensDark.opacity600,
    opacity800: DesignTokensDark.opacity800,
    sizing100: DesignTokensDark.sizing100,
    sizing1000: DesignTokensDark.sizing1000,
    sizing1200: DesignTokensDark.sizing1200,
    sizing1300: DesignTokensDark.sizing1300,
    sizing200: DesignTokensDark.sizing200,
    sizing300: DesignTokensDark.sizing300,
    sizing400: DesignTokensDark.sizing400,
    sizing50: DesignTokensDark.sizing50,
    sizing500: DesignTokensDark.sizing500,
    sizing550: DesignTokensDark.sizing550,
    sizing600: DesignTokensDark.sizing600,
    sizing700: DesignTokensDark.sizing700,
    sizing75: DesignTokensDark.sizing75,
    sizing800: DesignTokensDark.sizing800,
    sizing900: DesignTokensDark.sizing900,
    sizingBase: DesignTokensDark.sizingBase,
    spacing0: DesignTokensDark.spacing0,
    spacing100: DesignTokensDark.spacing100,
    spacing1000: DesignTokensDark.spacing1000,
    spacing1200: DesignTokensDark.spacing1200,
    spacing150: DesignTokensDark.spacing150,
    spacing200: DesignTokensDark.spacing200,
    spacing25: DesignTokensDark.spacing25,
    spacing250: DesignTokensDark.spacing250,
    spacing300: DesignTokensDark.spacing300,
    spacing400: DesignTokensDark.spacing400,
    spacing450: DesignTokensDark.spacing450,
    spacing50: DesignTokensDark.spacing50,
    spacing500: DesignTokensDark.spacing500,
    spacing600: DesignTokensDark.spacing600,
    spacing700: DesignTokensDark.spacing700,
    spacing800: DesignTokensDark.spacing800,
    spacing900: DesignTokensDark.spacing900,
    spacingBase: DesignTokensDark.spacingBase,

    fontFamilyUi: DesignTokensDark.fontFamilyUi,

    fontWeight300: DesignTokensDark.fontWeight300,
    fontWeight400: DesignTokensDark.fontWeight400,
    fontWeight500: DesignTokensDark.fontWeight500,
    fontWeight600: DesignTokensDark.fontWeight600,

    shadow0: DesignTokensDark.shadow0,
    shadow100: DesignTokensDark.shadow100,
    shadow200: DesignTokensDark.shadow200,
    shadow300: DesignTokensDark.shadow300,

    textDecorationNone: DesignTokensDark.textDecorationNone,
    textDecorationUnderline: DesignTokensDark.textDecorationUnderline,
  );
}
