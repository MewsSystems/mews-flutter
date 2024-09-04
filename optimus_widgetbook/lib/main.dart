import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/main.directories.g.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) => Widgetbook.material(
        addons: [
          DeviceFrameAddon(devices: Devices.all),
          InspectorAddon(),
          AlignmentAddon(),
          ThemeAddon<OptimusThemeData>(
            themes: [
              const WidgetbookTheme(
                name: 'Light',
                data: OptimusThemeData(
                  brightness: Brightness.light,
                  colors: OptimusColors(Brightness.light),
                  tokens: OptimusTokens.light,
                ),
              ),
              const WidgetbookTheme(
                name: 'Dark',
                data: OptimusThemeData(
                  brightness: Brightness.dark,
                  colors: OptimusColors(Brightness.dark),
                  tokens: OptimusTokens.dark,
                ),
              ),
            ],
            themeBuilder: (
              context,
              theme,
              child,
            ) =>
                OptimusTheme(
              themeMode: theme.brightness == Brightness.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
              child: child,
            ),
          ),
          BuilderAddon(
              name: 'Background Builder',
              builder: (BuildContext context, Widget widget) {
                return Theme(
                  data: ThemeData(scaffoldBackgroundColor: Colors.white),
                  child: widget,
                );
              })
        ],
        directories: directories,
      );
}

extension on String? {
  ThemeMode toThemeMode() => ThemeMode.values
      .firstWhere((e) => e.name == this, orElse: () => ThemeMode.system);
}

const _keyTheme = 'themeMode';
