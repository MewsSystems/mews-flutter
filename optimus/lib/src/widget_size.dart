import 'package:optimus/src/theme/optimus_tokens.dart';

enum OptimusWidgetSize { small, medium, large }

extension Value on OptimusWidgetSize {
  double getValue(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.sizing400,
        OptimusWidgetSize.medium => tokens.sizing500,
        OptimusWidgetSize.large => tokens.sizing600,
      };
}
