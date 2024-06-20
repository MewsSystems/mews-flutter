import 'package:flutter/cupertino.dart';
import 'package:optimus/src/theme/theme.dart';

extension Theme on BuildContext {
  double get titleSize => tokens.sizing400;
  double get descriptionSize => tokens.sizing500;
  double get indicatorHeight => tokens.sizing400;
  double get indicatorWidth => tokens.sizing300;
}
