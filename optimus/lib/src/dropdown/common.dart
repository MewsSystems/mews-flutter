import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dropdown/dropdown_size_data.dart';

extension DropdownSpacing on BuildContext {
  double get dropdownItemVerticalPadding {
    final size = DropdownSizeData.of(this)?.size ?? OptimusWidgetSize.large;

    return switch (size) {
      OptimusWidgetSize.small => tokens.spacing75,
      OptimusWidgetSize.medium => tokens.spacing100,
      OptimusWidgetSize.large ||
      OptimusWidgetSize.extraLarge => tokens.spacing150,
    };
  }

  double get dropdownItemHeight {
    final typographyHeight =
        tokens.bodyMediumStrong.fontSize ?? tokens.fontSizeBase;
    final lineHeight = tokens.bodyMediumStrong.height ?? tokens.lineHeight300;
    final baseHeight = typographyHeight * lineHeight;

    return baseHeight + (dropdownItemVerticalPadding * 2);
  }

  double get dropdownGroupSeparatorHeight {
    final typographyHeight = tokens.bodySmall.fontSize ?? tokens.fontSize75;
    final lineHeight = tokens.bodySmall.height ?? tokens.lineHeight300;
    final baseHeight = typographyHeight * lineHeight;

    return baseHeight + (tokens.spacing100 * 2);
  }
}
