import 'package:flutter/material.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/widget_size.dart';

const buttonAnimationDuration = Duration(milliseconds: 100);
const buttonAnimationCurve = Curves.fastOutSlowIn;

extension ButtonStyleExt on OptimusWidgetSize {
  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing50,
    .medium => tokens.spacing100,
    .large || .extraLarge => tokens.spacing150,
  };

  double getHorizontalPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing150,
    .medium => tokens.spacing200,
    .large || .extraLarge => tokens.spacing300,
  };

  double getInsideHorizontalPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing100,
    .medium || .large || .extraLarge => tokens.spacing150,
  };
}

extension ButtonDimensionExt on BuildContext {
  double get borderWidth => tokens.borderWidth100;
}
