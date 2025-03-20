import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/common/group.dart';
import 'package:optimus/src/common/value_builder.dart';
import 'package:optimus/src/dropdown/embedded_search.dart';
import 'package:optimus/src/form/drawer/bottom_sheet.dart';
import 'package:optimus/src/form/drawer/common.dart';
import 'package:optimus/src/form/multiselect/multiselect_field.dart';
import 'package:optimus/src/form/multiselect/select_chip.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/widget_size.dart';

class OptimusDrawerMultiSelectInput<T> extends StatefulWidget {
  const OptimusDrawerMultiSelectInput({
    super.key,
    this.label,
    this.placeholder = '',
    this.isEnabled = true,
    this.isRequired = false,
    this.leading,
    this.prefix,
    this.trailing,
    this.suffix,
    this.showLoader = false,
    this.focusNode,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    this.searchInputSize = OptimusWidgetSize.large,
    required this.builder,
    required this.onChanged,
    this.controller,
    this.onTextChanged,
    this.isReadOnly = false,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
    this.groupBy,
    this.groupBuilder,
    this.allowMultipleSelection = false,
    this.isSearchable = false,
    required this.listBuilder,
    this.useRootNavigator = false,
    this.searchLabel,
    this.searchPlaceholder = '',
    this.values,
    this.isCompact = false,
  });

  final String? label;
  final String placeholder;
  final String searchPlaceholder;
  final bool isEnabled;
  final bool isRequired;
  final Widget? leading;
  final Widget? prefix;
  final Widget? trailing;
  final Widget? suffix;
  final bool showLoader;
  final FocusNode? focusNode;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final OptimusWidgetSize searchInputSize;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;
  final bool isReadOnly;
  final OptimusDropdownEmbeddedSearch? embeddedSearch;
  final Widget? emptyResultPlaceholder;
  final Grouper<T>? groupBy;
  final GroupBuilder? groupBuilder;

  final bool allowMultipleSelection;
  final bool isSearchable;
  final OptimusDrawerListBuilder<T> listBuilder;
  final bool useRootNavigator;
  final String? searchLabel;

  final List<T>? values;
  final bool isCompact;

  @override
  State<StatefulWidget> createState() =>
      _OptimusDrawerMultiSelectInputState<T>();
}

class _OptimusDrawerMultiSelectInputState<T>
    extends State<OptimusDrawerMultiSelectInput<T>>
    with ThemeGetter {
  FocusNode? _focusNode;
  late TextEditingController _controller;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleClose() {
    _effectiveFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<Widget> get _selectedValues {
    final selectedValues = widget.values;

    if (selectedValues == null) return [];

    return widget.isCompact && selectedValues.length > 2
        ? [
          for (final element in selectedValues.take(2))
            MultiselectChip(
              onRemoved: () => widget.onChanged(element),
              onTap: () {},
              isEnabled: widget.isEnabled,
              text: widget.builder(element),
            ),
          MultiselectChip(
            text: '+${selectedValues.length - 2}',
            onTap: () {},
            isEnabled: widget.isEnabled,
          ),
        ]
        : selectedValues
            .map(
              (element) => MultiselectChip(
                onRemoved: () => widget.onChanged(element),
                onTap: () {},
                isEnabled: widget.isEnabled,
                text: widget.builder(element),
              ),
            )
            .toList();
  }

  void _handleOnTap() {
    showModalBottomSheet<T>(
      useRootNavigator: widget.useRootNavigator,
      constraints: BoxConstraints(
        maxHeight:
            MediaQuery.sizeOf(context).height -
            tokens.spacing300, // TODO(witwash): check with design
        minHeight: MediaQuery.sizeOf(context).height - tokens.spacing300,
        maxWidth: MediaQuery.sizeOf(context).width,
        minWidth: MediaQuery.sizeOf(context).width,
      ),
      context: context,
      isScrollControlled: true,
      elevation: 2,
      builder:
          (_) => Material(
            color: Colors.transparent,
            child: DrawerBottomSheet(
              builder: widget.builder,
              onChanged: (value) {
                _controller.text = value.let(widget.builder);
                widget.onChanged(value);
              },
              placeholder: widget.searchPlaceholder,
              onClosed: _handleClose,
              controller: widget.controller,
              listBuilder: widget.listBuilder,
              isSearchable: widget.isSearchable,
              searchInputSize: widget.searchInputSize,
              shouldCloseOnSelection: false,
              label: widget.searchLabel,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: _handleOnTap,
    child: MultiSelectInputField(
      label: widget.label,
      error: widget.error,
      prefix: widget.prefix,
      suffix: widget.suffix,
      isEnabled: widget.isEnabled,
      showLoader: widget.showLoader,
      size: widget.size,
      caption: widget.caption,
      helperMessage: widget.secondaryCaption,
      trailing: widget.trailing,
      leading: widget.leading,
      focusNode: _effectiveFocusNode,
      isRequired: widget.isRequired,
      values: _selectedValues,
      placeholder: widget.placeholder,
    ),
  );
}
