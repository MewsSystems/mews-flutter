import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

enum OptimusButtonVariant { primary, secondary, tertiary, ghost, danger }

extension ColorScheme on OptimusButtonVariant {
  Color? backgroundColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case OptimusButtonVariant.primary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.backgroundInteractivePrimaryDefault;
      case OptimusButtonVariant.secondary:
        if (!isEnabled) return null;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return null;
      case OptimusButtonVariant.tertiary:
      case OptimusButtonVariant.ghost:
        if (!isEnabled) return null;
        if (isPressed) return tokens.backgroundInteractiveSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveSubtleHover;

        return null;
      case OptimusButtonVariant.danger:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveDangerActive;
        if (isHovered) return tokens.backgroundInteractiveDangerHover;

        return tokens.backgroundInteractiveDangerDefault;
    }
  }

  Color foregroundColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case OptimusButtonVariant.primary:
      case OptimusButtonVariant.danger:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticInverse;
      case OptimusButtonVariant.secondary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed || isHovered) {
          return tokens.textStaticInverse;
        }

        return tokens.textInteractiveDefault;
      case OptimusButtonVariant.tertiary:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticSecondary;
      case OptimusButtonVariant.ghost:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticPrimary;
    }
  }

  Color badgeColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case OptimusButtonVariant.primary:
      case OptimusButtonVariant.danger:
        if (!isEnabled) return tokens.textDisabled;

        return tokens.textStaticInverse;
      case OptimusButtonVariant.secondary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundStaticFlat;
        if (isHovered) return tokens.backgroundStaticFlat;

        return tokens.textInteractiveDefault;
      case OptimusButtonVariant.tertiary:
        if (!isEnabled) return tokens.backgroundDisabled;

        return tokens.textStaticSecondary;
      case OptimusButtonVariant.ghost:
        if (!isEnabled) return tokens.backgroundDisabled;

        return tokens.textStaticPrimary;
    }
  }

  Color badgeTextColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case OptimusButtonVariant.primary:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.backgroundInteractivePrimaryDefault;
      case OptimusButtonVariant.secondary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractivePrimaryActive;
        if (isHovered) return tokens.backgroundInteractivePrimaryHover;

        return tokens.textStaticInverse;
      case OptimusButtonVariant.tertiary:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractiveSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveSubtleHover;

        return tokens.backgroundStaticFlat;
      case OptimusButtonVariant.ghost:
        if (!isEnabled) return tokens.textDisabled;
        if (isPressed) return tokens.backgroundInteractiveSubtleActive;
        if (isHovered) return tokens.backgroundInteractiveSubtleHover;

        return tokens.textStaticInverse;
      case OptimusButtonVariant.danger:
        if (!isEnabled) return tokens.backgroundDisabled;
        if (isPressed) return tokens.backgroundInteractiveDangerActive;
        if (isHovered) return tokens.backgroundInteractiveDangerHover;

        return tokens.backgroundInteractiveDangerDefault;
    }
  }

  Color? borderColor(
    OptimusTokens tokens, {
    required bool isEnabled,
    required bool isPressed,
    required bool isHovered,
  }) {
    switch (this) {
      case OptimusButtonVariant.primary:
      case OptimusButtonVariant.ghost:
      case OptimusButtonVariant.danger:
        return null;
      case OptimusButtonVariant.secondary:
        if (!isEnabled) return tokens.borderDisabled;
        if (isPressed) return tokens.borderInteractivePrimaryActive;
        if (isHovered) return tokens.borderInteractivePrimaryHover;

        return tokens.borderInteractivePrimaryDefault;
      case OptimusButtonVariant.tertiary:
        if (!isEnabled) return tokens.borderDisabled;
        if (isPressed) return tokens.borderInteractiveSecondaryActive;
        if (isHovered) return tokens.borderInteractiveSecondaryHover;

        return tokens.borderInteractiveSecondaryDefault;
    }
  }
}
