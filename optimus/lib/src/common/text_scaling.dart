import 'package:flutter/widgets.dart';

extension SizeScalingExt on double {
  double toScaled(BuildContext context) =>
      MediaQuery.textScalerOf(context).scale(this);
}
