import 'dart:ui';

import 'package:optimus/src/theme/optimus_tokens.dart';

enum OptimusBadgeVariant {
  primary,
  success,
  warning,
  danger,
  info,
  subtle,
}

extension Style on OptimusBadgeVariant {
  Color getBackgroundColor(OptimusTokens tokens) => switch (this) {
        OptimusBadgeVariant.primary => tokens.backgroundAccent,
        OptimusBadgeVariant.success => tokens.backgroundAlertSuccessSecondary,
        OptimusBadgeVariant.warning => tokens.backgroundAlertWarningSecondary,
        OptimusBadgeVariant.danger => tokens.backgroundAlertDangerSecondary,
        OptimusBadgeVariant.info => tokens.backgroundAlertInfoSecondary,
        OptimusBadgeVariant.subtle => tokens.legacyTagBackgroundPrimary,
      };

  Color getTextColor(OptimusTokens tokens) => switch (this) {
        OptimusBadgeVariant.primary => tokens.textStaticInverse,
        OptimusBadgeVariant.success => tokens.textAlertSuccess,
        OptimusBadgeVariant.warning => tokens.textAlertWarning,
        OptimusBadgeVariant.danger => tokens.textAlertDanger,
        OptimusBadgeVariant.info => tokens.textAlertInfo,
        OptimusBadgeVariant.subtle => tokens.legacyTagTextPrimary,
      };
}
