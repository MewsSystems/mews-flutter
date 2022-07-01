import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// General input, used to allow users to enter data into the interface.
///
/// Most commonly found in form layouts as one of the most important form
/// elements. Has a strict order of widgets:
/// [leadingWidget] - leading icon or image. Should be non-interactive.
/// [prefix] - styled text, displayed before the user input.
/// <input> - field with the user input.
/// [suffix] - styled text, displayed after the user input.
/// <clearAllButton> - if [isClearEnabled] is true there will be a button for
/// clearing the input.
/// <passwordButton> or [tailingWidget] - tailing image or icon that has some
/// interactive functionality. If [isPasswordField] is true, passwordButton will
/// be used instead of the [tailingWidget].
class OptimusInputField extends StatefulWidget {
  const OptimusInputField({
    Key? key,
    this.onChanged,
    this.placeholder,
    this.placeholderStyle,
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
    this.isClearEnabled = false,
    this.suffix,
    this.prefix,
    this.leadingWidget,
    this.tailingWidget,
    this.tailingWidgetOnTap,
    this.inputKey,
    this.fieldBoxKey,
    this.readOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.size = OptimusWidgetSize.large,
    this.showCursor,
    this.showLoader = false,
    this.inputFormatters,
  }) : super(key: key);

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final TextStyle? placeholderStyle;

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

  /// If true, clear all button is enabled.
  final bool isClearEnabled;

  /// An optional icon/image to display before the text.
  final Widget? leadingWidget;

  /// An optional text to display before the text.
  final Widget? prefix;

  final Key? inputKey;
  final Key? fieldBoxKey;

  /// An optional text to display after the text.
  final Widget? suffix;

  /// An optional icon/image with an attached action [tailingWidgetOnTap].
  final Widget? tailingWidget;
  final VoidCallback? tailingWidgetOnTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final VoidCallback? onTap;

  final TextAlign textAlign;

  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// If true, displays [OptimusCircleLoader] instead of suffix
  final bool showLoader;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  bool get hasError {
    final error = this.error;

    return error != null && error.isNotEmpty;
  }

  @override
  State<OptimusInputField> createState() => _OptimusInputFieldState();
}

class _OptimusInputFieldState extends State<OptimusInputField>
    with ThemeGetter {
  FocusNode? _focusNode;
  bool _isShowPasswordEnabled = false;
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_onFocusChanged);
    _effectiveController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _effectiveController.removeListener(_onTextChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _onClearAllTap() {
    _effectiveController.clear();
    widget.onChanged?.call('');
  }

  bool get _isShowClearAll =>
      widget.isClearEnabled && _effectiveController.text.isNotEmpty;

  Widget get _passwordButton => GestureDetector(
        onTap: () => setState(() {
          _isShowPasswordEnabled = !_isShowPasswordEnabled;
        }),
        child: Icon(
          _isShowPasswordEnabled ? OptimusIcons.hide : OptimusIcons.show,
        ),
      );

  Widget? get _prefix {
    final prefix = widget.prefix;
    final leadingWidget = widget.leadingWidget;

    if (prefix == null && leadingWidget == null) {
      return null;
    }

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingWidget != null) leadingWidget,
        if (prefix != null) prefix,
      ],
    );
  }

  Widget? get _suffix {
    final suffix = widget.suffix;
    final tailingWidget = widget.tailingWidget;

    if (suffix == null && tailingWidget == null && !widget.showLoader) {
      return null;
    }

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (suffix != null) suffix,
        if (_isShowClearAll) _ClearAllButton(onTap: _onClearAllTap),
        if (widget.showLoader) _loader,
        if (widget.isPasswordField)
          _passwordButton
        else if (tailingWidget != null)
          GestureDetector(
            onTap: widget.tailingWidgetOnTap,
            child: tailingWidget,
          )
      ],
    );
  }

  OptimusCircleLoader get _loader => const OptimusCircleLoader(
        size: OptimusCircleLoaderSize.small,
        variant: OptimusCircleLoaderVariant.indeterminate(),
      );

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
        suffix: _suffix,
        prefix: _prefix,
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
              controller: _effectiveController,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              onSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              placeholder: widget.placeholder,
              placeholderStyle:
                  widget.placeholderStyle ?? _placeholderTextStyle,
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
              inputFormatters: widget.inputFormatters,
            ),
          ),
        ],
      );

  void _onFocusChanged() {
    setState(() {});
  }

  void _onTextChanged() {
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

class _ClearAllButton extends StatelessWidget {
  const _ClearAllButton({Key? key, required this.onTap}) : super(key: key);

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        OptimusIcons.clear_selection,
        size: _iconSize,
        color: theme.colors.neutral100,
      ),
    );
  }
}

const double _iconSize = 24;
