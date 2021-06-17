enum OptimusWidgetSize { small, medium, large }

extension Value on OptimusWidgetSize {
  double get value {
    switch (this) {
      case OptimusWidgetSize.small:
        return 32;
      case OptimusWidgetSize.medium:
        return 40;
      case OptimusWidgetSize.large:
        return 48;
    }
  }
}
