import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/button/base_button_variant.dart';
import 'package:optimus/src/button/common.dart';
import 'package:optimus/src/common/semantics.dart';

typedef ShapeBuilder =
    OutlinedBorder Function(BorderRadius borderRadius, BorderSide borderSide);

class BaseButton extends StatefulWidget {
  const BaseButton({
    super.key,
    this.onPressed,
    required this.child,
    this.isLoading = false,
    this.minWidth,
    this.leadingIcon,
    this.trailingIcon,
    this.badgeLabel,
    this.size = OptimusWidgetSize.large,
    this.variant = BaseButtonVariant.primary,
    this.borderRadius,
    this.padding,
    this.shapeBuilder,
    this.semanticLabel,
  });

  final VoidCallback? onPressed;
  final Widget? child;
  final bool isLoading;
  final double? minWidth;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? badgeLabel;
  final OptimusWidgetSize size;
  final BaseButtonVariant variant;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final ShapeBuilder? shapeBuilder;
  final String? semanticLabel;

  @override
  State<BaseButton> createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> with ThemeGetter {
  late final WidgetStatesController _statesController =
      WidgetStatesController();

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

    return IgnorePointer(
      ignoring: widget.isLoading,
      child: Semantics(
        label: widget.semanticLabel,
        child: TextButton(
          style: ButtonStyle(
            minimumSize: WidgetStateProperty.all<Size>(
              Size(widget.minWidth ?? 0, 0),
            ),
            padding: WidgetStateProperty.all<EdgeInsets>(_padding),
            shape: WidgetStateProperty.resolveWith((states) {
              final color = widget.variant.getBorderColor(
                tokens,
                isEnabled: !_statesController.value.isDisabled,
                isPressed: _statesController.value.isPressed,
                isHovered: _statesController.value.isHovered,
              );
              final side =
                  color != null
                      ? BorderSide(color: color, width: tokens.borderWidth150)
                      : BorderSide.none;

              return widget.shapeBuilder?.let(
                    (builder) => builder(borderRadius, side),
                  ) ??
                  RoundedRectangleBorder(
                    borderRadius: borderRadius,
                    side: side,
                  );
            }),
            animationDuration: buttonAnimationDuration,
            elevation: WidgetStateProperty.all<double>(0),
            visualDensity: VisualDensity.standard,
            splashFactory: NoSplash.splashFactory,
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => widget.variant.getBackgroundColor(
                tokens,
                isEnabled: !_statesController.value.isDisabled,
                isPressed: _statesController.value.isPressed,
                isHovered: _statesController.value.isHovered,
              ),
            ),
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
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
            isLoading: widget.isLoading,
            child: widget.child,
          ),
        ),
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
    this.isLoading = false,
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
  final WidgetStatesController statesController;
  final bool isLoading;

  @override
  State<_ButtonContent> createState() => _ButtonContentState();
}

class _ButtonContentState extends State<_ButtonContent> with ThemeGetter {
  TextStyle get _textStyle =>
      widget.size == OptimusWidgetSize.small
          ? tokens.bodyMediumStrong
          : tokens.bodyLargeStrong;

  double get _iconSize =>
      widget.size == OptimusWidgetSize.small
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
    final insideHorizontalPadding = widget.size.getInsideHorizontalPadding(
      tokens,
    );

    final foregroundColor = widget.variant.getForegroundColor(
      tokens,
      isEnabled: _isEnabled,
      isPressed: _isPressed,
      isHovered: _isHovered,
    );

    return _LoaderStack(
      isLoading: _isEnabled && widget.isLoading,
      loaderWidget: _SpinningIcon(color: foregroundColor),
      child: AnimatedContainer(
        duration: buttonAnimationDuration,
        curve: buttonAnimationCurve,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (widget.leadingIcon case final leadingIcon?)
              Padding(
                padding:
                    widget.child != null
                        ? EdgeInsets.only(right: insideHorizontalPadding)
                        : EdgeInsets.zero,
                child: Icon(
                  leadingIcon,
                  size: _iconSize,
                  color: foregroundColor,
                ),
              ).excludeSemantics(),
            if (widget.child case final child?)
              IconTheme.merge(
                data: IconThemeData(color: foregroundColor, size: _iconSize),
                child: DefaultTextStyle.merge(
                  style: _textStyle.copyWith(color: foregroundColor),
                  child: child,
                ),
              ),
            if (badgeLabel != null && badgeLabel.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: insideHorizontalPadding),
                child: _Badge(
                  label: badgeLabel,
                  color: widget.variant.getBadgeColor(
                    tokens,
                    isEnabled: _isEnabled,
                    isPressed: _isPressed,
                    isHovered: _isHovered,
                  ),
                  textColor: widget.variant.getBadgeTextColor(
                    tokens,
                    isEnabled: _isEnabled,
                    isPressed: _isPressed,
                    isHovered: _isHovered,
                  ),
                ),
              ),
            if (widget.trailingIcon case final trailingIcon?)
              Padding(
                padding: EdgeInsets.only(left: insideHorizontalPadding),
                child: Icon(
                  trailingIcon,
                  size: _iconSize,
                  color: foregroundColor,
                ),
              ).excludeSemantics(),
          ],
        ),
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
            padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding,
              vertical: _verticalPadding,
            ), // TODO(witwash): check with design
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

class _LoaderStack extends StatelessWidget {
  const _LoaderStack({
    required this.isLoading,
    required this.loaderWidget,
    this.child,
  });

  final bool isLoading;
  final Widget loaderWidget;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      if (child case final child?)
        Opacity(opacity: isLoading ? 0 : 1, child: child),
      if (isLoading) loaderWidget,
    ],
  );
}

class _SpinningIcon extends StatefulWidget {
  const _SpinningIcon({required this.color});

  final Color color;

  @override
  State<_SpinningIcon> createState() => _SpinningIconState();
}

class _SpinningIconState extends State<_SpinningIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _turns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    _turns = _controller.drive(Tween(begin: 0, end: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RotationTransition(
    turns: _turns,
    child: Icon(
      OptimusIcons.spinner,
      size: context.tokens.sizing200,
      color: widget.color,
    ),
  );
}

extension on Set<WidgetState> {
  bool get isPressed => contains(WidgetState.pressed);
  bool get isHovered => contains(WidgetState.hovered);
  bool get isDisabled => contains(WidgetState.disabled);
}

const _verticalPadding = 3.0;
const _horizontalPadding = 4.5;
