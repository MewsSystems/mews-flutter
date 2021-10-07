import 'dart:async';

import 'package:flutter/services.dart';
import 'package:stream_transform/stream_transform.dart';

const _channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');
const _eventChannel = EventChannel('com.mews.kiosk_mode/kiosk_mode_stream');

/// Corresponds to lock task / screen pinning mode on Android, and
/// guided access mode on iOS.
enum KioskMode {
  /// Kiosk mode is enabled.
  enabled,

  /// Kiosk mode is disabled.
  disabled,
}

/// Request to put this activity in a mode where the user is locked to a
/// restricted set of applications.
///
/// Returns true, if platform satisfied the request successfully,
/// false - otherwise.
///
/// It's only supported on Android currently, where it calls `startLockTask`.
/// It will throw `FlutterMethodNotImplemented` on iOS.
Future<bool> startKioskMode() => _channel
    .invokeMethod<bool>('startKioskMode')
    .then((value) => value ?? false);

/// Stop the current task from being locked.
///
/// It's only supported on Android currently, where it calls `stopLockTask`.
/// It will throw `FlutterMethodNotImplemented` on iOS.
Future<void> stopKioskMode() => _channel.invokeMethod('stopKioskMode');

/// Returns the current [KioskMode].
///
/// On Android, it calls `isInLockTaskMode`.
///
/// On iOS, it returns result of `UIAccessibility.isGuidedAccessEnabled`.
Future<KioskMode> getKioskMode() => _channel
    .invokeMethod<bool>('isInKioskMode')
    .then((value) => value == true ? KioskMode.enabled : KioskMode.disabled);

/// Returns the stream with [KioskMode].
///
/// It works on iOS only, as Android doesn't allow subscribing to lock task
/// mode changes.
Stream<KioskMode> watchKioskMode() =>
    Stream.fromFuture(getKioskMode()).merge(_kioskModeStream);

late final Stream<KioskMode> _kioskModeStream =
    _eventChannel.receiveBroadcastStream().map(
          (dynamic value) =>
              value == true ? KioskMode.enabled : KioskMode.disabled,
        );
