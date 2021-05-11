import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('kiosk_mode');

Future<void> get startKioskMode async {
  return _channel.invokeMethod('startKioskMode');
}

Future<void> get stopKioskMode async {
  return _channel.invokeMethod('stopKioskMode');
}
