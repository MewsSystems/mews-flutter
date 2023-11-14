import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';
import 'package:optimus/src/typography/presets.dart';

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
          padding: widget.size.labelPadding,
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
                    borderRadius: const BorderRadius.all(borderRadius100),
                    border: Border.all(color: _borderColor, width: 1.5),
                  )
                : null,
            child: MouseRegion(
              onEnter: (_) => _handleHoverChanged(true),
              onExit: (_) => _handleHoverChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: widget.size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.size.contentPadding,
                  ),
                  child: Row(
                    children: [
                      if (prefix != null)
                        Padding(
                          padding: const EdgeInsets.only(right: spacing50),
                          child: _Styled(
                            isEnabled: widget.isEnabled,
                            child: prefix,
                          ),
                        ),
                      ...widget.children,
                      if (suffix != null)
                        Padding(
                          padding: const EdgeInsets.only(left: spacing50),
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
        if (helperMessage != null)
          Padding(
            padding: widget.size.helperPadding,
            child: OptimusCaption(
              child: DefaultTextStyle.merge(
                style: TextStyle(color: captionColor),
                child: helperMessage,
              ),
            ),
          ),
        if (_isUsingBottomHint && _normalizedError.isNotEmpty)
          Padding(
            padding: widget.size.errorPadding,
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
          padding: const EdgeInsets.symmetric(horizontal: spacing50),
          child: OptimusCaption(
            variation: Variation.variationSecondary,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: captionColor),
              child: caption,
            ),
          ),
        ),
        if (captionIcon != null)
          Icon(captionIcon, color: iconColor, size: _captionIconSize),
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
      style: preset200r.copyWith(color: textColor),
      child: IconTheme(
        data: IconThemeData(color: iconColor, size: _iconSize),
        child: child,
      ),
    );
  }
}

extension on OptimusWidgetSize {
  EdgeInsets get labelPadding => switch (this) {
        OptimusWidgetSize.small ||
        OptimusWidgetSize.medium =>
          const EdgeInsets.only(bottom: spacing50),
        OptimusWidgetSize.large => const EdgeInsets.only(bottom: spacing100),
      };
  EdgeInsets get helperPadding => switch (this) {
        OptimusWidgetSize.small ||
        OptimusWidgetSize.medium =>
          const EdgeInsets.only(top: spacing50),
        OptimusWidgetSize.large => const EdgeInsets.only(top: spacing100),
      };
  EdgeInsets get errorPadding => const EdgeInsets.only(top: spacing50);

  double get contentPadding => switch (this) {
        OptimusWidgetSize.small => spacing150,
        OptimusWidgetSize.medium => spacing200,
        OptimusWidgetSize.large => spacing250,
      };

  double get height => switch (this) {
        OptimusWidgetSize.small => spacing400,
        OptimusWidgetSize.medium => spacing500,
        OptimusWidgetSize.large => spacing600,
      };
}

const _captionIconSize = 16.0;
const _iconSize = 16.0;
