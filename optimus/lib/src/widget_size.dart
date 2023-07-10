enum OptimusWidgetSize { small, medium, large }

extension Value on OptimusWidgetSize {
  double get value => switch (this) {
        OptimusWidgetSize.small => 32,
        OptimusWidgetSize.medium => 40,
        OptimusWidgetSize.large => 48,
      };
}
