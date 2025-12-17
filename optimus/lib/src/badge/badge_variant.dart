import 'dart:ui';

import 'package:optimus/src/theme/optimus_tokens.dart';

enum OptimusBadgeVariant { primary, subtle }

extension Style on OptimusBadgeVariant {
  Color getBackgroundColor(OptimusTokens tokens) => switch (this) {
    .primary => tokens.backgroundAccentPrimary,
    .subtle => tokens.legacyTagBackgroundPrimary,
  };

  Color getTextColor(OptimusTokens tokens) => switch (this) {
    .primary => tokens.textStaticInverse,
    .subtle => tokens.legacyTagTextPrimary,
  };
}
