import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus/src/theme/theme_data.dart';

class OptimusTheme extends StatelessWidget {
  const OptimusTheme({
    super.key,
    required this.child,
    this.lightTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  });

  final Widget child;
  final OptimusThemeData? lightTheme;
  final OptimusThemeData? darkTheme;
  final ThemeMode themeMode;

  static OptimusThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<_OptimusTheme>();

    return theme?.theme ??
        (Theme.of(context).brightness == Brightness.dark
            ? _defaultDarkTheme
            : _defaultLightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    final bool isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && brightness == Brightness.dark);
    final theme =
        isDark
            ? (darkTheme ?? _defaultDarkTheme)
            : (lightTheme ?? _defaultLightTheme);

    final child = MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2),
      ),
      child: IconTheme(
        data: IconTheme.of(context).copyWith(applyTextScaling: true),
        child: this.child,
      ),
    );

    return _OptimusTheme(theme: theme, child: child);
  }
}

class _OptimusTheme extends InheritedWidget {
  const _OptimusTheme({required this.theme, required super.child});

  final OptimusThemeData theme;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

final _defaultLightTheme = _createTheme(Brightness.light);

final _defaultDarkTheme = _createTheme(Brightness.dark);

OptimusThemeData _createTheme(Brightness brightness) {
  final colors = OptimusColors(brightness);
  final tokens =
      brightness == Brightness.dark ? OptimusTokens.dark : OptimusTokens.light;

  return OptimusThemeData(
    brightness: brightness,
    colors: colors,
    tokens: tokens,
  );
}

extension ThemeTokens on BuildContext {
  OptimusTokens get tokens => OptimusTheme.of(this).tokens;
  OptimusThemeData get theme => OptimusTheme.of(this);
}

mixin ThemeGetter<T extends StatefulWidget> on State<T> {
  OptimusThemeData get theme => OptimusTheme.of(context);
  OptimusTokens get tokens => OptimusTheme.of(context).tokens;
}

/// Extension to add derived tokens to the OptimusTokens class.
/// This allows for easy access to commonly used derived tokens until we
/// add a proper value.
extension DerivedTokens on OptimusTokens {
  double get spacing75 =>
      spacing50 + spacing25; // TODO(witwash): replace with tokens
  double get sizing150 =>
      sizing100 + sizing50; // TODO(witwash): replace with tokens
}
