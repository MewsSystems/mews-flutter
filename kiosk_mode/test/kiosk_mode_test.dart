import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');
  final calls = <String>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (call) async => calls.add(call.method),
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('startKioskMode', () async {
    await startKioskMode();
    expect(calls, ['startKioskMode']);
  });

  test('stopKioskMode', () async {
    await stopKioskMode();
    expect(calls, ['stopKioskMode']);
  });

  test('getKioskMode', () async {
    await getKioskMode();
    expect(calls, ['isInKioskMode']);
  });

  test('isManagedKiosk', () async {
    await isManagedKiosk();
    expect(calls, ['isManagedKiosk']);
  });
}
