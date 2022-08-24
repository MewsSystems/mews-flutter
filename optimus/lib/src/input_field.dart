import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// General input, used to allow users to enter data into the interface.
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

  /// If true, displays [OptimusCircleLoader].
  final bool showLoader;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If null, defaults to the brightness provided by [OptimusTheme].
  final Brightness? keyboardAppearance;

  bool get hasError {
    final error = this.error;

    return error != null && error.isNotEmpty;
  }

  @override
  State<OptimusInputField> createState() => _OptimusInputFieldState();
}

class _OptimusInputFieldState extends State<OptimusInputField> with ThemeGetter {
  FocusNode? _focusNode;
  bool _isShowPasswordEnabled = false;
  TextEditingController? _controller;

  TextEditingController get _effectiveController => widget.controller ?? (_controller ??= TextEditingController());

  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_onStateUpdate);
    _effectiveController.addListener(_onStateUpdate);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onStateUpdate);
    _effectiveController.removeListener(_onStateUpdate);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Widget? get _passwordButton {
    if (widget.isPasswordField) {
      return _PasswordButton(
        onTap: () => setState(() {
          _isShowPasswordEnabled = !_isShowPasswordEnabled;
        }),
        isShowPasswordEnabled: _isShowPasswordEnabled,
      );
    }
  }

  Widget? get _clearAllButton {
    if (_shouldShowClearAllButton) {
      return _ClearAllButton(onTap: _onClearAllTap);
    }
  }

  Widget? get _prefix {
    if (widget.leading != null || widget.prefix != null) {
      return _Prefix(prefix: widget.prefix, leading: widget.leading);
    }
  }

  Widget? get _suffix {
    if (widget.suffix != null || widget.trailing != null || widget.showLoader || _shouldShowClearAllButton) {
      return _Suffix(
        suffix: widget.suffix,
        trailing: widget.trailing,
        passwordButton: _passwordButton,
        showLoader: widget.showLoader,
        clearAllButton: _clearAllButton,
      );
    }
  }

  void _onClearAllTap() {
    _effectiveController.clear();
    widget.onChanged?.call('');
  }

  bool get _shouldShowClearAllButton => widget.isClearEnabled && _effectiveController.text.isNotEmpty;

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
        prefix: _prefix,
        suffix: _suffix,
        fieldBoxKey: widget.fieldBoxKey,
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              key: widget.inputKey,
              textAlign: widget.textAlign,
              textCapitalization: widget.textCapitalization,
              cursorColor: theme.isDark ? theme.colors.neutral200 : theme.colors.basic,
              autocorrect: widget.autocorrect,
              autofocus: widget.autofocus,
              enableInteractiveSelection: widget.enableInteractiveSelection,
              controller: _effectiveController,
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              onSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              placeholder: widget.placeholder,
              placeholderStyle: widget.placeholderStyle ?? _placeholderTextStyle,
              focusNode: _effectiveFocusNode,
              enabled: widget.isEnabled,
              padding: _prefix != null ? _textWithPrefixPadding : _textPadding,
              style: _textStyle,
              decoration: null,
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

  void _onStateUpdate() {
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
    final color = theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;
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

class _Suffix extends StatelessWidget {
  const _Suffix({
    Key? key,
    this.suffix,
    this.passwordButton,
    this.trailing,
    required this.clearAllButton,
    required this.showLoader,
  }) : super(key: key);

  final Widget? suffix;
  final Widget? passwordButton;
  final Widget? trailing;
  final Widget? clearAllButton;
  final bool showLoader;

  OptimusCircleLoader get _loader => const OptimusCircleLoader(
        size: OptimusCircleLoaderSize.small,
        variant: OptimusCircleLoaderVariant.indeterminate(),
      );

  @override
  Widget build(BuildContext context) {
    final suffixWidget = suffix;
    final clearAllButtonWidget = clearAllButton;
    final passwordButtonWidget = passwordButton;
    final trailingWidget = trailing;

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (suffixWidget != null) suffixWidget,
        if (showLoader) _loader,
        if (clearAllButtonWidget != null) clearAllButtonWidget,
        if (passwordButtonWidget != null) passwordButtonWidget else if (trailingWidget != null) trailingWidget
      ],
    );
  }
}

class _Prefix extends StatelessWidget {
  const _Prefix({Key? key, this.prefix, this.leading}) : super(key: key);

  final Widget? prefix;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        mainAxisSize: MainAxisSize.min,
        children: [
          leading ?? const SizedBox.shrink(),
          prefix ?? const SizedBox.shrink(),
        ],
      );
}

class _PasswordButton extends StatelessWidget {
  const _PasswordButton({
    Key? key,
    required this.onTap,
    required this.isShowPasswordEnabled,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isShowPasswordEnabled;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Icon(
          isShowPasswordEnabled ? OptimusIcons.hide : OptimusIcons.show,
        ),
      );
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
