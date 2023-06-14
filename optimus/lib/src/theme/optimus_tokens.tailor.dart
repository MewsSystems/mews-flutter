// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'optimus_tokens.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

class OptimusTokens extends ThemeExtension<OptimusTokens>
    with DiagnosticableTreeMixin {
  const OptimusTokens({
    required this.backgroundAccentPrimary,
    required this.backgroundAccentSecondary,
    required this.backgroundAlertBasicPrimary,
    required this.backgroundDisabled,
    required this.backgroundInteractivePrimaryActive,
    required this.backgroundInteractivePrimaryDefault,
    required this.backgroundInteractivePrimaryHover,
    required this.textStaticInverse,
  });

  final Color backgroundAccentPrimary;
  final Color backgroundAccentSecondary;
  final Color backgroundAlertBasicPrimary;
  final Color backgroundDisabled;
  final Color backgroundInteractivePrimaryActive;
  final Color backgroundInteractivePrimaryDefault;
  final Color backgroundInteractivePrimaryHover;
  final Color textStaticInverse;

  static final OptimusTokens light = OptimusTokens(
    backgroundAccentPrimary: _$OptimusTokens.backgroundAccentPrimary[0],
    backgroundAccentSecondary: _$OptimusTokens.backgroundAccentSecondary[0],
    backgroundAlertBasicPrimary: _$OptimusTokens.backgroundAlertBasicPrimary[0],
    backgroundDisabled: _$OptimusTokens.backgroundDisabled[0],
    backgroundInteractivePrimaryActive:
        _$OptimusTokens.backgroundInteractivePrimaryActive[0],
    backgroundInteractivePrimaryDefault:
        _$OptimusTokens.backgroundInteractivePrimaryDefault[0],
    backgroundInteractivePrimaryHover:
        _$OptimusTokens.backgroundInteractivePrimaryHover[0],
    textStaticInverse: _$OptimusTokens.textStaticInverse[0],
  );

  static final OptimusTokens dark = OptimusTokens(
    backgroundAccentPrimary: _$OptimusTokens.backgroundAccentPrimary[1],
    backgroundAccentSecondary: _$OptimusTokens.backgroundAccentSecondary[1],
    backgroundAlertBasicPrimary: _$OptimusTokens.backgroundAlertBasicPrimary[1],
    backgroundDisabled: _$OptimusTokens.backgroundDisabled[1],
    backgroundInteractivePrimaryActive:
        _$OptimusTokens.backgroundInteractivePrimaryActive[1],
    backgroundInteractivePrimaryDefault:
        _$OptimusTokens.backgroundInteractivePrimaryDefault[1],
    backgroundInteractivePrimaryHover:
        _$OptimusTokens.backgroundInteractivePrimaryHover[1],
    textStaticInverse: _$OptimusTokens.textStaticInverse[1],
  );

  static final themes = [
    light,
    dark,
  ];

  @override
  OptimusTokens copyWith({
    Color? backgroundAccentPrimary,
    Color? backgroundAccentSecondary,
    Color? backgroundAlertBasicPrimary,
    Color? backgroundDisabled,
    Color? backgroundInteractivePrimaryActive,
    Color? backgroundInteractivePrimaryDefault,
    Color? backgroundInteractivePrimaryHover,
    Color? textStaticInverse,
  }) {
    return OptimusTokens(
      backgroundAccentPrimary:
          backgroundAccentPrimary ?? this.backgroundAccentPrimary,
      backgroundAccentSecondary:
          backgroundAccentSecondary ?? this.backgroundAccentSecondary,
      backgroundAlertBasicPrimary:
          backgroundAlertBasicPrimary ?? this.backgroundAlertBasicPrimary,
      backgroundDisabled: backgroundDisabled ?? this.backgroundDisabled,
      backgroundInteractivePrimaryActive: backgroundInteractivePrimaryActive ??
          this.backgroundInteractivePrimaryActive,
      backgroundInteractivePrimaryDefault:
          backgroundInteractivePrimaryDefault ??
              this.backgroundInteractivePrimaryDefault,
      backgroundInteractivePrimaryHover: backgroundInteractivePrimaryHover ??
          this.backgroundInteractivePrimaryHover,
      textStaticInverse: textStaticInverse ?? this.textStaticInverse,
    );
  }

  @override
  OptimusTokens lerp(covariant ThemeExtension<OptimusTokens>? other, double t) {
    if (other is! OptimusTokens) return this as OptimusTokens;
    return OptimusTokens(
      backgroundAccentPrimary: Color.lerp(
          backgroundAccentPrimary, other.backgroundAccentPrimary, t)!,
      backgroundAccentSecondary: Color.lerp(
          backgroundAccentSecondary, other.backgroundAccentSecondary, t)!,
      backgroundAlertBasicPrimary: Color.lerp(
          backgroundAlertBasicPrimary, other.backgroundAlertBasicPrimary, t)!,
      backgroundDisabled:
          Color.lerp(backgroundDisabled, other.backgroundDisabled, t)!,
      backgroundInteractivePrimaryActive: Color.lerp(
          backgroundInteractivePrimaryActive,
          other.backgroundInteractivePrimaryActive,
          t)!,
      backgroundInteractivePrimaryDefault: Color.lerp(
          backgroundInteractivePrimaryDefault,
          other.backgroundInteractivePrimaryDefault,
          t)!,
      backgroundInteractivePrimaryHover: Color.lerp(
          backgroundInteractivePrimaryHover,
          other.backgroundInteractivePrimaryHover,
          t)!,
      textStaticInverse:
          Color.lerp(textStaticInverse, other.textStaticInverse, t)!,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OptimusTokens'))
      ..add(DiagnosticsProperty(
          'backgroundAccentPrimary', backgroundAccentPrimary))
      ..add(DiagnosticsProperty(
          'backgroundAccentSecondary', backgroundAccentSecondary))
      ..add(DiagnosticsProperty(
          'backgroundAlertBasicPrimary', backgroundAlertBasicPrimary))
      ..add(DiagnosticsProperty('backgroundDisabled', backgroundDisabled))
      ..add(DiagnosticsProperty('backgroundInteractivePrimaryActive',
          backgroundInteractivePrimaryActive))
      ..add(DiagnosticsProperty('backgroundInteractivePrimaryDefault',
          backgroundInteractivePrimaryDefault))
      ..add(DiagnosticsProperty('backgroundInteractivePrimaryHover',
          backgroundInteractivePrimaryHover))
      ..add(DiagnosticsProperty('textStaticInverse', textStaticInverse));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OptimusTokens &&
            const DeepCollectionEquality().equals(
                backgroundAccentPrimary, other.backgroundAccentPrimary) &&
            const DeepCollectionEquality().equals(
                backgroundAccentSecondary, other.backgroundAccentSecondary) &&
            const DeepCollectionEquality().equals(backgroundAlertBasicPrimary,
                other.backgroundAlertBasicPrimary) &&
            const DeepCollectionEquality()
                .equals(backgroundDisabled, other.backgroundDisabled) &&
            const DeepCollectionEquality().equals(
                backgroundInteractivePrimaryActive,
                other.backgroundInteractivePrimaryActive) &&
            const DeepCollectionEquality().equals(
                backgroundInteractivePrimaryDefault,
                other.backgroundInteractivePrimaryDefault) &&
            const DeepCollectionEquality().equals(
                backgroundInteractivePrimaryHover,
                other.backgroundInteractivePrimaryHover) &&
            const DeepCollectionEquality()
                .equals(textStaticInverse, other.textStaticInverse));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundAccentPrimary),
      const DeepCollectionEquality().hash(backgroundAccentSecondary),
      const DeepCollectionEquality().hash(backgroundAlertBasicPrimary),
      const DeepCollectionEquality().hash(backgroundDisabled),
      const DeepCollectionEquality().hash(backgroundInteractivePrimaryActive),
      const DeepCollectionEquality().hash(backgroundInteractivePrimaryDefault),
      const DeepCollectionEquality().hash(backgroundInteractivePrimaryHover),
      const DeepCollectionEquality().hash(textStaticInverse),
    );
  }
}
