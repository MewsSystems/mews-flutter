import 'dart:async';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');

/// Request to put this activity in a mode where the user is locked to a
/// restricted set of applications.
///
/// Returns true, if platform satisfied the request successfully,
/// false - otherwise.
///
/// It's only supported on Android currently, where it calls [startLockTask].
/// It will throw [FlutterMethodNotImplemented] on iOS.
Future<bool> startKioskMode() => _channel
    .invokeMethod<bool>('startKioskMode')
    .then((value) => value ?? false);

/// Stop the current task from being locked.
///
/// It's only supported on Android currently, where it calls [stopLockTask].
/// It will throw [FlutterMethodNotImplemented] on iOS.
Future<void> stopKioskMode() => _channel.invokeMethod('stopKioskMode');
