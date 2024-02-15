import 'package:flutter/widgets.dart';

/// The link with custom action.
///
/// This link is defined by the [text] widget, usually [Text] and the
/// function that will be executed after a click.
class OptimusFeedbackLink {
  const OptimusFeedbackLink({
    required this.text,
    required this.onPressed,
  });

  /// The text widget that will be displayed as a link.
  final Widget text;

  /// The function that will be executed after a click on the link.
  final VoidCallback onPressed;
}
