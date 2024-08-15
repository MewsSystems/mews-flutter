import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dropdown/dropdown_select.dart';

/// An input field with a dropdown menu. [items] are displayed in the dropdown
/// and could be filtered to show only matching items.
class OptimusSearch<T> extends StatelessWidget {
  const OptimusSearch({
    super.key,
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
    this.helperMessage,
    this.error,
    this.size = OptimusWidgetSize.large,
    this.isReadOnly = false,
    this.showCursor,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.shouldCloseOnInputTap = false,
    this.isClearEnabled = false,
    this.groupBy,
    this.groupBuilder,
  });

  /// Label of the search field.
  final String? label;

  /// Placeholder of the search field.
  final String placeholder;

  /// The style to use for the placeholder text.
  final TextStyle? placeholderStyle;

  /// Text text editing controller.
  final TextEditingController? controller;

  /// Callback for when the text in the search field changes.
  final ValueSetter<String>? onTextChanged;

  /// List of items to be displayed in the dropdown.
  final List<OptimusDropdownTile<T>> items;

  /// Whether the search field is in updating state. If true, the loading
  /// indicator will be displayed.
  final bool isUpdating;

  /// Whether the search field is enabled.
  final bool isEnabled;

  /// Whether the search field is required.
  final bool isRequired;

  /// Callback for when the value was selected.
  final ValueSetter<T> onChanged;

  /// Caption text to be displayed below the search field. Typically a [Text]
  /// widget.
  final Widget? caption;

  /// Secondary caption text to be displayed on the right of the search field.
  /// Typically a [Text] widget.
  final Widget? helperMessage;

  /// Error text to be displayed below the search field. Typically a [Text].
  /// Will replace the caption if both are provided.
  final String? error;

  /// Size of the search field.
  final OptimusWidgetSize size;

  /// A leading widget to be displayed before the search field. Typically an
  /// [Icon] widget.
  final Widget? leading;

  /// A prefix widget to be displayed before the search field, but after the
  /// leading widget. Typically a [Text] widget.
  final Widget? prefix;

  /// A suffix widget to be displayed after the search field. Typically a
  /// [Text] widget.
  final Widget? suffix;

  /// A trailing widget to be displayed after the search field. Typically an
  /// [Icon] widget. Will be displayed after the suffix widget.
  final Widget? trailing;

  /// Controls the visibility of the clear button.
  final bool isClearEnabled;

  /// Custom focus node to be used by the search field.
  final FocusNode? focusNode;

  /// Controls whether the dropdown should close when the input is tapped.
  final bool shouldCloseOnInputTap;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool isReadOnly;

  /// {@macro optimus.select.groupBy}
  final Grouper<T>? groupBy;

  /// {@macro optimus.select.groupBuilder}
  final GroupBuilder? groupBuilder;

  @override
  Widget build(BuildContext context) => DropdownSelect<T>(
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
        leadingImplicit:
            Icon(OptimusIcons.search, size: context.tokens.sizing200),
        trailing: trailing,
        caption: caption,
        helperMessage: helperMessage,
        error: error,
        size: size,
        isReadOnly: isReadOnly,
        showCursor: showCursor,
        prefix: prefix,
        suffix: suffix,
        focusNode: focusNode,
        shouldCloseOnInputTap: shouldCloseOnInputTap,
        isClearEnabled: isClearEnabled,
        groupBy: groupBy,
        groupBuilder: groupBuilder,
      );
}
