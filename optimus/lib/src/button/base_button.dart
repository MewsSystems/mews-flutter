import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/typography/presets.dart';

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
    this.variant = OptimusButtonVariant.primary,
    this.borderRadius = const BorderRadius.all(borderRadius100),
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? minWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? badgeLabel;
  final OptimusWidgetSize size;
  final OptimusButtonVariant variant;
  final BorderRadius borderRadius;

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

  @override
  Widget build(BuildContext context) => TextButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(
            Size(widget.minWidth ?? 0, widget.size.value),
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
                borderRadius: widget.borderRadius,
                side: color != null
                    ? BorderSide(color: color, width: 1)
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
          borderRadius: widget.borderRadius,
          statesController: _statesController,
          badgeLabel: widget.badgeLabel,
          leadingIcon: widget.leadingIcon,
          minWidth: widget.minWidth,
          trailingIcon: widget.trailingIcon,
          child: widget.child,
        ),
      );
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
  final Widget child;
  final double? minWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? badgeLabel;
  final OptimusWidgetSize size;
  final OptimusButtonVariant variant;
  final BorderRadius borderRadius;
  final MaterialStatesController statesController;

  @override
  State<_ButtonContent> createState() => _ButtonContentState();
}

class _ButtonContentState extends State<_ButtonContent> with ThemeGetter {
  TextStyle get _textStyle =>
      widget.size == OptimusWidgetSize.small ? preset200b : preset300b;

  double get _iconSize => switch (widget.size) {
        OptimusWidgetSize.small => 16,
        OptimusWidgetSize.medium || OptimusWidgetSize.large => 24,
      };

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
    final leadingIcon = widget.leadingIcon;
    final trailingIcon = widget.trailingIcon;
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
          if (leadingIcon != null)
            Icon(widget.leadingIcon, size: _iconSize, color: foregroundColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacing100),
            child: DefaultTextStyle.merge(
              style: _textStyle.copyWith(color: foregroundColor),
              child: widget.child,
            ),
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
          if (trailingIcon != null)
            Icon(widget.trailingIcon, size: _iconSize, color: foregroundColor),
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
  Widget build(BuildContext context) => SizedBox(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(borderRadius200),
          child: Container(
            height: 16,
            color: color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.5, vertical: 3),
              child: Text(
                label,
                style: preset50b.copyWith(
                  color: textColor,
                  leadingDistribution: TextLeadingDistribution.proportional,
                ),
              ),
            ),
          ),
        ),
      );
}

extension on Set<MaterialState> {
  bool get isPressed => contains(MaterialState.pressed);
  bool get isHovered => contains(MaterialState.hovered);
  bool get isDisabled => contains(MaterialState.disabled);
}
