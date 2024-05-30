import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/common.dart';

class BaseButton extends StatefulWidget {
  const BaseButton({
    super.key,
    this.onPressed,
    required this.child,
    this.minWidth,
    this.leadingIcon,
    this.trailingIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = BaseButtonVariant.primary,
    this.borderRadius,
    this.padding,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final double? minWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? badgeLabel;
  final OptimusWidgetSize size;
  final BaseButtonVariant variant;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> with ThemeGetter {
  late final MaterialStatesController _statesController =
      MaterialStatesController();

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  EdgeInsets get _padding =>
      widget.padding ??
      EdgeInsets.symmetric(
        vertical: widget.size.getVerticalPadding(tokens),
        horizontal: widget.size.getHorizontalPadding(tokens),
      );

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.borderRadius ?? BorderRadius.all(tokens.borderRadius100);

    return TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(
          Size(widget.minWidth ?? 0, widget.size.getValue(tokens)),
        ),
        maximumSize: MaterialStateProperty.all<Size>(
          Size(double.infinity, widget.size.getValue(tokens)),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          _padding,
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) {
            final color = widget.variant.borderColor(
              tokens,
              isEnabled: !_statesController.value.isDisabled,
              isPressed: _statesController.value.isPressed,
              isHovered: _statesController.value.isHovered,
            );

            return RoundedRectangleBorder(
              borderRadius: borderRadius,
              side: color != null
                  ? BorderSide(color: color, width: tokens.borderWidth150)
                  : BorderSide.none,
            );
          },
        ),
        animationDuration: buttonAnimationDuration,
        elevation: MaterialStateProperty.all<double>(0),
        visualDensity: VisualDensity.standard,
        splashFactory: NoSplash.splashFactory,
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => widget.variant.backgroundColor(
            tokens,
            isEnabled: !_statesController.value.isDisabled,
            isPressed: _statesController.value.isPressed,
            isHovered: _statesController.value.isHovered,
          ),
        ),
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      ),
      statesController: _statesController,
      onPressed: widget.onPressed,
      child: _ButtonContent(
        onPressed: widget.onPressed,
        size: widget.size,
        variant: widget.variant,
        borderRadius: borderRadius,
        statesController: _statesController,
        badgeLabel: widget.badgeLabel,
        leadingIcon: widget.leadingIcon,
        minWidth: widget.minWidth,
        trailingIcon: widget.trailingIcon,
        child: widget.child,
      ),
    );
  }
}

class _ButtonContent extends StatefulWidget {
  const _ButtonContent({
    this.onPressed,
    required this.child,
    required this.size,
    required this.variant,
    required this.borderRadius,
    required this.statesController,
    this.badgeLabel,
    this.leadingIcon,
    this.minWidth,
    this.trailingIcon,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final double? minWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? badgeLabel;
  final OptimusWidgetSize size;
  final BaseButtonVariant variant;
  final BorderRadius borderRadius;
  final MaterialStatesController statesController;

  @override
  State<_ButtonContent> createState() => _ButtonContentState();
}

class _ButtonContentState extends State<_ButtonContent> with ThemeGetter {
  TextStyle get _textStyle => widget.size == OptimusWidgetSize.small
      ? tokens.bodyMediumStrong
      : tokens.bodyLargeStrong;

  double get _iconSize => widget.size == OptimusWidgetSize.small
      ? tokens.sizing200
      : tokens.sizing300;

  @override
  void initState() {
    super.initState();
    widget.statesController.addListener(_onStateUpdate);
  }

  void _onStateUpdate() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    widget.statesController.removeListener(_onStateUpdate);
    super.dispose();
  }

  bool get _isEnabled => !widget.statesController.value.isDisabled;
  bool get _isPressed => widget.statesController.value.isPressed;
  bool get _isHovered => widget.statesController.value.isHovered;

  @override
  Widget build(BuildContext context) {
    final badgeLabel = widget.badgeLabel;

    final foregroundColor = widget.variant.foregroundColor(
      tokens,
      isEnabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    return AnimatedContainer(
      duration: buttonAnimationDuration,
      curve: buttonAnimationCurve,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.leadingIcon case final leadingIcon?)
            Icon(leadingIcon, size: _iconSize, color: foregroundColor),
          if (widget.child case final child?)
            DefaultTextStyle.merge(
              style: _textStyle.copyWith(color: foregroundColor),
              child: child,
            ),
          if (badgeLabel != null && badgeLabel.isNotEmpty)
            _Badge(
              label: badgeLabel,
              color: widget.variant.badgeColor(
                tokens,
                isEnabled: _isEnabled,
                isPressed: _isPressed,
                isHovered: _isHovered,
              ),
              textColor: widget.variant.badgeTextColor(
                tokens,
                isEnabled: _isEnabled,
                isPressed: _isPressed,
                isHovered: _isHovered,
              ),
            ),
          if (widget.trailingIcon case final trailingIcon?)
            Icon(trailingIcon, size: _iconSize, color: foregroundColor),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.color,
    required this.textColor,
    required this.label,
  });

  final Color color;
  final Color textColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return SizedBox(
      height: tokens.sizing200,
      child: ClipRRect(
        borderRadius: BorderRadius.all(tokens.borderRadius200),
        child: ColoredBox(
          color: color,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 3),
            child: Text(
              label,
              style: tokens.bodyExtraSmallStrong.copyWith(
                color: textColor,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on Set<MaterialState> {
  bool get isPressed => contains(MaterialState.pressed);
  bool get isHovered => contains(MaterialState.hovered);
  bool get isDisabled => contains(MaterialState.disabled);
}

extension on OptimusWidgetSize {
  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.spacing50,
        OptimusWidgetSize.medium => tokens.spacing100,
        OptimusWidgetSize.large ||
        OptimusWidgetSize.extraLarge =>
          tokens.spacing150,
      };
  double getHorizontalPadding(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.spacing150,
        OptimusWidgetSize.medium => tokens.spacing200,
        OptimusWidgetSize.large ||
        OptimusWidgetSize.extraLarge =>
          tokens.spacing300,
      };
}
