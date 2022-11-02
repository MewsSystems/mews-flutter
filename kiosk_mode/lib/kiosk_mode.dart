import 'dart:async';

import 'package:flutter/services.dart';
import 'package:stream_transform/stream_transform.dart';

const _channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');

/// Channel used to send "kiosk mode" updates from platform.
const _eventChannel = EventChannel('com.mews.kiosk_mode/kiosk_mode_stream');

/// Corresponds to lock task / screen pinning mode on Android, and
/// guided access mode on iOS.
enum KioskMode {
  /// Kiosk mode is enabled.
  enabled,

  /// Kiosk mode is disabled.
  disabled,
}

/// Requests the platform to restrict the current user to the app.
///
/// Returns `true`, if platform satisfied the request successfully, `false` - otherwise.
///
/// On Android, [Activity.startLockTask()](https://developer.android.com/reference/android/app/Activity#startLockTask())
/// is used.
///
/// For iOS, [
/// UIAccessibility.requestGuidedAccessSession](https://developer.apple.com/documentation/uikit/uiaccessibility/1615186-requestguidedaccesssession) is used.
/// Entering Single App mode is supported only for devices that are supervised using Mobile Device Management (MDM), and
/// the app itself must be enabled for this mode by MDM. Otherwise the result will always be `false`.
Future<bool> startKioskMode() => _channel
    .invokeMethod<bool>('startKioskMode')
    .then((value) => value ?? false);

/// On Android, stops the current task from being locked. For iOS, exits the Single App mode.
///
Future<bool> stopKioskMode() => _channel
    .invokeMethod<bool>('stopKioskMode')
    .then((value) => value ?? false);

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
/// The initial value of the stream will always be from [getKioskMode].
///
/// Since Android doesn't allow subscribing to lock task mode changes,
/// a mode is queried every time with a period of [androidQueryPeriod].
Stream<KioskMode> watchKioskMode({
  Duration androidQueryPeriod = const Duration(seconds: 5),
}) =>
    Stream.fromFuture(getKioskMode())
        .merge(_getKioskModeStream(androidQueryPeriod));

Stream<KioskMode> _getKioskModeStream(Duration androidQueryPeriod) =>
    _eventChannel.receiveBroadcastStream(
      {'androidQueryPeriod': androidQueryPeriod.inMilliseconds},
    ).map(
      (dynamic value) => value == true ? KioskMode.enabled : KioskMode.disabled,
    );
