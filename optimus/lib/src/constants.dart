import 'package:flutter/rendering.dart';

abstract class OpacityValue {
  static const double enabled = 1;
  static const double disabled = .32;
}

const double _cornerRadiusValue = 4;
const BorderRadius borderRadius =
    BorderRadius.all(Radius.circular(_cornerRadiusValue));
