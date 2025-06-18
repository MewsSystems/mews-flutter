import 'package:flutter/widgets.dart';

extension SizeScalingExt on double {
  double toScaled(BuildContext context) =>
      MediaQuery.textScalerOf(context).clamp(maxScaleFactor: 2).scale(this);
}
