import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    this.onPressed,
    required this.child,
    this.minWidth,
    this.leftIcon,
    this.rightIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = OptimusButtonVariant.defaultButton,
    this.borderRadius = const BorderRadius.all(borderRadius100),
  });

  final VoidCallback? onPressed;

  final Widget child;

  final double? minWidth;

  final IconData? leftIcon;

  final IconData? rightIcon;

  final String? badgeLabel;

  final OptimusWidgetSize size;

  final OptimusButtonVariant variant;

  final BorderRadius borderRadius;

  Widget _buildIcon(IconData icon) => Icon(icon, size: _iconSize);

  TextStyle get _textStyle =>
      size == OptimusWidgetSize.small ? preset200b : preset300b;

  Widget _buildBadgeLabel(String badgeLabel, OptimusThemeData theme) =>
      SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(borderRadius200),
          child: Container(
            height: 16,
            color: _badgeColor(theme),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 3),
              child: Text(
                badgeLabel,
                style: preset50b.copyWith(
                  color: _badgeTextColor(theme),
                  leadingDistribution: TextLeadingDistribution.proportional,
                ),
              ),
            ),
          ),
        ),
      );

  double get _iconSize => switch (size) {
        OptimusWidgetSize.small => 16,
        OptimusWidgetSize.medium || OptimusWidgetSize.large => 24,
      };

  Color _color(OptimusThemeData theme) => switch (variant) {
        OptimusButtonVariant.defaultButton =>
          theme.isDark ? theme.colors.neutral400 : theme.colors.neutral50,
        OptimusButtonVariant.primary =>
          theme.isDark ? theme.colors.primary700 : theme.colors.primary500,
        OptimusButtonVariant.text => Colors.transparent,
        OptimusButtonVariant.destructive => theme.colors.danger500,
        OptimusButtonVariant.warning => theme.colors.warning500,
      };

  Color _badgeTextColor(OptimusThemeData theme) => switch (variant) {
        OptimusButtonVariant.primary => theme.colors.primary500,
        OptimusButtonVariant.defaultButton ||
        OptimusButtonVariant.text =>
          theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0,
        OptimusButtonVariant.destructive => theme.colors.danger500,
        OptimusButtonVariant.warning => theme.colors.warning500,
      };

  Color _hoverColor(OptimusThemeData theme) => switch (variant) {
        OptimusButtonVariant.defaultButton =>
          theme.isDark ? theme.colors.neutral300 : theme.colors.neutral100,
        OptimusButtonVariant.primary =>
          theme.isDark ? theme.colors.primary400 : theme.colors.primary700,
        OptimusButtonVariant.text => theme.colors.neutral500t8,
        OptimusButtonVariant.destructive => theme.colors.danger700,
        OptimusButtonVariant.warning => theme.colors.warning700,
      };

  Color _highLightColor(OptimusThemeData theme) => switch (variant) {
        OptimusButtonVariant.defaultButton => theme.colors.neutral200,
        OptimusButtonVariant.primary =>
          theme.isDark ? theme.colors.primary500 : theme.colors.primary900,
        OptimusButtonVariant.text => theme.colors.neutral500t16,
        OptimusButtonVariant.destructive => theme.colors.danger900,
        OptimusButtonVariant.warning => theme.colors.warning800,
      };

  Color _textColor(OptimusThemeData theme, Set<MaterialState> states) =>
      switch (variant) {
        OptimusButtonVariant.primary =>
          theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0,
        OptimusButtonVariant.defaultButton ||
        OptimusButtonVariant.text =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500,
        OptimusButtonVariant.destructive => theme.colors.neutral0,
        OptimusButtonVariant.warning =>
          states.isPressed ? theme.colors.neutral0 : theme.colors.neutral900,
      };

  Color _badgeColor(OptimusThemeData theme) => switch (variant) {
        OptimusButtonVariant.primary =>
          theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0,
        OptimusButtonVariant.defaultButton ||
        OptimusButtonVariant.text =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral500,
        OptimusButtonVariant.destructive => theme.colors.neutral0,
        OptimusButtonVariant.warning => theme.colors.neutral900,
      };

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final leftIcon = this.leftIcon;
    final rightIcon = this.rightIcon;
    final badgeLabel = this.badgeLabel;

    return OptimusEnabled(
      isEnabled: onPressed != null,
      child: MaterialButton(
        minWidth: minWidth,
        height: size.value,
        visualDensity: VisualDensity.standard,
        elevation: 0,
        highlightElevation: 0,
        highlightColor: _highLightColor(theme),
        disabledColor: _color(theme),
        disabledTextColor:
            MaterialStateColor.resolveWith((s) => _textColor(theme, s)),
        hoverElevation: 0,
        splashColor: Colors.transparent,
        hoverColor: _hoverColor(theme),
        onPressed: onPressed,
        animationDuration: buttonAnimationDuration,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: _color(theme),
        textColor: MaterialStateColor.resolveWith((s) => _textColor(theme, s)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (leftIcon != null) _buildIcon(leftIcon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacing100),
              child: DefaultTextStyle.merge(child: child, style: _textStyle),
            ),
            if (badgeLabel != null && badgeLabel.isNotEmpty)
              _buildBadgeLabel(badgeLabel, theme),
            if (rightIcon != null) _buildIcon(rightIcon),
          ],
        ),
      ),
    );
  }
}

extension on Set<MaterialState> {
  bool get isPressed => contains(MaterialState.pressed);
}
