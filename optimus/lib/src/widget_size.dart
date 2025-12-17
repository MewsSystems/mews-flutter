import 'package:optimus/src/theme/optimus_tokens.dart';

enum OptimusWidgetSize { small, medium, large, extraLarge }

extension Value on OptimusWidgetSize {
  double getWidgetHeight(OptimusTokens tokens) => switch (this) {
    .small => tokens.sizing400,
    .medium => tokens.sizing500,
    .large => tokens.sizing600,
    .extraLarge => tokens.sizing700,
  };
}
