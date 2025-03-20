import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/common.dart';
import 'package:optimus/src/form/form_style.dart';

/// Field to display several selected values.
class MultiSelectInputField extends StatelessWidget {
  const MultiSelectInputField({
    super.key,
    this.isEnabled = true,
    required this.focusNode,
    this.label,
    this.caption,
    this.captionIcon = OptimusIcons.info,
    this.helperMessage,
    this.error,
    this.errorVariant = OptimusInputErrorVariant.bottomHint,
    this.isRequired = false,
    this.isFocused,
    this.suffix,
    this.prefix,
    this.leading,
    this.trailing,
    this.fieldBoxKey,
    this.size = OptimusWidgetSize.large,
    this.showLoader = false,
    this.isCompact = false,
    required this.values,
    this.placeholder = '',
  });

  final bool isEnabled;
  final FocusNode focusNode;
  final String? label;
  final Widget? caption;
  final IconData? captionIcon;
  final Widget? helperMessage;
  final String? error;
  final OptimusInputErrorVariant errorVariant;
  final bool? isFocused;
  final bool isRequired;
  final Widget? leading;
  final Widget? prefix;
  final Key? fieldBoxKey;
  final Widget? suffix;
  final Widget? trailing;
  final OptimusWidgetSize size;
  final bool showLoader;
  final List<Widget> values;
  final bool isCompact;
  final String placeholder;

  bool get hasError {
    final error = this.error;

    return error != null && error.isNotEmpty;
  }

  bool get _isUsingInlineError =>
      errorVariant == OptimusInputErrorVariant.inlineTooltip;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final error = this.error;
    final inlineError =
        _isUsingInlineError && error != null && error.isNotEmpty
            ? InlineErrorTooltip(error: error)
            : null;
    final suffix =
        this.suffix != null ||
                trailing != null ||
                showLoader ||
                inlineError != null
            ? Suffix(
              suffix: this.suffix,
              trailing: trailing,
              showLoader: showLoader,
              inlineError: inlineError,
            )
            : null;
    final prefix =
        leading != null || this.prefix != null
            ? Prefix(prefix: this.prefix, leading: leading)
            : null;

    return FieldWrapper(
      focusNode: focusNode,
      isFocused: isFocused,
      isEnabled: isEnabled,
      label: label,
      caption: caption,
      captionIcon: captionIcon,
      helperMessage: helperMessage,
      error: error,
      errorVariant: errorVariant,
      isRequired: isRequired,
      prefix: prefix,
      suffix: suffix,
      fieldBoxKey: fieldBoxKey,
      size: size,
      children: [
        // ignore: avoid-flexible-outside-flex, it is wrapped in Row later
        Flexible(
          child: Focus(
            focusNode: focusNode,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: size.getVerticalPadding(tokens),
              ),
              constraints: BoxConstraints(minHeight: size.getMinHeight(tokens)),
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: tokens.spacing50,
                runSpacing: tokens.spacing50,
                clipBehavior: Clip.antiAlias,
                children:
                    values.isEmpty
                        ? [_Placeholder(placeholder, isEnabled: isEnabled)]
                        : values,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.text, {this.isEnabled = true});

  final String text;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: context.theme.getPlaceholderStyle(isEnabled: isEnabled),
  );
}

extension on OptimusWidgetSize {
  double getMinHeight(OptimusTokens tokens) => switch (this) {
    OptimusWidgetSize.small => tokens.sizing400,
    OptimusWidgetSize.medium => tokens.sizing500,
    OptimusWidgetSize.large => tokens.sizing600,
    OptimusWidgetSize.extraLarge => tokens.sizing700,
  };

  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
    OptimusWidgetSize.small => tokens.spacing50,
    OptimusWidgetSize.medium => tokens.spacing100,
    OptimusWidgetSize.large ||
    OptimusWidgetSize.extraLarge => tokens.spacing150,
  };
}
