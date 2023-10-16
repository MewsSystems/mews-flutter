import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';
import 'package:optimus/src/constants.dart';
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
    widget.focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  bool get _isUsingBottomHint =>
      widget.errorVariant == OptimusInputErrorVariant.bottomHint;

  String get _normalizedError {
    final error = widget.error;

    if (error == null || error.isEmpty) return '';

    return error;
  }

  void _onFocusChanged() => setState(() {});

  bool get _isFocused => widget.isFocused ?? widget.focusNode.hasFocus;

  Color get _background => widget.isEnabled
      ? theme.tokens.backgroundStaticFlat
      : theme.tokens.backgroundDisabled;

  Color get _borderColor {
    if (!widget.isEnabled) return theme.tokens.borderDisabled;
    if (widget.hasError) return theme.tokens.borderAlertDanger;
    if (_isFocused) return theme.tokens.borderInteractiveFocus;
    if (_isHovered) return theme.tokens.borderInteractiveSecondaryHover;

    return theme.tokens.borderInteractiveSecondaryDefault;
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    final helperMessage = widget.helperMessage;
    final caption = widget.caption;
    final prefix = widget.prefix;
    final suffix = widget.suffix;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: widget.size.labelPadding,
          child: Row(
            children: [
              if (label != null)
                OptimusFieldLabel(label: label, isRequired: widget.isRequired),
              const Spacer(),
              if (caption != null)
                _InputCaption(
                  caption: caption,
                  captionIcon: widget.captionIcon,
                ),
            ],
          ),
        ),
        Opacity(
          opacity:
              widget.isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          border: Border.all(color: _borderColor, width: 1),
                        )
                      : null,
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isHovered = true),
                    onExit: (_) => setState(() => _isHovered = false),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.size.contentPadding,
                        ),
                        child: Row(
                          children: [
                            if (prefix != null)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: spacing50),
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
                      style: TextStyle(
                        color: context.tokens.textStaticSecondary,
                      ),
                      child: helperMessage,
                    ),
                  ),
                ),
              if (_isUsingBottomHint && _normalizedError.isNotEmpty)
                Padding(
                  padding: widget.size.errorPadding,
                  child: OptimusFieldError(error: _normalizedError),
                ),
            ],
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
  });

  final Widget caption;
  final IconData? captionIcon;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: spacing50),
            child: OptimusCaption(
              variation: Variation.variationSecondary,
              child: DefaultTextStyle.merge(
                style: TextStyle(color: context.tokens.textStaticSecondary),
                child: caption,
              ),
            ),
          ),
          if (captionIcon != null)
            Icon(
              captionIcon,
              color: OptimusTheme.of(context).tokens.textStaticPrimary,
              size: _captionIconSize,
            ),
        ],
      );
}

class _Icon extends StatelessWidget {
  const _Icon({required this.child, required this.isEnabled});

  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final color =
        isEnabled ? theme.tokens.textStaticPrimary : theme.tokens.textDisabled;

    return IconTheme(data: IconThemeData(color: color, size: 24), child: child);
  }
}

class _Styled extends StatelessWidget {
  const _Styled({required this.child, required this.isEnabled});

  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final color =
        isEnabled ? theme.tokens.textStaticTertiary : theme.tokens.textDisabled;

    return DefaultTextStyle.merge(
      style: preset100s.copyWith(color: color),
      child: _Icon(isEnabled: isEnabled, child: child),
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
}

const _captionIconSize = 16.0;
