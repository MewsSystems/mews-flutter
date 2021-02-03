import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/field_wrapper.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusInputField extends StatefulWidget {
  const OptimusInputField({
    Key key,
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
  }) : super(key: key);

  final ValueChanged<String> onChanged;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPasswordField;
  final bool isEnabled;
  final TextInputAction textInputAction;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final String label;
  final Widget caption;
  final Widget secondaryCaption;
  final int maxLines;
  final int minLines;
  final TextEditingController controller;
  final String error;
  final bool enableInteractiveSelection;
  final bool autofocus;
  final bool autocorrect;
  final bool hasBorders;
  final bool isRequired;
  final Widget suffix;
  final Widget prefix;
  final Key inputKey;
  final Key fieldBoxKey;
  final bool readOnly;
  final VoidCallback onTap;
  final TextAlign textAlign;
  final OptimusWidgetSize size;

  bool get hasError => error != null && error.isNotEmpty;

  @override
  _OptimusInputFieldState createState() => _OptimusInputFieldState();
}

class _OptimusInputFieldState extends State<OptimusInputField> {
  FocusNode _focusNode;
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
              cursorColor: OptimusColors.basic,
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

  // ignore: missing_return
  TextStyle get _textStyle {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return preset200m.copyWith(color: OptimusColors.basic900);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300m.copyWith(color: OptimusColors.basic900);
    }
  }

  // ignore: missing_return
  TextStyle get _placeholderTextStyle {
    switch (widget.size) {
      case OptimusWidgetSize.small:
        return preset200m.copyWith(color: OptimusColors.basic900t64);
      case OptimusWidgetSize.medium:
      case OptimusWidgetSize.large:
        return preset300m.copyWith(color: OptimusColors.basic900t64);
    }
  }

  // ignore: missing_return
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

  // ignore: missing_return
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
  const _SuffixPadding({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 10),
        child: child,
      );
}

const double _iconSize = 24;
