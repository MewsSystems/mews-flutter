import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button.dart';

/// Buttons are an element that let users trigger or perform an action.
/// Button labels should inform users about what will happen upon interaction.
///
/// There's a wide variety of actions a button can trigger, including saving,
/// logging in, deleting, and resetting. Buttons are not a navigation element.
class OptimusButton extends StatelessWidget {
  const OptimusButton({
    super.key,
    this.onPressed,
    required this.child,
    this.minWidth,
    this.counter,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.primary,
  }) : assert(
          counter == null || counter >= 0,
          'Counter must be null or a non-negative integer',
        );

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback? onPressed;

  /// Typically the button's label.
  final Widget child;

  /// The minimal width of the button.
  final double? minWidth;

  /// The icon to the left of the [child].
  final IconData? leadingIcon;

  /// The icon to the right of the [child].
  final IconData? trailingIcon;

  /// Badge counter.
  ///
  /// If more than 99 will be displayed as 99+. If null or 0, the badge will not
  /// be displayed. Must be a non-negative integer.
  final int? counter;

  /// Size of the button widget.
  final OptimusWidgetSize size;

  /// Whether the button is in the loading state.
  final bool isLoading;

  /// {@template optimus.button.variant}
  /// The variant of the button.
  ///
  /// - [OptimusButtonVariant.primary]: Primary buttons should only appear once
  ///   per screen (not including the App bar, modal dialog, or side panel).
  /// - [OptimusButtonVariant.secondary]: For secondary actions on each page.
  ///   Secondary buttons can only be used in conjunction with a primary button.
  ///   Do not use a secondary button in isolation and do not use a secondary
  ///   button for a positive action.
  /// - [OptimusButtonVariant.tertiary]: For less prominent, and sometimes
  ///   independent, actions. Tertiary buttons can be used in isolation or
  ///   paired with a primary button when there are multiple calls to action.
  ///   Tertiary buttons can also be used for sub-tasks on a page where a
  ///   primary button for the main and final action is present.
  /// - [OptimusButtonVariant.ghost]: For the least pronounced actions; often
  ///   used in conjunction with a primary button. In a situation such as a
  ///   progress flow, a ghost button may be paired with a primary and secondary
  ///   button set, where the primary button is for forward action, the
  ///   secondary button is for “Back”, and the ghost button is for “Cancel”.
  ///   [OptimusButtonVariant.danger]: For actions that could have destructive
  ///   effects on the user’s data (for example, delete or remove).
  /// {@endtemplate}
  final OptimusButtonVariant variant;

  @override
  Widget build(BuildContext context) => BaseButton(
        onPressed: onPressed,
        minWidth: minWidth,
        leadingIcon: leadingIcon,
        trailingIcon: trailingIcon,
        badgeLabel: counter?.let(
          (v) => switch (v) {
            0 => null,
            > 99 => '99+',
            _ => v.toString(),
          },
        ),
        size: size,
        isLoading: isLoading,
        variant: variant.toBaseVariant(),
        child: child,
      );
}
