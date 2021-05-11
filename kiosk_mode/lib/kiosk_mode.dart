
import 'dart:async';

import 'package:flutter/services.dart';

class KioskMode {
  static const MethodChannel _channel =
      const MethodChannel('kiosk_mode');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
