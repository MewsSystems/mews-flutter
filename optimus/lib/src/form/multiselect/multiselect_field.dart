import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/form/common.dart';

/// Field to display several selected values.
class MultiSelectInputField extends StatefulWidget {
  const MultiSelectInputField({
    super.key,
    this.isEnabled = true,
    this.focusNode,
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
  });

  final bool isEnabled;
  final FocusNode? focusNode;
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

  bool get hasError {
    final error = this.error;

    return error != null && error.isNotEmpty;
  }

  @override
  State<MultiSelectInputField> createState() =>
      _OptimusMultiSelectInputFieldState();
}

class _OptimusMultiSelectInputFieldState extends State<MultiSelectInputField>
    with ThemeGetter {
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleStateUpdate);
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleStateUpdate);
    _focusNode?.dispose();
    super.dispose();
  }

  bool get _isUsingInlineError =>
      widget.errorVariant == OptimusInputErrorVariant.inlineTooltip;

  void _handleStateUpdate() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final error = widget.error;
    final inlineError =
        _isUsingInlineError && error != null && error.isNotEmpty
            ? InlineErrorTooltip(error: error)
            : null;
    final suffix =
        widget.suffix != null ||
                widget.trailing != null ||
                widget.showLoader ||
                inlineError != null
            ? Suffix(
              suffix: widget.suffix,
              trailing: widget.trailing,
              showLoader: widget.showLoader,
              inlineError: inlineError,
            )
            : null;
    final prefix =
        widget.leading != null || widget.prefix != null
            ? Prefix(prefix: widget.prefix, leading: widget.leading)
            : null;

    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: GestureDetector(
        onTap: _effectiveFocusNode.requestFocus,
        child: FieldWrapper(
          focusNode: _effectiveFocusNode,
          isFocused: widget.isFocused,
          isEnabled: widget.isEnabled,
          label: widget.label,
          caption: widget.caption,
          captionIcon: widget.captionIcon,
          helperMessage: widget.helperMessage,
          error: error,
          errorVariant: widget.errorVariant,
          isRequired: widget.isRequired,
          prefix: prefix,
          suffix: suffix,
          fieldBoxKey: widget.fieldBoxKey,
          size: widget.size,
          children: [
            // ignore: avoid-flexible-outside-flex, it is wrapped in Row later
            Flexible(
              child: Focus(
                focusNode: _effectiveFocusNode,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: widget.size.getVerticalPadding(tokens),
                  ),
                  constraints: BoxConstraints(
                    minHeight: widget.size.getMinHeight(tokens),
                  ),
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.center,
                    spacing: tokens.spacing50,
                    runSpacing: tokens.spacing50,
                    clipBehavior: Clip.antiAlias,
                    children: widget.values,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
