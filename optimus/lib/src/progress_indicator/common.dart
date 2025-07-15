import 'package:flutter/cupertino.dart';
import 'package:optimus/src/common/text_scaling.dart';
import 'package:optimus/src/theme/theme.dart';

extension Theme on BuildContext {
  double get titleSize => tokens.sizing400.toScaled(this);
  double get descriptionSize => tokens.sizing500.toScaled(this);
  double get indicatorHeight => tokens.sizing400.toScaled(this);
  double get indicatorWidth => tokens.sizing300.toScaled(this);
}
