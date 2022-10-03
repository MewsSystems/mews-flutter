import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dropdown/dropdown_select.dart';

class OptimusSearch<T> extends StatelessWidget {
  const OptimusSearch({
    Key? key,
    this.label,
    this.placeholder = '',
    this.placeholderStyle,
    this.controller,
    this.onTextChanged,
    required this.items,
    this.isUpdating = false,
    this.isEnabled = true,
    this.isRequired = false,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    this.readOnly = false,
    this.showCursor,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.shouldCloseOnInputTap = false,
    this.showLoader = false,
  }) : super(key: key);

  final String? label;
  final String placeholder;
  final TextStyle? placeholderStyle;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isUpdating;
  final bool isEnabled;
  final bool isRequired;
  final ValueSetter<T> onChanged;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final Widget? leading;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? trailing;
  final bool showLoader;
  final FocusNode? focusNode;
  final bool shouldCloseOnInputTap;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  Color _iconColor(OptimusThemeData theme) =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return DropdownSelect(
      label: label,
      placeholder: placeholder,
      placeholderStyle: placeholderStyle,
      controller: controller,
      onTextChanged: onTextChanged,
      items: items,
      isUpdating: isUpdating,
      isEnabled: isEnabled,
      isRequired: isRequired,
      onChanged: onChanged,
      leading: leading,
      trailing: trailing,
      trailingImplicit: Icon(
        OptimusIcons.search,
        size: 24,
        color: _iconColor(theme),
      ),
      animateTrailing: false,
      caption: caption,
      secondaryCaption: secondaryCaption,
      error: error,
      size: size,
      readOnly: readOnly,
      showCursor: showCursor,
      prefix: prefix,
      suffix: suffix,
      focusNode: focusNode,
      shouldCloseOnInputTap: shouldCloseOnInputTap,
      showLoader: showLoader,
    );
  }
}
