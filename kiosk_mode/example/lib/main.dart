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
              children: const [
                MaterialButton(
                  onPressed: startKioskMode,
                  child: Text('Start Kiosk Mode'),
                ),
                MaterialButton(
                  onPressed: stopKioskMode,
                  child: Text('Stop Kiosk Mode'),
                ),
              ],
            ),
          ),
        ),
      );
}
