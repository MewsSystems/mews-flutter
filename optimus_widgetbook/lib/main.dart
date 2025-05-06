import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/addons/accessibility.dart';
import 'package:optimus_widgetbook/main.directories.g.dart';
import 'package:widgetbook/widgetbook.dart' hide AccessibilityAddon;
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() => runApp(const WidgetbookApp());

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    addons: <WidgetbookAddon>[
      DeviceFrameAddon(
        devices: [
          Devices.ios.iPhone13Mini,
          Devices.ios.iPhone13,
          Devices.ios.iPhone13ProMax,
          Devices.ios.iPadAir4,
          Devices.ios.iPad12InchesGen4,
        ],
      ),
      InspectorAddon(),
      AccessibilityAddon(),
      ThemeAddon<OptimusThemeData>(
        themes: [
          const WidgetbookTheme(
            name: 'Light',
            data: OptimusThemeData(
              brightness: Brightness.light,
              // ignore: deprecated_member_use, to be removed alongside with the OptimusColors
              colors: OptimusColors(Brightness.light),
              tokens: OptimusTokens.light,
            ),
          ),
          const WidgetbookTheme(
            name: 'Dark',
            data: OptimusThemeData(
              brightness: Brightness.dark,
              // ignore: deprecated_member_use, to be removed alongside with the OptimusColors
              colors: OptimusColors(Brightness.dark),
              tokens: OptimusTokens.dark,
            ),
          ),
        ],
        themeBuilder:
            (context, theme, child) => OptimusTheme(
              themeMode:
                  theme.brightness == Brightness.light
                      ? ThemeMode.light
                      : ThemeMode.dark,
              child: child,
            ),
      ),
      BuilderAddon(
        name: 'Background builder',
        builder:
            (BuildContext context, Widget widget) => ColoredBox(
              color: context.tokens.backgroundStaticFlat,
              child: SafeArea(child: widget),
            ),
      ),
      AlignmentAddon(),
      SemanticsAddon(),
    ],
    directories: directories,
  );
}
