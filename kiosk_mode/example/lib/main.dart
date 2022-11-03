import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: const Center(child: _Home()),
        ),
      );
}

class _Home extends StatefulWidget {
  const _Home({
    Key? key,
  }) : super(key: key);

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  late final Stream<KioskMode> _currentMode = watchKioskMode();

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            onPressed: () => startKioskMode().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value
                        ? 'Kiosk mode started'
                        : Platform.isIOS
                            ? 'Single App mode is supported only for devices that are supervised using Mobile Device Management (MDM) and the app itself must be enabled for this mode by MDM.'
                            : 'Kiosk mode could not be started.',
                  ),
                ),
              ),
            ),
            child: const Text('Start Kiosk Mode'),
          ),
          MaterialButton(
            onPressed: () => stopKioskMode().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value ? 'Kiosk mode stopped.' : 'Kiosk mode could not be stopped or wasn\'t active to begin with.',
                  ),
                ),
              ),
            ),
            child: const Text('Stop Kiosk Mode'),
          ),
          MaterialButton(
            onPressed: () => isManagedKiosk().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kiosk is managed: $value')),
              ),
            ),
            child: const Text('Is Managed Kiosk'),
          ),
          MaterialButton(
            onPressed: () => getKioskMode().then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kiosk mode: $value')),
              ),
            ),
            child: const Text('Check mode'),
          ),
          StreamBuilder<KioskMode>(
            stream: _currentMode,
            builder: (context, snapshot) => Text(
              'Current mode: ${snapshot.data}',
            ),
          ),
        ],
      );
}
