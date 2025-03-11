import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_logger/remote_logger.dart';
import 'package:test/test.dart';

import 'remote_logger_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  Logger.root.level = Level.ALL;

  final logger = Logger('test');
  final client = MockClient();
  final sut = RemoteLogger(client: client, url: Uri());

  setUp(() => Logger.root.onRecord.listen(sut.call));

  tearDown(() {
    Logger.root.clearListeners();
    reset(client);
  });

  test('posts standard messages', () async {
    logger
      ..info('message 1')
      ..info('message 2');

    await Future<void>.delayed(const Duration(seconds: 1));

    verifyInOrder([
      client.post(
        any,
        headers: anyNamed('headers'),
        body: '{"message":"message 1"}',
      ),
      client.post(
        any,
        headers: anyNamed('headers'),
        body: '{"message":"message 2"}',
      ),
    ]);
  });

  test('retries after timeout on error', () async {
    final responses = [Response('', 500), Response('', 200)];
    when(
      client.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
    ).thenAnswer((_) async => responses.removeAt(0));

    logger.info('message');

    await Future<void>.delayed(const Duration(seconds: 1));
    verify(
      client.post(
        any,
        headers: anyNamed('headers'),
        body: '{"message":"message"}',
      ),
    ).called(1);

    await Future<void>.delayed(const Duration(seconds: 2));
    verify(
      client.post(
        any,
        headers: anyNamed('headers'),
        body: '{"message":"message"}',
      ),
    ).called(1);
  });
}
