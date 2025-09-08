import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/common.dart';
import 'package:optimus/src/form/form_style.dart';

/// General input, used to allow users to enter data into the interface.
class OptimusInputField extends StatefulWidget {
  const OptimusInputField({
    super.key,
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
    this.captionIcon,
    this.helperMessage,
    this.maxLines = 1,
    this.minLines,
    this.maxCharacters,
    this.controller,
    this.error,
    this.errorVariant = OptimusInputErrorVariant.bottomHint,
    this.enableInteractiveSelection = true,
    this.enableAutoFocus = false,
    this.enableAutoCorrect = true,
    this.hasBorders = true,
    this.isRequired = false,
    this.isFocused,
    this.isClearEnabled = false,
    this.suffix,
    this.prefix,
    this.leading,
    this.trailing,
    this.inputKey,
    this.fieldBoxKey,
    this.isReadOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.size = OptimusWidgetSize.large,
    this.showCursor,
    this.showLoader = false,
    this.inputFormatters,
    this.keyboardAppearance,
    this.enableIMEPersonalizedLearning = true,
    this.enableSuggestions = true,
    this.isInlined = false,
    this.enableAutoCollapse = false,
    this.statusBarState,
    this.semanticsLabel,
  });

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final TextStyle? placeholderStyle;

  /// The semantic label for the input field. If null, the [label] will be used.
  /// If [label] is also null, the [placeholder] will be used. It is recommended
  /// to use a localized string for better accessibility.
  final String? semanticsLabel;

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
  final IconData? captionIcon;
  final Widget? helperMessage;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// The maximum characters for the field. Current character count will be
  /// displayed under the field.
  final int? maxCharacters;

  /// {@macro flutter.widgets.editableText.minLines}
  ///
  /// If the input is multi-lined we recommend you to set the [keyboardType] to
  /// [TextInputType.multiline] otherwise the move to the next line won't work
  /// properly.
  final int? minLines;
  final TextEditingController? controller;
  final String? error;

  /// The way error should be displayed. Will be set to the
  /// [OptimusInputErrorVariant.bottomHint] if not provided.
  final OptimusInputErrorVariant errorVariant;

  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool enableAutoFocus;
  final bool? isFocused;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool enableAutoCorrect;
  final bool hasBorders;
  final bool isRequired;

  /// If true, clear all button is enabled.
  final bool isClearEnabled;

  /// An optional icon/image to display before the text.
  final Widget? leading;

  /// An optional text to display before the input.
  final Widget? prefix;

  /// The [Key] for the input field.
  final Key? inputKey;

  /// The [Key] for the field box.
  final Key? fieldBoxKey;

  /// An optional text to display after the text.
  final Widget? suffix;

  /// An optional trailing interactive icon/image. If [isPasswordField] is true,
  /// [trailing] will be replaced with a [_PasswordButton].
  final Widget? trailing;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool isReadOnly;

  /// The callback to be called when the field is tapped.
  final VoidCallback? onTap;

  /// The horizontal alignment of the text.
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// If true, displays [OptimusSpinner].
  final bool showLoader;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@template optimus.input.keyboardAppearance}
  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If null, defaults to the brightness provided by [OptimusTheme].
  /// {@endtemplate}
  final Brightness? keyboardAppearance;

  /// {@macro flutter.services.TextInputConfiguration.enableIMEPersonalizedLearning}
  final bool enableIMEPersonalizedLearning;

  /// {@macro flutter.services.TextInputConfiguration.enableSuggestions}
  final bool enableSuggestions;

  /// Controls whether the components should be inside the input field or
  /// outside, wrapping it. The inline variant is more dense and is smaller in
  /// the vertical direction.
  final bool isInlined;

  /// Controls whether the input should collapse to one line height if not
  /// focused.
  final bool enableAutoCollapse;

  final OptimusStatusBarState? statusBarState;

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
  late int? _minLines = widget.minLines;
  late int _maxLines = widget.maxLines;

  FocusNode get _effectiveFocusNode {
    if (widget.focusNode case final focusNode?) return focusNode;

    return _focusNode ??= FocusNode();
  }

  TextEditingController get _effectiveController {
    if (widget.controller case final controller?) return controller;

    return _controller ??= TextEditingController();
  }

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusUpdate);
    _effectiveController.addListener(_handleStateUpdate);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusUpdate);
    _effectiveController.removeListener(_handleStateUpdate);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enableAutoCollapse != oldWidget.enableAutoCollapse ||
        widget.minLines != oldWidget.minLines ||
        widget.maxLines != oldWidget.maxLines) {
      _updateLines();
    }
  }

  bool get _shouldShowInlineError =>
      (widget.errorVariant == OptimusInputErrorVariant.inlineTooltip ||
          widget.isInlined) &&
      widget.hasError;

  void _handleClearAllTap() {
    _effectiveController.clear();
    widget.onChanged?.call('');
  }

  bool get _shouldShowClearAllButton =>
      widget.isClearEnabled && _effectiveController.text.isNotEmpty;

  bool get _shouldShowSuffix =>
      widget.suffix != null ||
      widget.trailing != null ||
      (widget.isInlined && widget.maxCharacters != null) ||
      widget.showLoader ||
      widget.isPasswordField ||
      _shouldShowClearAllButton ||
      _shouldShowInlineError;

  bool get _shouldShowPrefix => widget.leading != null || widget.prefix != null;

  bool get _isPasswordToggleVisible =>
      widget.isPasswordField && !widget.showLoader;

  bool get _shouldCollapse =>
      widget.enableAutoCollapse && !_effectiveFocusNode.hasFocus;

  void _handleFocusUpdate() => setState(() {
    if (!widget.enableAutoCollapse) return;
    _updateLines();
  });

  void _updateLines() {
    _maxLines = _shouldCollapse ? 1 : widget.maxLines;
    _minLines = _shouldCollapse ? 1 : widget.minLines;
  }

  void _handleStateUpdate() => setState(() {});

  void _handlePasswordTap() =>
      setState(() => _isShowPasswordEnabled = !_isShowPasswordEnabled);

  Widget? get _placeholder {
    final placeholder = widget.placeholder;
    if (placeholder != null &&
        _effectiveController.text.isEmpty &&
        !_effectiveFocusNode.hasFocus) {
      return GestureDetector(
        onTap: _effectiveFocusNode.requestFocus,
        child: Text(
          placeholder,
          overflow: TextOverflow.ellipsis,
          maxLines: widget.maxLines,
          style:
              widget.placeholderStyle ??
              theme.getTextInputStyle(isEnabled: widget.isEnabled),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final error = widget.error;
    final maxCharacters = widget.maxCharacters;
    final counter = maxCharacters != null
        ? _CharacterCounter(
            current: _effectiveController.text.length,
            max: maxCharacters,
            isEnabled: widget.isEnabled,
          )
        : null;

    return FieldWrapper(
      focusNode: _effectiveFocusNode,
      isFocused: widget.isFocused,
      isEnabled: widget.isEnabled,
      label: widget.label,
      caption: widget.caption,
      captionIcon: widget.captionIcon,
      helperMessage: widget.helperMessage,
      error: error,
      errorVariant: widget.errorVariant,
      hasBorders: widget.hasBorders,
      isRequired: widget.isRequired,
      isInlined: widget.isInlined,
      hasMultipleLines: widget.minLines != null,
      inputCounter: widget.isInlined ? null : counter,
      statusBarState: widget.statusBarState,
      prefix: _shouldShowPrefix
          ? Prefix(prefix: widget.prefix, leading: widget.leading)
          : null,
      suffix: _shouldShowSuffix
          ? Suffix(
              suffix: widget.suffix,
              trailing: widget.trailing,
              counter: widget.isInlined ? counter : null,
              passwordButton: _isPasswordToggleVisible
                  ? _PasswordButton(
                      onTap: _handlePasswordTap,
                      isEnabled: _isShowPasswordEnabled,
                    )
                  : null,
              showLoader: widget.isEnabled ? widget.showLoader : false,
              clearAllButton: _shouldShowClearAllButton
                  ? _ClearAllButton(
                      onTap: _handleClearAllTap,
                      isEnabled: widget.isEnabled,
                    )
                  : null,
              inlineError: _shouldShowInlineError && error != null
                  ? InlineErrorTooltip(error: error)
                  : null,
            )
          : null,
      fieldBoxKey: widget.fieldBoxKey,
      size: widget.size,
      placeholder: _placeholder,
      // TODO(witwash): rework when https://github.com/flutter/flutter/issues/138794 is fixed
      children: [
        CupertinoTextField(
          key: widget.inputKey,
          textAlign: widget.textAlign,
          enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
          enableSuggestions: widget.enableSuggestions,
          textCapitalization: widget.textCapitalization,
          cursorColor: theme.tokens.textStaticSecondary,
          autocorrect: widget.enableAutoCorrect,
          autofocus: widget.enableAutoFocus,
          enableInteractiveSelection: widget.enableInteractiveSelection,
          controller: _effectiveController,
          maxLines: _maxLines,
          minLines: _minLines,
          onSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          focusNode: _effectiveFocusNode,
          enabled: widget.isEnabled,
          padding: EdgeInsets.zero,
          style: theme.getTextInputStyle(isEnabled: widget.isEnabled),
          // [CupertinoTextField] will try to resolve colors to its own theme,
          // this will ensure the visible [BoxDecoration] is from the
          // [FieldWrapper] above.
          decoration: const BoxDecoration(
            color: Color(0x00000000),
            backgroundBlendMode: BlendMode.dst,
          ),
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPasswordField && !_isShowPasswordEnabled,
          onTap: widget.onTap,
          readOnly: widget.isReadOnly,
          showCursor: widget.showCursor,
          inputFormatters: widget.inputFormatters,
          keyboardAppearance: widget.keyboardAppearance ?? theme.brightness,
        ),
      ],
    );
  }
}

class _PasswordButton extends StatelessWidget {
  const _PasswordButton({required this.onTap, required this.isEnabled});

  final VoidCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Icon(isEnabled ? OptimusIcons.hide : OptimusIcons.show),
  );
}

class _ClearAllButton extends StatelessWidget {
  const _ClearAllButton({required this.onTap, required this.isEnabled});

  final GestureTapCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Icon(
      OptimusIcons.cross_close,
      size: context.tokens.sizing200,
      color: isEnabled
          ? context.tokens.textStaticPrimary
          : context.tokens.textDisabled,
    ),
  );
}

class _CharacterCounter extends StatelessWidget {
  const _CharacterCounter({
    required this.current,
    required this.max,
    this.isEnabled = true,
  });

  final int current;
  final int max;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final color = isEnabled
        ? max < current
              ? tokens.textAlertDanger
              : tokens.textStaticSecondary
        : tokens.textDisabled;

    final child = Text(
      '$current/$max',
      style: tokens.bodyMedium.copyWith(color: color),
    );

    return current > max
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: tokens.spacing200,
                  right: tokens.spacing25,
                ),
                child: const OptimusIcon(
                  iconData: OptimusIcons.error_circle,
                  iconSize: OptimusIconSize.small,
                  colorOption: OptimusIconColorOption.danger,
                ),
              ),
              child,
            ],
          )
        : child;
  }
}
