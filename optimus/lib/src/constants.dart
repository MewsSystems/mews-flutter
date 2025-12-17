import 'package:flutter/rendering.dart';

abstract final class OpacityValue {
  static const double enabled = 1;
  static const double disabled = .32;
}

const double _cornerRadiusValue = 4;
const BorderRadius borderRadius = BorderRadius.all(
  .circular(_cornerRadiusValue),
);
