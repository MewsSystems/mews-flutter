import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/theme/theme_data.dart';

class OptimusTheme extends StatelessWidget {
  const OptimusTheme({
    Key key,
    @required this.child,
    this.lightTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
  }) : super(key: key);

  final Widget child;
  final OptimusThemeData lightTheme;
  final OptimusThemeData darkTheme;
  final ThemeMode themeMode;

  static OptimusThemeData of(BuildContext context) {
    final _theme = context.dependOnInheritedWidgetOfExactType<_OptimusTheme>();
    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);
    return _theme?.theme ??
        (platformBrightness == Brightness.dark
            ? _defaultDarkTheme
            : _defaultLightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = themeMode ?? ThemeMode.system;
    final Brightness platformBrightness =
        MediaQuery.platformBrightnessOf(context);
    final bool useDarkTheme = mode == ThemeMode.dark ||
        (mode == ThemeMode.system && platformBrightness == Brightness.dark);
    final theme = useDarkTheme
        ? darkTheme ?? _defaultDarkTheme
        : lightTheme ?? _defaultLightTheme;

    return _OptimusTheme(
      theme: theme,
      child: child,
    );
  }
}

class _OptimusTheme extends InheritedWidget {
  const _OptimusTheme({
    Key key,
    @required this.theme,
    @required Widget child,
  }) : super(key: key, child: child);

  final OptimusThemeData theme;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

final _defaultLightTheme = _createTheme(Brightness.light);

final _defaultDarkTheme = _createTheme(Brightness.dark);

OptimusThemeData _createTheme(Brightness brightness) {
  final colors = OptimusColors(brightness);

  return OptimusThemeData(
    brightness: brightness,
    buttonTheme: OptimusButtonTheme(
      defaultButtonColor: colors.neutral50,
      primaryColor: colors.primary500,
      textColor: Colors.transparent,
      destructiveColor: colors.danger500,
      warningColor: colors.warning500,
    ),
  );
}
