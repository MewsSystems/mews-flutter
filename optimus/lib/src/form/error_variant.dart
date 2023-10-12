/// The way of displaying the error message.
enum OptimusInputErrorVariant {
  /// The error message is displayed below the input.
  bottomHint,

  /// The error message is displayed as a tooltip near the input. The tooltip is
  /// shown after the interaction with the error icon.
  inlineTooltip,
}
