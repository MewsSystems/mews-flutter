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
    this.inputCounter,
    this.inline = false,
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
  final Widget? inputCounter;
  final bool inline;

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

  bool get _hasHeader =>
      (widget.label != null || widget.caption != null) && !widget.inline;

  bool get _hasFooter =>
      widget.isEnabled &&
      !widget.inline &&
      (widget.helperMessage != null ||
          widget.inputCounter != null ||
          _normalizedError.isNotEmpty);

  Color? get _background => widget.isEnabled ? null : tokens.backgroundDisabled;

  bool get _hasFooterError => _normalizedError.isNotEmpty && _isUsingBottomHint;

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
    final prefix = widget.prefix;
    final suffix = widget.suffix;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_hasHeader)
          _InputHeader(
            size: widget.size,
            label: widget.label,
            isRequired: widget.isRequired,
            isEnabled: widget.isEnabled,
            caption: widget.caption,
            captionIcon: widget.captionIcon,
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
                    borderRadius: BorderRadius.circular(tokens.borderRadius100),
                    border: Border.all(
                      color: _borderColor,
                      width: tokens.borderWidth150,
                    ),
                  )
                : null,
            child: MouseRegion(
              onEnter: (_) => _handleHoverChanged(true),
              onExit: (_) => _handleHoverChanged(false),
              child: AnimatedContainer(
                duration: _kAnimationDuration,
                constraints:
                    BoxConstraints(minHeight: widget.size.getHeight(tokens)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.size.getContentPadding(tokens),
                  ),
                  child: Row(
                    children: [
                      if (prefix != null)
                        Padding(
                          padding: EdgeInsets.only(right: tokens.spacing100),
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
        if (_hasFooter)
          _InputFooter(
            size: widget.size,
            isEnabled: widget.isEnabled,
            inputCounter: widget.inputCounter,
            helperMessage: widget.helperMessage,
            error: _hasFooterError
                ? _InputError(
                    error: _normalizedError,
                    isEnabled: widget.isEnabled,
                    size: widget.size,
                  )
                : null,
          ),
      ],
    );
  }
}

class _InputHeader extends StatelessWidget {
  const _InputHeader({
    required this.size,
    this.label,
    required this.isRequired,
    required this.isEnabled,
    this.caption,
    this.captionIcon,
  });

  final OptimusWidgetSize size;
  final String? label;
  final bool isRequired;
  final bool isEnabled;
  final Widget? caption;
  final IconData? captionIcon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: size.getLabelPadding(tokens),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (label case final label?)
            Flexible(
              child: OptimusFieldLabel(
                label: label,
                isRequired: isRequired,
                isEnabled: isEnabled,
              ),
            ),
          if (caption case final caption?)
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: tokens.spacing100),
                child: _InputCaption(
                  caption: caption,
                  captionIcon: captionIcon,
                  isEnabled: isEnabled,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InputError extends StatelessWidget {
  const _InputError({
    required this.error,
    required this.isEnabled,
    required this.size,
  });

  final String error;
  final bool isEnabled;
  final OptimusWidgetSize size;

  @override
  Widget build(BuildContext context) => Padding(
        padding: size.getErrorPadding(context.tokens),
        child: OptimusFieldError(error: error, isEnabled: isEnabled),
      );
}

class _InputFooter extends StatelessWidget {
  const _InputFooter({
    this.inputCounter,
    this.error,
    this.helperMessage,
    required this.size,
    this.isEnabled = true,
  });

  final Widget? inputCounter;
  final Widget? error;
  final Widget? helperMessage;
  final OptimusWidgetSize size;
  final bool isEnabled;

  bool get _hasMessage => helperMessage != null || error != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final leading = _hasMessage
        ? Expanded(
            child: _FooterMessage(
              helperMessage: helperMessage,
              errorMessage: error,
              isEnabled: isEnabled,
            ),
          )
        : const Spacer();

    return Padding(
      padding: size.getHelperPadding(tokens),
      child: Row(
        children: [
          leading,
          if (inputCounter case final inputCounter?) inputCounter,
        ],
      ),
    );
  }
}

class _FooterMessage extends StatelessWidget {
  const _FooterMessage({
    this.helperMessage,
    this.errorMessage,
    this.isEnabled = true,
  });

  final Widget? helperMessage;
  final Widget? errorMessage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (helperMessage case final helperMessage?)
            _HelperMessage(
              helperMessage: helperMessage,
              isEnabled: isEnabled,
            ),
          if (errorMessage case final errorMessage?) errorMessage,
        ],
      );
}

class _HelperMessage extends StatelessWidget {
  const _HelperMessage({required this.helperMessage, this.isEnabled = true});

  final Widget helperMessage;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final captionColor =
        isEnabled ? tokens.textStaticSecondary : tokens.textDisabled;

    return OptimusCaption(
      child: DefaultTextStyle.merge(
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: TextStyle(color: captionColor),
        child: helperMessage,
      ),
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: tokens.spacing50),
            child: OptimusCaption(
              variation: Variation.variationSecondary,
              child: DefaultTextStyle.merge(
                style: TextStyle(color: captionColor),
                textAlign: TextAlign.end,
                child: caption,
              ),
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
        OptimusWidgetSize.extraLarge =>
          tokens.spacing300, // TODO(witwash): check with design
      };

  double getHeight(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.sizing400,
        OptimusWidgetSize.medium => tokens.sizing500,
        OptimusWidgetSize.large => tokens.sizing600,
        OptimusWidgetSize.extraLarge => tokens.sizing700,
      };
}

const _kAnimationDuration = Duration(milliseconds: 200);
