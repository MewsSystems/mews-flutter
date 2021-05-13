import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiosk_mode/kiosk_mode.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.mews.kiosk_mode/kiosk_mode');
  final calls = <String>[];

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    calls.clear();
    channel.setMockMethodCallHandler((call) async => calls.add(call.method));
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('startKioskMode', () async {
    await startKioskMode();
    expect(calls, ['startKioskMode']);
  });

  test('stopKioskMode', () async {
    await stopKioskMode();
    expect(calls, ['stopKioskMode']);
  });
}
