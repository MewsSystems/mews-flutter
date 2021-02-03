import 'package:optimus/src/typography/typography.dart';

enum Variation { variationDefault, variationSecondary }

extension VariationToColor on Variation {
  // ignore: missing_return
  OptimusTypographyColor get color {
    switch (this) {
      case Variation.variationDefault:
        return OptimusTypographyColor.primary;
      case Variation.variationSecondary:
        return OptimusTypographyColor.secondary;
    }
  }
}
