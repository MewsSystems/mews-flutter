Dart library for posting logs to a remote storage. Use together with `logging`
library.

## Features

- [X] Post log message to remote server
- [X] Provide custom headers
- [X] Override request body
- [X] Retry on errors with exponential timeout
- [ ] TODO: cache/store information locally

## Usage

```dart
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
```

## Additional information

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/MewsSystems/mews-flutter/issues
