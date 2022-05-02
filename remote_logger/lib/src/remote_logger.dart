import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

typedef GetBody = FutureOr<Map<String, dynamic>> Function(
  LogRecord record,
  Map<String, dynamic> body,
);
typedef GetHeaders = FutureOr<Map<String, String>> Function(
  Map<String, String> headers,
);

class RemoteLogger {
  /// Creates a new [RemoteLogger] that will post each log message to [url].
  ///
  /// By default, it will specify one header: `Content-Type: application/json`.
  /// You can update headers by providing [getHeaders] parameter.
  ///
  /// Default request body is `{'message': record.message}`. You can override
  /// it by providing [getBody] parameter.
  RemoteLogger({
    required Uri url,
    GetBody? getBody,
    GetHeaders? getHeaders,
    Client? client,
  })  : _url = url,
        _client = client,
        _getHeaders = getHeaders ?? _defaultGetHeaders,
        _getBody = getBody ?? _defaultGetBody {
    _process();
  }

  @nonVirtual
  void call(LogRecord record) {
    final defaultBody = <String, dynamic>{'message': record.message};
    Future.value(_getBody(record, defaultBody)).then((body) {
      if (_records.isClosed) {
        throw StateError('RemoteLogger is already disposed');
      }
      _records.add(json.encode(body));
    });
  }

  /// Call this method when this logger is no longer needed.
  ///
  /// It's an error to add log messages after this method is called.
  @mustCallSuper
  Future<void> dispose() async {
    await _records.close();
    await _messages.cancel();
    _internalClient?.close();
  }

  final StreamController<String> _records = StreamController();
  late final StreamQueue<String> _messages = StreamQueue(_records.stream);
  final Uri _url;
  final GetBody _getBody;
  final GetHeaders _getHeaders;
  Duration _currentTimeout = _initialTimeout;

  final Client? _client;
  Client? _internalClient;

  Client get _effectiveClient => _client ?? (_internalClient ??= Client());

  Future<void> _process() async {
    while (await _messages.hasNext) {
      final record = await _messages.next;
      while (!await _processRecord(record)) {
        await Future<void>.delayed(_currentTimeout);
        if (_currentTimeout * _timeoutMultiplier <= _maxTimeout) {
          _currentTimeout *= _timeoutMultiplier;
        }
      }
      _currentTimeout = _initialTimeout;
    }
  }

  /// Posts the given [record] and returns `false` in case of a retriable error.
  ///
  /// `true` means either the record was posted or the error was not retriable,
  /// in any case we can move to the next record.
  Future<bool> _processRecord(String record) async {
    try {
      final headers = await _getHeaders(_defaultHeaders);
      final response = await _effectiveClient
          .post(
            _url,
            headers: headers,
            body: record,
          )
          .timeout(_requestTimeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        // Server error, should retry.
        return false;
      } else {
        // Some other status code, don't retry.
        return true;
      }
    } on TimeoutException {
      return false;
    } on ClientException {
      return false;

      // ignore: avoid_catches_without_on_clauses, we don't care about any other record
    } catch (_) {
      // Some other error, don't retry.
      return true;
    }
  }
}

const Duration _requestTimeout = Duration(seconds: 30);
const Duration _initialTimeout = Duration(seconds: 2);
const Duration _maxTimeout = Duration(minutes: 2);
const int _timeoutMultiplier = 2;
const _defaultHeaders = <String, String>{
  'ContentType': 'application/json',
};

Map<String, String> _defaultGetHeaders(Map<String, String> headers) => headers;

Map<String, dynamic> _defaultGetBody(LogRecord _, Map<String, dynamic> body) =>
    body;
