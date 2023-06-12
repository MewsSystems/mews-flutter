import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
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
    Brightness fallbackBrightness() => Theme.of(context).brightness;
    final theme = context.dependOnInheritedWidgetOfExactType<_OptimusTheme>();

    return theme?.theme ??
        (fallbackBrightness() == Brightness.dark
            ? _defaultDarkTheme
            : _defaultLightTheme);
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    final bool isDark = themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && brightness == Brightness.dark);
    final theme = isDark
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
    required this.theme,
    required super.child,
  });

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
    colors: colors,
  );
}

mixin ThemeGetter<T extends StatefulWidget> on State<T> {
  OptimusThemeData get theme => OptimusTheme.of(context);
}
