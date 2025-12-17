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
    OptimusFeedbackVariant.info => OptimusIcons.info_24,
    OptimusFeedbackVariant.success => OptimusIcons.done_circle_24,
    OptimusFeedbackVariant.warning => OptimusIcons.problematic_24,
    OptimusFeedbackVariant.danger => OptimusIcons.alert_circle_24,
  };

  Color getIconColor(OptimusTokens tokens) => switch (this) {
    OptimusFeedbackVariant.info => tokens.textAlertInfo,
    OptimusFeedbackVariant.success => tokens.textAlertSuccess,
    OptimusFeedbackVariant.warning => tokens.textAlertWarning,
    OptimusFeedbackVariant.danger => tokens.textAlertDanger,
  };

  Color backgroundColor(OptimusTokens tokens) => switch (this) {
    OptimusFeedbackVariant.info => tokens.backgroundAlertInfoDefault,
    OptimusFeedbackVariant.success => tokens.backgroundAlertSuccessDefault,
    OptimusFeedbackVariant.warning => tokens.backgroundAlertWarningDefault,
    OptimusFeedbackVariant.danger => tokens.backgroundAlertDangerDefault,
  };
}
