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
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: () async {
                    await startKioskMode;
                  },
                  child: const Text('Start Kiosk Mode'),
                ),
                MaterialButton(
                  onPressed: () async {
                    await stopKioskMode;
                  },
                  child: const Text('Stop Kiosk Mode'),
                ),
              ],
            ),
          ),
        ),
      );
}
