import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group.dart';
import 'package:optimus/src/common/value_builder.dart';
import 'package:optimus/src/form/drawer/bottom_sheet.dart';
import 'package:optimus/src/form/drawer/common.dart';

class OptimusDrawerSelectInput<T> extends StatefulWidget {
  const OptimusDrawerSelectInput({
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
    this.allowMultipleSelection = true,
    this.isSearchable = false,
    required this.listBuilder,
    this.useRootNavigator = false,
    this.searchPlaceholder = '',
    this.searchLabel,
    this.value,
  });

  final T? value;

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

  @override
  State<StatefulWidget> createState() => _OptimusDrawerSelectInputState<T>();
}

class _OptimusDrawerSelectInputState<T>
    extends State<OptimusDrawerSelectInput<T>> {
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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return OptimusInputField(
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
      focusNode: widget.focusNode,
      controller: _controller,
      isReadOnly: true,
      isRequired: widget.isRequired,
      placeholder: widget.value?.let(widget.builder) ?? widget.placeholder,
      onTap: () {
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
                  shouldCloseOnSelection: true,
                  label: widget.searchLabel,
                ),
              ),
        );
      },
    );
  }
}
