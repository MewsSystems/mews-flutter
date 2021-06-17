import 'package:optimus/src/typography/typography.dart';

enum Variation { variationNormal, variationSecondary }

extension VariationToColor on Variation {
  // ignore: missing_return
  OptimusTypographyColor get color {
    switch (this) {
      case Variation.variationNormal:
        return OptimusTypographyColor.primary;
      case Variation.variationSecondary:
        return OptimusTypographyColor.secondary;
    }
  }
}
