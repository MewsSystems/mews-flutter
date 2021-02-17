import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusButtonVariant { defaultButton, primary, text, destructive, warning }

/// Buttons are an element that let users trigger or perform an action.
/// Button labels should inform users about what will happen upon interaction.
///
/// There's a wide variety of actions a button can trigger, including saving,
/// logging in, deleting, and resetting. Buttons are not a navigation element.
class OptimusButton extends StatelessWidget {
  const OptimusButton({
    Key key,
    this.onPressed,
    @required this.child,
    this.minWidth,
    this.leftIcon,
    this.rightIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
  }) : super(key: key);

  /// Called when the button is tapped or otherwise activated.
  ///
  /// If this callback is null, then the button will be disabled.
  final VoidCallback onPressed;

  /// Typically the button's label.
  final Widget child;

  final double minWidth;

  final IconData leftIcon;

  final IconData rightIcon;

  final String badgeLabel;

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

  Widget _buildIcon(IconData icon) =>
      Icon(icon, size: _iconSize, color: _textColor);

  TextStyle get _textStyle =>
      size == OptimusWidgetSize.small ? preset200s : preset300s;

  Widget _buildBadgeLabel(String badgeLabel) => SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 16,
            color: _textColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing50),
              child: Text(
                badgeLabel,
                style: preset100s.copyWith(color: _textColor, height: 1.3),
              ),
            ),
          ),
        ),
      );

  // ignore: missing_return
  double get _iconSize {
    switch (size) {
      case OptimusWidgetSize.small:
        return 16;
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return 24;
    }
  }

  // ignore: missing_return
  Color get _color {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusColors.neutral50;
      case OptimusButtonVariant.primary:
        return OptimusColors.primary500;
      case OptimusButtonVariant.text:
        return Colors.transparent;
      case OptimusButtonVariant.destructive:
        return OptimusColors.danger500;
      case OptimusButtonVariant.warning:
        return OptimusColors.warning500;
    }
  }

  // ignore: missing_return
  Color get _hoverColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusColors.neutral100;
      case OptimusButtonVariant.primary:
        return OptimusColors.primary700;
      case OptimusButtonVariant.text:
        return OptimusColors.neutral500t8;
      case OptimusButtonVariant.destructive:
        return OptimusColors.danger700;
      case OptimusButtonVariant.warning:
        return OptimusColors.warning700;
    }
  }

  // ignore: missing_return
  Color get _highLightColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusColors.neutral200;
      case OptimusButtonVariant.primary:
        return OptimusColors.primary900;
      case OptimusButtonVariant.text:
        return OptimusColors.neutral500t16;
      case OptimusButtonVariant.destructive:
        return OptimusColors.danger900;
      case OptimusButtonVariant.warning:
        return OptimusColors.warning900;
    }
  }

  // ignore: missing_return
  Color get _textColor {
    switch (variant) {
      case OptimusButtonVariant.defaultButton:
        return OptimusColors.neutral500;
      case OptimusButtonVariant.primary:
        return OptimusColors.neutral0;
      case OptimusButtonVariant.text:
        return OptimusColors.neutral500;
      case OptimusButtonVariant.destructive:
        return OptimusColors.neutral0;
      case OptimusButtonVariant.warning:
        return OptimusColors.neutral900;
    }
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity:
            onPressed != null ? OpacityValue.enabled : OpacityValue.disabled,
        child: MaterialButton(
          minWidth: minWidth,
          height: size.value,
          elevation: 0,
          highlightElevation: 0,
          highlightColor: _highLightColor,
          disabledColor: _color,
          disabledTextColor: _textColor,
          hoverElevation: 0,
          splashColor: Colors.transparent,
          hoverColor: _hoverColor,
          onPressed: onPressed,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(borderRadius50),
          ),
          color: _color,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (leftIcon != null) _buildIcon(leftIcon),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: spacing100),
                child: DefaultTextStyle.merge(
                  child: child,
                  style: _textStyle.copyWith(color: _textColor, height: 1),
                ),
              ),
              if (rightIcon != null) _buildIcon(rightIcon),
              if (badgeLabel != null && badgeLabel.isNotEmpty)
                _buildBadgeLabel(badgeLabel),
            ],
          ),
        ),
      );
}
