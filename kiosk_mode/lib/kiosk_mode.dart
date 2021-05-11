import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('kiosk_mode');

Future<void> get startKioskMode async {
  await SystemChrome.setEnabledSystemUIOverlays([]);
  return _channel.invokeMethod('startKioskMode');
}

Future<void> get stopKioskMode async {
  await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  return _channel.invokeMethod('stopKioskMode');
}
