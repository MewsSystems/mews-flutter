import 'package:flutter/widgets.dart';

enum Breakpoint { extraSmall, small, medium, large, extraLarge }

extension MediaQueryDataScreenBreakpoint on Size {
  Breakpoint get screenBreakpoint {
    final width = this.width;
    if (width < 360) {
      return Breakpoint.extraSmall;
    } else if (width < 600) {
      return Breakpoint.small;
    } else if (width < 1024) {
      return Breakpoint.medium;
    } else if (width < 1400) {
      return Breakpoint.large;
    }

    return Breakpoint.extraLarge;
  }
}
