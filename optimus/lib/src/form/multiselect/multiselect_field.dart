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
    this.captionIcon,
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

  FocusNode get _effectiveFocusNode {
    if (widget.focusNode case final focusNode?) return focusNode;

    return _focusNode ??= FocusNode();
  }

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

  bool get _isUsingInlineError => widget.errorVariant == .inlineTooltip;

  void _handleStateUpdate() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final error = widget.error;
    final inlineError = _isUsingInlineError && error != null && error.isNotEmpty
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
    final prefix = widget.leading != null || widget.prefix != null
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
            Focus(
              focusNode: _effectiveFocusNode,
              child: Container(
                padding: .symmetric(
                  vertical: widget.size.getVerticalPadding(tokens),
                ),
                constraints: BoxConstraints(
                  minHeight: widget.size.getMinHeight(tokens),
                ),
                width: .infinity,
                child: Wrap(
                  crossAxisAlignment: .center,
                  runAlignment: .center,
                  spacing: tokens.spacing50,
                  runSpacing: tokens.spacing50,
                  clipBehavior: .antiAlias,
                  children: widget.values,
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
    .small => tokens.sizing400,
    .medium => tokens.sizing500,
    .large => tokens.sizing600,
    .extraLarge => tokens.sizing700,
  };

  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
    .small => tokens.spacing50,
    .medium => tokens.spacing100,
    .large || .extraLarge => tokens.spacing150,
  };
}
