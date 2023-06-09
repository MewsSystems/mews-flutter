import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusButtonVariant { defaultButton, primary, text, destructive, warning }

enum OptimusButtonIconPosition { left, right }

/// Buttons are an element that let users trigger or perform an action.
/// Button labels should inform users about what will happen upon interaction.
///
/// There's a wide variety of actions a button can trigger, including saving,
/// logging in, deleting, and resetting. Buttons are not a navigation element.
/// Icon can be added to the left or right side of the button. By default the
/// icon is on the left side. It's recommended to avoid using right icon and the
/// badge at the same time.
class OptimusButton extends StatelessWidget {
  const OptimusButton({
    super.key,
    this.onPressed,
    required this.child,
    this.minWidth,
    this.badgeLabel,
    this.icon,
    this.iconPosition = OptimusButtonIconPosition.left,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
  });

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Typically the button's label.
  final Widget child;

  final double? minWidth;

  final IconData? icon;

  final OptimusButtonIconPosition iconPosition;

  final String? badgeLabel;

  final OptimusWidgetSize size;

  /// The variant of the button.
  ///
  /// - [OptimusButtonVariant.defaultButton]: used if there is no prior action
  ///   necessary.
  /// - [OptimusButtonVariant.primary]: used to highlight the main action of
  ///   the module or to grab the user's attention.
  /// - [OptimusButtonVariant.text]: used for non crucial, complementary, or
  ///   tertiary actions. Used for system control actions when you need multiple
  ///   buttons on one screen without any clear priority.
  /// - [OptimusButtonVariant.destructive]: used to confirm a destructive action
  ///   that the user can’t take back, such as deletion.
  /// - [OptimusButtonVariant.warning]: used to confirm an action that will
  ///   cause significant change. For example, a settings option that the user
  ///   can’t change later.
  final OptimusButtonVariant variant;

  IconData? get _leftIcon =>
      iconPosition == OptimusButtonIconPosition.left ? icon : null;

  IconData? get _rightIcon =>
      iconPosition == OptimusButtonIconPosition.right ? icon : null;

  @override
  Widget build(BuildContext context) => BaseButton(
        onPressed: onPressed,
        minWidth: minWidth,
        leftIcon: _leftIcon,
        rightIcon: _rightIcon,
        badgeLabel: badgeLabel,
        size: size,
        variant: variant,
        child: child,
      );
}
