import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

/// The password form field. It is a wrapper around [OptimusInputFormField] with
/// a lock icon and password visibility toggle.
class OptimusPasswordFormField extends StatelessWidget {
  const OptimusPasswordFormField({
    super.key,
    this.initialValue,
    this.controller,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.placeholder,
    this.keyboardType,
    this.isEnabled = true,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.label,
    this.maxLines = 1,
    this.minLines,
    this.maxCharacters,
    this.enableInteractiveSelection = true,
    this.autofocus = false,
    this.hasBorders = true,
    this.isRequired = false,
    this.inputKey,
    this.readOnly = false,
    this.showCursor,
    this.showLoader = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.helperMessage,
    this.caption,
    this.keyboardAppearance,
    this.statusBarState,
    this.size = OptimusWidgetSize.large,
    this.isClearEnabled = false,
  });

  /// The initial value of the form field.
  final String? initialValue;

  /// The optional controller of the form field.
  final TextEditingController? controller;

  /// The optional callback that is called when the form field is saved.
  final FormFieldSetter<String>? onSaved;

  /// The optional validator that is called when the form field is validated.
  final FormFieldValidator<String>? validator;

  /// The autovalidate mode of the form field.
  final AutovalidateMode? autovalidateMode;

  /// The placeholder of the form field.
  final String? placeholder;

  /// The keyboard type of the form field.
  final TextInputType? keyboardType;

  /// Whether the form field is enabled. Defaults to true.
  final bool isEnabled;

  /// The text input action of the form field.
  final TextInputAction? textInputAction;

  /// The callback that is called when the form field is submitted.
  final ValueChanged<String>? onSubmitted;

  /// The optional focus node of the form field.
  final FocusNode? focusNode;

  /// The label of the form field.
  final String? label;

  /// The maximum number of lines of the form field. Defaults to 1.
  final int maxLines;

  /// The minimum number of lines of the form field.
  final int? minLines;

  /// The maximum number of characters of the form field.
  final int? maxCharacters;

  /// Whether the form field has interactive selection. Defaults to true.
  final bool enableInteractiveSelection;

  /// Whether the form field has to be autofocused. Defaults to false.
  final bool autofocus;

  /// Whether the form field has borders. Defaults to true.
  final bool hasBorders;

  /// Whether the form field is required. Defaults to false.
  final bool isRequired;

  /// The key of the form field.
  final Key? inputKey;

  /// Whether the form field is read-only. Defaults to false.
  final bool readOnly;

  /// Whether the cursor is shown.
  final bool? showCursor;

  /// Whether the loader is shown.
  final bool showLoader;

  /// The callback that is called when the form field is tapped.
  final VoidCallback? onTap;

  /// The text alignment of the form field.
  final TextAlign textAlign;

  /// The text capitalization of the form field.
  final Widget? caption;

  /// The helper message of the form field.
  final Widget? helperMessage;

  /// The keyboard appearance of the form field.
  final Brightness? keyboardAppearance;

  /// The status bar state of the form field.
  final OptimusStatusBarState? statusBarState;

  /// The size of the form field. Defaults to [OptimusWidgetSize.large].
  final OptimusWidgetSize size;

  /// Whether the clear button is enabled. Defaults to false.
  final bool isClearEnabled;

  @override
  Widget build(BuildContext context) => OptimusInputFormField(
        initialValue: initialValue,
        controller: controller,
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: autovalidateMode,
        placeholder: placeholder,
        keyboardType: keyboardType,
        isPasswordField: true,
        isEnabled: isEnabled,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        label: label,
        maxLines: maxLines,
        minLines: minLines,
        maxCharacters: maxCharacters,
        enableInteractiveSelection: enableInteractiveSelection,
        autofocus: autofocus,
        hasBorders: hasBorders,
        isRequired: isRequired,
        inputKey: inputKey,
        readOnly: readOnly,
        showCursor: showCursor,
        onTap: onTap,
        textAlign: textAlign,
        caption: caption,
        helperMessage: helperMessage,
        keyboardAppearance: keyboardAppearance,
        statusBarState: statusBarState,
        prefix: const Icon(OptimusIcons.lock),
        size: size,
        isClearEnabled: isClearEnabled,
        showLoader: showLoader,
      );
}
