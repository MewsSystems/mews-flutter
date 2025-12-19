import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus_icons/optimus_icons.dart';

/// Describes a certain type of feedback with its semantical meaning.
///
/// Use-cases:
///  - [OptimusFeedbackVariant.info] -  Used for notifying about
/// informational, supportive, educative matter.
///  - [OptimusFeedbackVariant.success] - Used for notifying about
/// successful, confirming, positive matter.
///  - [OptimusFeedbackVariant.warning] -  Used for notifying about
/// warnings, problems, or matters that require the user's attention.
///  - [OptimusFeedbackVariant.danger] - Used for notifying about the
/// dangerous matter. Could be error, destructive action or negative feedback.
enum OptimusFeedbackVariant { info, success, warning, danger }

extension Theming on OptimusFeedbackVariant {
  IconData get icon => switch (this) {
    .info => OptimusIcons.info_24,
    .success => OptimusIcons.done_circle_24,
    .warning => OptimusIcons.problematic_24,
    .danger => OptimusIcons.alert_circle_24,
  };

  Color getIconColor(OptimusTokens tokens) => switch (this) {
    .info => tokens.textAlertInfo,
    .success => tokens.textAlertSuccess,
    .warning => tokens.textAlertWarning,
    .danger => tokens.textAlertDanger,
  };

  Color backgroundColor(OptimusTokens tokens) => switch (this) {
    .info => tokens.backgroundAlertInfoDefault,
    .success => tokens.backgroundAlertSuccessDefault,
    .warning => tokens.backgroundAlertWarningDefault,
    .danger => tokens.backgroundAlertDangerDefault,
  };
}
