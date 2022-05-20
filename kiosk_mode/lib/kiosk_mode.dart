import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:stream_transform/stream_transform.dart';

const _channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');

/// Channel used to send "kiosk mode" updates from platform.
///
/// Implementing it on Android platform is useless, as this plugin already
/// does it. See [watchKioskMode] for explanation.
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
/// Since as Android doesn't allow subscribing to lock task mode changes,
/// a mode is queried every time with a period of [androidQueryPeriod].
Stream<KioskMode> watchKioskMode({
  Duration androidQueryPeriod = const Duration(seconds: 5),
}) =>
    Stream.fromFuture(getKioskMode())
        .merge(_getKioskModeStream(androidQueryPeriod));

Stream<KioskMode> _getKioskModeStream(Duration androidQueryPeriod) {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return Stream<void>.periodic(androidQueryPeriod)
          .asyncMap((_) => getKioskMode());
    default:
      return _eventChannel.receiveBroadcastStream().map(
            (dynamic value) =>
                value == true ? KioskMode.enabled : KioskMode.disabled,
          );
  }
}
