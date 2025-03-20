import 'package:flutter/widgets.dart';

typedef Grouper<T> = String Function(T item);
typedef GroupBuilder = Widget Function(String value);
