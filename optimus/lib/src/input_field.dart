import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/field_wrapper.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/typography/presets.dart';

class OptimusInputField extends StatefulWidget {
  const OptimusInputField({
    Key? key,
    this.onChanged,
    this.placeholder,
    this.keyboardType,
    this.isPasswordField = false,
    this.isEnabled = true,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.label,
    this.caption,
    this.secondaryCaption,
    this.maxLines = 1,
    this.minLines,
    this.controller,
    this.error,
    this.enableInteractiveSelection = true,
    this.autofocus = false,
    this.autocorrect = true,
    this.hasBorders = true,
    this.isRequired = false,
    this.suffix,
    this.prefix,
    this.inputKey,
    this.fieldBoxKey,
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.size = OptimusWidgetSize.large,
    this.showCursor,
  }) : super(key: key);

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;
  final String? placeholder;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;
  final bool isPasswordField;
  final bool isEnabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;
  final String? label;
  final Widget? caption;
  final Widget? secondaryCaption;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;
  final TextEditingController? controller;
  final String? error;
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;
  final bool hasBorders;
  final bool isRequired;

  /// An optional [Widget] to display after the text.
  final Widget? suffix;

  /// An optional [Widget] to display before the text.
  final Widget? prefix;
  final Key? inputKey;
  final Key? fieldBoxKey;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final VoidCallback? onTap;

  final TextAlign textAlign;

  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  bool get hasError => error != null && error!.isNotEmpty;

  @override
  _OptimusInputFieldState createState() => _OptimusInputFieldState();
}

class _OptimusInputFieldState extends State<OptimusInputField>
    with ThemeGetter {
  FocusNode? _focusNode;
  bool _isShowPasswordEnabled = false;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FieldWrapper(
        focusNode: _effectiveFocusNode,
        isEnabled: widget.isEnabled,
        label: widget.label,
        caption: widget.caption,
        secondaryCaption: widget.secondaryCaption,
        error: widget.error,
        hasBorders: widget.hasBorders,
        isRequired: widget.isRequired,
        suffix: widget.suffix,
        prefix: widget.prefix,
        fieldBoxKey: widget.fieldBoxKey,
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              key: widget.inputKey,
              textAlign: widget.textAlign,
              cursorColor:
                  theme.isDark ? theme.colors.neutral200 : theme.colors.basic,
              autocorrect: widget.autocorrect,
              autofocus: widget.autofocus,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              controller: widget.controller,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              onSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              placeholder: widget.placeholder,
              placeholderStyle: _placeholderTextStyle,
              focusNode: _effectiveFocusNode,
              enabled: widget.isEnabled,
              padding:
                  widget.prefix != null ? _textWithPrefixPadding : _textPadding,
              style: _textStyle,
              decoration: null,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              obscureText: widget.isPasswordField && !_isShowPasswordEnabled,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              showCursor: widget.showCursor,
            ),
          ),
          if (widget.isPasswordField)
            GestureDetector(
              onTap: () => setState(() {
                _isShowPasswordEnabled = !_isShowPasswordEnabled;
              }),
              child: _SuffixPadding(
                child: Icon(
                  _isShowPasswordEnabled
                      ? OptimusIcons.hide
                      : OptimusIcons.show,
                  size: _iconSize,
                  color: _placeholderTextStyle.color,
                ),
              ),
            ),
        ],
      );

  void _onFocusChanged() {
    setState(() {});
  }

  TextStyle get _textStyle {
    final color = theme.colors.defaultTextColor;
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return preset200s.copyWith(color: color);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300s.copyWith(color: color);
    }
  }

  TextStyle get _placeholderTextStyle {
    final color =
        theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return preset200s.copyWith(color: color);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300s.copyWith(color: color);
    }
  }

  EdgeInsets get _textPadding {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return const EdgeInsets.only(left: 16, right: 8, top: 5, bottom: 6);
      case OptimusWidgetSize.medium:
        return const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8);
      case OptimusWidgetSize.large:
        return const EdgeInsets.only(left: 16, right: 8, top: 12, bottom: 12);
    }
  }

  EdgeInsets get _textWithPrefixPadding {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return const EdgeInsets.only(left: 16, right: 8, top: 5, bottom: 6);
      case OptimusWidgetSize.medium:
        return const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8);
      case OptimusWidgetSize.large:
        return const EdgeInsets.only(left: 10, right: 8, top: 12, bottom: 12);
    }
  }
}

class _SuffixPadding extends StatelessWidget {
  const _SuffixPadding({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: child,
      );
}

const double _iconSize = 24;
