import 'package:flutter/widgets.dart';

enum Breakpoint { extraSmall, small, medium, large, extraLarge }

extension MediaQueryDataScreenBreakpoint on Size {
  Breakpoint get screenBreakpoint {
    final width = this.width;
    if (width < 360) {
      return .extraSmall;
    } else if (width < 600) {
      return .small;
    } else if (width < 1024) {
      return .medium;
    } else if (width < 1400) {
      return .large;
    }

    return .extraLarge;
  }
}
