import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');

/// Request to put this activity in a mode where the user is locked to a
/// restricted set of applications.
///
/// It's only supported on Android currently, where it calls [startLockTask].
/// It will throw [FlutterMethodNotImplemented] on iOS.
Future<void> startKioskMode() => _channel.invokeMethod('startKioskMode');

/// Stop the current task from being locked.
///
/// It's only supported on Android currently, where it calls [stopLockTask].
/// It will throw [FlutterMethodNotImplemented] on iOS.
Future<void> stopKioskMode() => _channel.invokeMethod('stopKioskMode');
