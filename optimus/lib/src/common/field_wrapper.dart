import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';

class FieldWrapper extends StatefulWidget {
  const FieldWrapper({
    super.key,
    this.isEnabled = true,
    required this.focusNode,
    this.isFocused,
    this.label,
    this.caption,
    this.captionIcon,
    this.helperMessage,
    this.error,
    this.errorVariant = OptimusInputErrorVariant.bottomHint,
    this.hasBorders = true,
    this.isRequired = false,
    this.suffix,
    this.prefix,
    this.fieldBoxKey,
    this.children = const <Widget>[],
    this.size = OptimusWidgetSize.large,
  });

  final bool isEnabled;
  final FocusNode focusNode;
  final bool? isFocused;
  final String? label;
  final Widget? caption;
  final IconData? captionIcon;
  final Widget? helperMessage;
  final String? error;
  final OptimusInputErrorVariant errorVariant;
  final bool hasBorders;
  final bool isRequired;
  final Widget? suffix;
  final Widget? prefix;
  final List<Widget> children;
  final Key? fieldBoxKey;
  final OptimusWidgetSize size;

  bool get hasError {
    final error = this.error;

    return error != null && error.isNotEmpty;
  }

  @override
  State<FieldWrapper> createState() => _FieldWrapper();
}

class _FieldWrapper extends State<FieldWrapper> with ThemeGetter {
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  bool get _isUsingBottomHint =>
      widget.errorVariant == OptimusInputErrorVariant.bottomHint;

  String get _normalizedError {
    final error = widget.error;

    if (error == null || error.isEmpty) return '';

    return error;
  }

  void _handleFocusChanged() => setState(() {});

  void _handleHoverChanged(bool isHovered) =>
      setState(() => _isHovered = isHovered);

  bool get _isFocused => widget.isFocused ?? widget.focusNode.hasFocus;

  Color? get _background => widget.isEnabled ? null : tokens.backgroundDisabled;

  Color get _borderColor {
    if (!widget.isEnabled) return tokens.borderDisabled;
    if (widget.hasError) return tokens.borderAlertDanger;
    if (_isFocused) return tokens.borderInteractiveFocus;
    if (_isHovered) return tokens.borderInteractiveSecondaryHover;

    return theme.tokens.borderInteractiveSecondaryDefault;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final label = widget.label;
    final helperMessage = widget.helperMessage;
    final caption = widget.caption;
    final prefix = widget.prefix;
    final suffix = widget.suffix;

    final captionColor =
        widget.isEnabled ? tokens.textStaticSecondary : tokens.textDisabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: widget.size.getLabelPadding(tokens),
          child: Row(
            children: [
              if (label != null)
                OptimusFieldLabel(
                  label: label,
                  isRequired: widget.isRequired,
                  isEnabled: widget.isEnabled,
                ),
              const Spacer(),
              if (caption != null)
                _InputCaption(
                  caption: caption,
                  captionIcon: widget.captionIcon,
                  isEnabled: widget.isEnabled,
                ),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: !widget.isEnabled,
          child:
              // Decoration is nullable, cannot use DecoratedBox
              // ignore: use_decorated_box
              Container(
            key: widget.fieldBoxKey,
            decoration: widget.hasBorders
                ? BoxDecoration(
                    color: _background,
                    borderRadius:
                        BorderRadius.circular(context.tokens.borderRadius100),
                    border: Border.all(
                      color: _borderColor,
                      width: context.tokens.borderWidth150,
                    ),
                  )
                : null,
            child: MouseRegion(
              onEnter: (_) => _handleHoverChanged(true),
              onExit: (_) => _handleHoverChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: widget.size.getHeight(tokens),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.size.getContentPadding(tokens),
                  ),
                  child: Row(
                    children: [
                      if (prefix != null)
                        Padding(
                          padding: EdgeInsets.only(right: tokens.spacing50),
                          child: _Styled(
                            isEnabled: widget.isEnabled,
                            child: prefix,
                          ),
                        ),
                      ...widget.children,
                      if (suffix != null)
                        Padding(
                          padding: EdgeInsets.only(left: tokens.spacing50),
                          child: _Styled(
                            isEnabled: widget.isEnabled,
                            child: suffix,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.isEnabled && helperMessage != null)
          Padding(
            padding: widget.size.getHelperPadding(tokens),
            child: OptimusCaption(
              child: DefaultTextStyle.merge(
                style: TextStyle(color: captionColor),
                child: helperMessage,
              ),
            ),
          ),
        if (widget.isEnabled &&
            _isUsingBottomHint &&
            _normalizedError.isNotEmpty)
          Padding(
            padding: widget.size.getErrorPadding(tokens),
            child: OptimusFieldError(
              error: _normalizedError,
              isEnabled: widget.isEnabled,
            ),
          ),
      ],
    );
  }
}

class _InputCaption extends StatelessWidget {
  const _InputCaption({
    required this.caption,
    this.captionIcon,
    this.isEnabled = true,
  });

  final Widget caption;
  final IconData? captionIcon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;
    final iconColor =
        isEnabled ? tokens.textStaticPrimary : tokens.textDisabled;
    final captionColor =
        isEnabled ? tokens.textStaticSecondary : tokens.textDisabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: tokens.spacing50),
          child: OptimusCaption(
            variation: Variation.variationSecondary,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: captionColor),
              child: caption,
            ),
          ),
        ),
        if (captionIcon != null)
          Icon(captionIcon, color: iconColor, size: tokens.sizing200),
      ],
    );
  }
}

class _Styled extends StatelessWidget {
  const _Styled({required this.child, this.isEnabled = true});

  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;
    final textColor =
        isEnabled ? tokens.textStaticTertiary : tokens.textDisabled;
    final iconColor =
        !isEnabled ? tokens.textDisabled : tokens.textStaticPrimary;

    return DefaultTextStyle.merge(
      style: tokens.bodyMedium.copyWith(color: textColor),
      child: IconTheme(
        data: IconThemeData(color: iconColor, size: tokens.sizing200),
        child: child,
      ),
    );
  }
}

extension on OptimusWidgetSize {
  EdgeInsets getLabelPadding(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small ||
        OptimusWidgetSize.medium =>
          EdgeInsets.only(bottom: tokens.spacing50),
        OptimusWidgetSize.large ||
        OptimusWidgetSize.extraLarge =>
          EdgeInsets.only(bottom: tokens.spacing100),
      };
  EdgeInsets getHelperPadding(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small ||
        OptimusWidgetSize.medium =>
          EdgeInsets.only(top: tokens.spacing50),
        OptimusWidgetSize.large ||
        OptimusWidgetSize.extraLarge =>
          EdgeInsets.only(top: tokens.spacing100),
      };
  EdgeInsets getErrorPadding(OptimusTokens tokens) =>
      EdgeInsets.only(top: tokens.spacing50);

  double getContentPadding(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.spacing150,
        OptimusWidgetSize.medium => tokens.spacing200,
        OptimusWidgetSize.large => tokens.spacing250,
        OptimusWidgetSize.extraLarge => tokens.spacing300,
      };

  double getHeight(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.sizing400,
        OptimusWidgetSize.medium => tokens.sizing500,
        OptimusWidgetSize.large => tokens.sizing600,
        OptimusWidgetSize.extraLarge => tokens.sizing700,
      };
}
