// ignore_for_file: constant_identifier_names

import 'dart:ui';

enum OptimusPictogramVariant {
  calendar,
  calendar_fail,
  card_fail,
  card_pending,
  card_success,
  card,
  contact,
  desktop_settings,
  document,
  email,
  error,
  warning,
  folder,
  help,
  info,
  mobile_key,
  objectives,
  payment_terminal,
  qr,
  search,
  settings,
  success,
  system_error,
  tada,
  target,
  upload;

  String path(Brightness brightness) => 'assets/${brightness.name}/$name.svg';
}
