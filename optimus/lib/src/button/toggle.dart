import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';

enum OptimusToggleButtonSizeVariant { small, medium, large }

/// A toggle button is a button that can be toggled on (selected) or off (not
/// selected).
class OptimusToggleButton extends StatelessWidget {
  const OptimusToggleButton({
    super.key,
    this.label,
    this.isToggled = false,
    this.onPressed,
    this.isLoading = false,
    this.size = OptimusToggleButtonSizeVariant.large,
  });

  /// The label of the button. Typically a [Text] widget. If null, the button
  /// will use only the icon.
  final Widget? label;

  /// Whether the button is toggled on.
  final bool isToggled;

  /// Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  /// Whether the button is in the loading state.
  final bool isLoading;

  /// The size of the button.
  final OptimusToggleButtonSizeVariant size;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final contentPadding = label != null
        ? EdgeInsets.symmetric(
            vertical: size.getLabelVerticalPadding(tokens),
            horizontal: tokens.spacing100,
          )
        : EdgeInsets.all(size.getCompactPadding(tokens));

    return BaseButton(
      variant: isToggled ? .success : .tertiary,
      size: size.toWidgetSize(),
      isLoading: isLoading,
      onPressed: onPressed,
      padding: contentPadding,
      child: Row(
        children: [
          Icon(OptimusIcons.checkbox_plus, size: tokens.sizing200),
          if (label case final label?)
            Padding(
              padding: .only(left: size.getPaddingInsidePadding(tokens)),
              child: label,
            ),
        ],
      ),
    );
  }
}

extension on OptimusToggleButtonSizeVariant {
  OptimusWidgetSize toWidgetSize() => switch (this) {
    .small => .small,
    .medium => .medium,
    .large => .large,
  };

  double getLabelVerticalPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing50,
    .medium => tokens.spacing100,
    .large => tokens.spacing150,
  };

  double getPaddingInsidePadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing100,
    .medium || .large => tokens.spacing150,
  };

  double getCompactPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing100,
    .medium => tokens.spacing150,
    .large => tokens.spacing200,
  };
}
