import 'package:optimus/src/button/base_button_variant.dart';

enum OptimusButtonVariant { primary, secondary, tertiary, ghost, danger }

extension BaseVariantResolve on OptimusButtonVariant {
  BaseButtonVariant toBaseVariant() => switch (this) {
    OptimusButtonVariant.primary => BaseButtonVariant.primary,
    OptimusButtonVariant.secondary => BaseButtonVariant.secondary,
    OptimusButtonVariant.tertiary => BaseButtonVariant.tertiary,
    OptimusButtonVariant.ghost => BaseButtonVariant.ghost,
    OptimusButtonVariant.danger => BaseButtonVariant.danger,
  };
}
