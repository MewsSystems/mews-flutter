import 'dart:ui';

import 'package:optimus/src/theme/optimus_tokens.dart';

enum OptimusBadgeVariant { primary, subtle }

extension Style on OptimusBadgeVariant {
  Color getBackgroundColor(OptimusTokens tokens) => switch (this) {
    OptimusBadgeVariant.primary => tokens.backgroundAccentPrimary,
    OptimusBadgeVariant.subtle => tokens.legacyTagBackgroundPrimary,
  };

  Color getTextColor(OptimusTokens tokens) => switch (this) {
    OptimusBadgeVariant.primary => tokens.textStaticInverse,
    OptimusBadgeVariant.subtle => tokens.legacyTagTextPrimary,
  };
}
