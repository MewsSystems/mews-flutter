import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusTextArea extends StatelessWidget {
  const OptimusTextArea({
    super.key,
    this.onChanged,
    this.placeholder,
    this.placeholderStyle,
    this.keyboardType = TextInputType.multiline,
    this.isEnabled = true,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.label,
    this.caption,
    this.captionIcon,
    this.helperMessage,
    this.rows = 2,
    this.maxCharacters,
    this.controller,
    this.error,
    this.errorVariant = OptimusInputErrorVariant.bottomHint,
    this.enableInteractiveSelection = true,
    this.enableAutoFocus = false,
    this.isFocused,
    this.enableAutoCorrect = true,
    this.isRequired = false,
    this.inputKey,
    this.fieldBoxKey,
    this.isReadOnly = false,
    this.onTap,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.size = OptimusWidgetSize.large,
    this.showCursor,
    this.inputFormatters,
    this.keyboardAppearance,
    this.enableIMEPersonalizedLearning = true,
    this.enableSuggestions = true,
    this.isInlined = false,
    this.enableAutoSize = true,
    this.enableAutoCollapse = true,
  });

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// The placeholder text that will be displayed when the field is empty.
  final String? placeholder;

  /// The style of the placeholder text.
  final TextStyle? placeholderStyle;

  /// {@macro flutter.widgets.editableText.keyboardType}
  /// Defaults to [TextInputType.multiline].
  final TextInputType? keyboardType;

  /// Controls whether the field is enabled.
  final bool isEnabled;

  /// The action the keyboard should take when the user presses the action key.
  final TextInputAction? textInputAction;

  /// The callback to call when the user submits the field.
  final ValueChanged<String>? onSubmitted;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The label that will be displayed above the field.
  final String? label;

  /// The caption that will be displayed under the field.
  final Widget? caption;

  /// The icon that will be displayed next to the caption.
  final IconData? captionIcon;

  /// The helper message that will be displayed under the field.
  final Widget? helperMessage;

  /// The number of lines that the field should have. Defaults to 2.
  final int rows;

  /// The maximum characters for the field. Current character count will be
  /// displayed under the field.
  final int? maxCharacters;

  /// The optional controller for the input field.
  final TextEditingController? controller;

  /// The error message that will be displayed under the field.
  final String? error;

  /// The way error should be displayed. Will be set to the
  /// [OptimusInputErrorVariant.bottomHint] if not provided.
  final OptimusInputErrorVariant errorVariant;

  /// Controls whether the text field should allow the user to interactively
  /// select the text.
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool enableAutoFocus;

  /// Controls whether the field is focused. Overrides [focusNode] focus.
  final bool? isFocused;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool enableAutoCorrect;

  /// Defines whether the field is required.
  final bool isRequired;

  /// The key for the input field.
  final Key? inputKey;

  /// The [Key] for the field box.
  final Key? fieldBoxKey;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool isReadOnly;

  /// The callback that will be called when the field is tapped.
  final VoidCallback? onTap;

  /// The horizontal alignment of the text.
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The size of the input field. Defaults to [OptimusWidgetSize.large].
  final OptimusWidgetSize size;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

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

  /// Controls whether the text area should automatically adjust its height to
  /// fit the content. Defaults to true.
  final bool enableAutoSize;

  /// Controls whether the input should collapse to one line height if not
  /// focused.
  final bool enableAutoCollapse;

  @override
  Widget build(BuildContext context) => OptimusInputField(
        onChanged: onChanged,
        placeholder: placeholder,
        placeholderStyle: placeholderStyle,
        keyboardType: keyboardType,
        isEnabled: isEnabled,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        label: label,
        caption: caption,
        captionIcon: captionIcon,
        helperMessage: helperMessage,
        maxLines: rows,
        maxCharacters: maxCharacters,
        minLines: enableAutoSize ? 1 : rows,
        controller: controller,
        error: error,
        errorVariant: errorVariant,
        enableInteractiveSelection: enableInteractiveSelection,
        enableAutoFocus: enableAutoFocus,
        isFocused: isFocused,
        enableAutoCorrect: enableAutoCorrect,
        isRequired: isRequired,
        inputKey: inputKey,
        fieldBoxKey: fieldBoxKey,
        isReadOnly: isReadOnly,
        onTap: onTap,
        textAlign: textAlign,
        textCapitalization: textCapitalization,
        size: size,
        showCursor: showCursor,
        inputFormatters: inputFormatters,
        keyboardAppearance: keyboardAppearance,
        enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
        enableSuggestions: enableSuggestions,
        isInlined: isInlined,
        enableAutoCollapse: enableAutoCollapse,
      );
}
