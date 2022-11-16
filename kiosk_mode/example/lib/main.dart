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

  void _showSnackBar(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _handleStart(bool didStart) {
    if (!didStart && Platform.isIOS) {
      _showSnackBar(
        'Single App mode is supported only for devices that are supervised'
        ' using Mobile Device Management (MDM) and the app itself must'
        ' be enabled for this mode by MDM.',
      );
    }
  }

  void _handleStop(bool? didStop) {
    if (didStop == false) {
      _showSnackBar(
        'Kiosk mode could not be stopped or was not active to begin with.',
      );
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _currentMode,
        builder: (context, snapshot) {
          final mode = snapshot.data;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: mode == null || mode == KioskMode.enabled
                    ? null
                    : () => startKioskMode().then(_handleStart),
                child: const Text('Start Kiosk Mode'),
              ),
              MaterialButton(
                onPressed: mode == null || mode == KioskMode.disabled
                    ? null
                    : () => stopKioskMode().then(_handleStop),
                child: const Text('Stop Kiosk Mode'),
              ),
              MaterialButton(
                onPressed: () => isManagedKiosk()
                    .then((isManaged) => 'Kiosk is managed: $isManaged')
                    .then(_showSnackBar),
                child: const Text('Check if managed'),
              ),
              MaterialButton(
                onPressed: () => getKioskMode()
                    .then((mode) => 'Kiosk mode: $mode')
                    .then(_showSnackBar),
                child: const Text('Check mode'),
              ),
              Text('Current mode: ${snapshot.data}'),
            ],
          );
        },
      );
}
