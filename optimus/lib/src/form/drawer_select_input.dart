// ignore_for_file: avoid-unnecessary-stateful-widgets

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusDrawerSelectInput<T> extends StatefulWidget {
  const OptimusDrawerSelectInput({
    super.key,
    this.label,
    this.placeholder = '',
    this.value,
    required this.items,
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
    this.selectedValues,
  });

  /// Describes the purpose of the select field.
  ///
  /// The input should always include this description (with exceptions).
  final String? label;
  final String placeholder;
  final T? value;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final bool isRequired;
  final Widget? leading;
  final Widget? prefix;
  final Widget? trailing;
  final Widget? suffix;
  final bool showLoader;
  final FocusNode? focusNode;

  /// Serves as a helper text for informative or descriptive purposes.
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;
  final bool isReadOnly;

  /// An embedded search field that can be used to filter the list of items.
  /// Will be displayed as a part of the dropdown menu. If the [controller] or
  /// [onTextChanged] is provided, the embedded search will not be used. Instead
  /// the search will be a part of the input field.
  final OptimusDropdownEmbeddedSearch? embeddedSearch;

  /// A widget that is displayed when the list of items is empty. If not
  /// provided the dropdown will not be displayed.
  final Widget? emptyResultPlaceholder;

  /// {@template optimus.select.groupBy}
  /// A function that would retrieve value for the grouping.
  /// {@endtemplate}
  final Grouper<T>? groupBy;

  /// {@template optimus.select.groupBuilder}
  /// A builder that would create a group header. If not provided the
  /// [OptimusDropdownGroupSeparator] widget will be used.
  /// {@endtemplate}
  final GroupBuilder? groupBuilder;

  /// If enabled, you can select multiple items at the same time.
  /// State of the selected items is managed outside this widget and has to be
  /// set in [selectedValues].
  final bool allowMultipleSelection;

  /// List of selected values. Would be omitted if the multiselect is disabled.
  final List<T>? selectedValues;

  @override
  State<OptimusDrawerSelectInput<T>> createState() =>
      _OptimusDrawerSelectInputState<T>();
}

class _OptimusDrawerSelectInputState<T>
    extends State<OptimusDrawerSelectInput<T>> {
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
      isReadOnly: true,
      placeholder:
          widget.value?.let(widget.builder) ??
          widget.placeholder, // TODO(witwash): update on select
      onTap: () {
        showModalBottomSheet<T>(
          useSafeArea: true,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height - tokens.spacing300,
            minHeight: MediaQuery.sizeOf(context).height - tokens.spacing300,
            maxWidth: MediaQuery.sizeOf(context).width,
            minWidth: MediaQuery.sizeOf(context).width,
          ),
          context: context,
          isScrollControlled: true,
          elevation: 2,
          builder:
              (_) => _DrawerSelect(
                items: widget.items,
                builder: widget.builder,
                onChanged: widget.onChanged,
                placeholder: widget.placeholder,
              ),
        );
      },
    );
  }
}

class _DrawerSelect<T> extends StatelessWidget {
  const _DrawerSelect({
    super.key,
    this.label,
    required this.items,
    required this.builder,
    required this.onChanged,
    this.placeholder = '',
  });

  final String? label;
  final List<OptimusDropdownTile<T>> items;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tokens.backgroundStaticFloating,
          borderRadius: BorderRadius.vertical(top: tokens.borderRadius300),
        ),
        child: Column(
          children: [
            const _DrawerHeader(),
            if (label case final label?) _DrawerLabel(label: label),
            const OptimusInputField(),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder:
                    (context, index) => InkWell(
                      borderRadius: BorderRadius.all(
                        context.tokens.borderRadius100,
                      ),
                      onTap: () {
                        onChanged(items[index].value);
                        Navigator.of(context).pop(items[index].value);
                      },
                      child: items[index],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: context.tokens.spacing150,
      bottom: context.tokens.spacing400,
    ),
    child: SizedBox(
      height: context.tokens.spacing50,
      child: Row(
        children: [
          const Spacer(),
          Container(
            width:
                context.tokens.sizing100 * 12, // TODO(witwash): missing tokens
            decoration: BoxDecoration(
              color: context.tokens.borderStaticPrimary,
              borderRadius: BorderRadius.all(context.tokens.borderRadius50),
            ),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}

class _DrawerLabel extends StatelessWidget {
  const _DrawerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: context.tokens.titleMediumStrong.copyWith(
      color: context.tokens.textStaticPrimary,
    ),
  );
}
