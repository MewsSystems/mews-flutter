import 'package:optimus/src/button/base_button_variant.dart';

enum OptimusButtonVariant { primary, secondary, tertiary, ghost, danger }

extension BaseVariantResolve on OptimusButtonVariant {
  BaseButtonVariant toBaseVariant() => switch (this) {
    .primary => .primary,
    .secondary => .secondary,
    .tertiary => .tertiary,
    .ghost => .ghost,
    .danger => .danger,
  };
}
