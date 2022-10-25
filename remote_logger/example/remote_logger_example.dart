// ignore_for_file: prefer-correct-test-file-name

import 'package:logging/logging.dart';
import 'package:remote_logger/remote_logger.dart';

void main() {
  Logger.root.level = Level.ALL;

  final logger = Logger('TestLogger');

  // Create remote logger.
  final remoteLogger = RemoteLogger(
    url: Uri.parse('http://example.com'),
    // Optionally, override the body of the request.
    getBody: (record, body) => <String, dynamic>{
      ...body,
      'level': record.level.toString(),
    },
    // Optionally, provide additional headers.
    getHeaders: (headers) => <String, String>{
      ...headers,
      'X-License-Key': 'TEST_KEY',
    },
  );

  // Set remoteLogger as a listener.
  Logger.root.onRecord.listen(remoteLogger);

  // Log a message.
  logger.info('Test message');
}
