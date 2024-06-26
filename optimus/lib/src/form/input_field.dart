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
    this.captionIcon = OptimusIcons.info,
    this.helperMessage,
    this.maxLines = 1,
    this.minLines,
    this.maxCharacters,
    this.controller,
    this.error,
    this.errorVariant = OptimusInputErrorVariant.bottomHint,
    this.enableInteractiveSelection = true,
    this.autofocus = false,
    this.autocorrect = true,
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
    this.readOnly = false,
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
    this.inline = false,
    this.autoCollapse = false,
    this.statusBarState,
  });

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
  final IconData? captionIcon;
  final Widget? helperMessage;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// The maximum characters for the field. Current character count will be
  /// displayed under the field.
  final int? maxCharacters;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;
  final TextEditingController? controller;
  final String? error;

  /// The way error should be displayed. Will be set to the
  /// [OptimusInputErrorVariant.bottomHint] if not provided.
  final OptimusInputErrorVariant errorVariant;

  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;
  final bool? isFocused;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;
  final bool hasBorders;
  final bool isRequired;

  /// If true, clear all button is enabled.
  final bool isClearEnabled;

  /// An optional icon/image to display before the text.
  final Widget? leading;

  /// An optional text to display before the input.
  final Widget? prefix;

  final Key? inputKey;
  final Key? fieldBoxKey;

  /// An optional text to display after the text.
  final Widget? suffix;

  /// An optional trailing interactive icon/image. If [isPasswordField] is true,
  /// [trailing] will be replaced with a [_PasswordButton].
  final Widget? trailing;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  final VoidCallback? onTap;

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
  final bool inline;

  final bool autoCollapse;

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

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleStateUpdate);
    _effectiveController.addListener(_handleStateUpdate);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleStateUpdate);
    _effectiveController.removeListener(_handleStateUpdate);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  bool get _shouldShowInlineError =>
      (widget.errorVariant == OptimusInputErrorVariant.inlineTooltip ||
          widget.inline) &&
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
      (widget.inline && widget.maxCharacters != null) ||
      widget.showLoader ||
      widget.isPasswordField ||
      _shouldShowClearAllButton ||
      _shouldShowInlineError;

  bool get _shouldShowPrefix => widget.leading != null || widget.prefix != null;

  bool get _isPasswordToggleVisible =>
      widget.isPasswordField && !widget.showLoader;

  void _handleStateUpdate() => setState(() {});

  void _handlePasswordTap() => setState(
        () => _isShowPasswordEnabled = !_isShowPasswordEnabled,
      );

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
      error: widget.error,
      errorVariant: widget.errorVariant,
      hasBorders: widget.hasBorders,
      isRequired: widget.isRequired,
      inline: widget.inline,
      inputCounter: counter,
      statusBarState: widget.statusBarState,
      prefix: _shouldShowPrefix
          ? Prefix(prefix: widget.prefix, leading: widget.leading)
          : null,
      suffix: _shouldShowSuffix
          ? Suffix(
              suffix: widget.suffix,
              trailing: widget.trailing,
              counter: widget.inline ? counter : null,
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
      children: [
        Expanded(
          child: CupertinoTextField(
            key: widget.inputKey,
            textAlign: widget.textAlign,
            enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
            enableSuggestions: widget.enableSuggestions,
            textCapitalization: widget.textCapitalization,
            cursorColor: theme.tokens.textStaticSecondary,
            autocorrect: widget.autocorrect,
            autofocus: widget.autofocus,
            enableInteractiveSelection: widget.enableInteractiveSelection,
            controller: _effectiveController,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            onSubmitted: widget.onSubmitted,
            textInputAction: widget.textInputAction,
            placeholder: widget.placeholder,
            placeholderStyle: widget.placeholderStyle ??
                theme.getPlaceholderStyle(isEnabled: widget.isEnabled),
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
            readOnly: widget.readOnly,
            showCursor: widget.showCursor,
            inputFormatters: widget.inputFormatters,
            keyboardAppearance: widget.keyboardAppearance ?? theme.brightness,
          ),
        ),
      ],
    );
  }
}

class _PasswordButton extends StatelessWidget {
  const _PasswordButton({
    required this.onTap,
    required this.isEnabled,
  });

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
      style: tokens.bodyMedium.copyWith(
        color: color,
      ),
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
