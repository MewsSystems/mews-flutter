import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';

enum BaseButtonVariant { primary, secondary, tertiary, ghost, danger, success }

extension ColorScheme on BaseButtonVariant {
  // TODO(witwash): split and rework, possibly using WidgetStates
  Color? getBackgroundColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case .primary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.backgroundInteractivePrimaryDefault;
      case .secondary:
        if (!isEnabled) return null;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return null;
      case .tertiary:
      case .ghost:
        if (!isEnabled) return null;
        if (isPressed) return tokens.backgroundInteractiveNeutralSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveNeutralSubtleHover;

        return null;
      case .danger:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveDangerActive;
        if (isHovered) return tokens.backgroundInteractiveDangerHover;

        return tokens.backgroundInteractiveDangerDefault;
      case .success:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveSuccessActive;
        if (isHovered) return tokens.backgroundInteractiveSuccessHover;

        return tokens.backgroundInteractiveSuccessDefault;
    }
  }

  Color getForegroundColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case .primary:
      case .danger:
      case .success:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticInverse;
      case .secondary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed || isHovered) {
          return tokens.textStaticInverse;
        }

        return tokens.textInteractivePrimaryDefault;
      case .tertiary:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticSecondary;
      case .ghost:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticPrimary;
    }
  }

  Color getBadgeColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case .primary:
      case .danger:
      case .success:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticInverse;
      case .secondary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed || isHovered) return tokens.backgroundStaticFlat;

        return tokens.textInteractivePrimaryDefault;
      case .tertiary:
        if (!isEnabled) return tokens.backgroundDisabled;

        return tokens.textStaticSecondary;
      case .ghost:
        if (!isEnabled) return tokens.backgroundDisabled;

        return tokens.textStaticPrimary;
    }
  }

  // TODO(witwash): split and rewrite, possibly using WidgetState
  Color getBadgeTextColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case .primary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.backgroundInteractivePrimaryDefault;
      case .secondary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.textStaticInverse;
      case .tertiary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractiveNeutralSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveNeutralSubtleHover;

        return tokens.backgroundStaticFlat;
      case .ghost:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractiveNeutralSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveNeutralSubtleHover;

        return tokens.textStaticInverse;
      case .danger:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveDangerActive;
        if (isHovered) return tokens.backgroundInteractiveDangerHover;

        return tokens.backgroundInteractiveDangerDefault;
      case .success:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveSuccessActive;
        if (isHovered) return tokens.backgroundInteractiveSuccessHover;

        return tokens.backgroundInteractiveSuccessDefault;
    }
  }

  Color? getBorderColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case .primary:
      case .ghost:
      case .danger:
      case .success:
        return null;
      case .secondary:
        if (!isEnabled) return tokens.borderDisabled;
        if (isPressed) return tokens.borderInteractivePrimaryActive;
        if (isHovered) return tokens.borderInteractivePrimaryHover;

        return tokens.borderInteractivePrimaryDefault;
      case .tertiary:
        if (!isEnabled) return tokens.borderDisabled;
        if (isPressed) return tokens.borderInteractiveSecondaryActive;
        if (isHovered) return tokens.borderInteractiveSecondaryHover;

        return tokens.borderInteractiveSecondaryDefault;
    }
  }
}
