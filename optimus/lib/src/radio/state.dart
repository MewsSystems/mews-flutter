import 'dart:ui';

import 'package:optimus/src/theme/optimus_tokens.dart';

enum RadioState { basic, hover, active, disabled }

extension TokensTheme on RadioState {
  Color borderColor(OptimusTokens tokens, {required bool isSelected}) =>
      switch (this) {
        RadioState.basic => isSelected
            ? tokens.backgroundInteractivePrimaryDefault
            : tokens.borderInteractiveSecondaryDefault,
        RadioState.hover => isSelected
            ? tokens.backgroundInteractivePrimaryHover
            : tokens.borderInteractiveSecondaryHover,
        RadioState.active => isSelected
            ? tokens.backgroundInteractivePrimaryActive
            : tokens.borderInteractiveSecondaryActive,
        RadioState.disabled =>
          isSelected ? tokens.backgroundDisabled : tokens.borderDisabled,
      };

  Color circleFillColor(OptimusTokens tokens) => switch (this) {
        RadioState.basic ||
        RadioState.disabled =>
          tokens.backgroundInteractiveNeutralSubtleDefault,
        RadioState.hover => tokens.backgroundInteractiveNeutralSubtleHover,
        RadioState.active => tokens.backgroundInteractiveNeutralSubtleActive,
      };
}
