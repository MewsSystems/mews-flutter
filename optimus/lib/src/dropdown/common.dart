import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

extension DropdownSpacing on BuildContext {
  double get listVerticalPadding => tokens.spacing50;
  double get listHorizontalPadding => tokens.spacing100;
  double get verticalSpacing => tokens.spacing50;

  double get dropdownGroupSeparatorHeight {
    final typographyHeight = tokens.bodySmall.fontSize ?? tokens.fontSize75;
    final lineHeight = tokens.bodySmall.height ?? tokens.lineHeight300;
    final baseHeight = typographyHeight * lineHeight;

    return baseHeight + (tokens.spacing100 * 2);
  }
}
