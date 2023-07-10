import 'package:optimus/src/typography/typography.dart';

enum Variation { variationNormal, variationSecondary }

extension VariationToColor on Variation {
  OptimusTypographyColor get color => switch (this) {
        Variation.variationNormal => OptimusTypographyColor.primary,
        Variation.variationSecondary => OptimusTypographyColor.secondary,
      };
}
