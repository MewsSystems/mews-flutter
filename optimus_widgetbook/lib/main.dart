import 'package:flutter/material.dart';
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
          GridAddon(100),
          AlignmentAddon(),
          ZoomAddon(),
        ],
        directories: directories,
      );
}
