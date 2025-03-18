import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';

typedef OptimusDrawerListBuilder<T> =
    List<OptimusDropdownTile<T>> Function(String query);

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
    this.isSearchable = false,
    required this.listBuilder,
  });

  /// Describes the purpose of the select field.
  ///
  /// The input should always include this description (with exceptions).
  final String? label;
  final String placeholder;
  final bool isEnabled;
  final bool isRequired;
  final Widget? leading;
  final Widget? prefix;
  final Widget? trailing;
  final Widget? suffix;
  final bool showLoader;
  final bool isSearchable;
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
  final OptimusDrawerListBuilder<T> listBuilder;

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
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  void _handleClose() {
    _effectiveFocusNode.unfocus();
  }

  @override
  void dispose() {
    _focusNode?.dispose();
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
      focusNode: _effectiveFocusNode,
      isReadOnly: true,
      placeholder:
          widget.selectedValues?.first?.let(widget.builder) ??
          widget.placeholder,
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
              (_) => Material(
                color: Colors.transparent,
                child: _DrawerSelect(
                  builder: widget.builder,
                  onChanged: widget.onChanged,
                  placeholder: widget.placeholder,
                  onClosed: _handleClose,
                  selectedValues: widget.selectedValues,
                  controller: widget.controller,
                  listBuilder: widget.listBuilder,
                  isSearchable: widget.isSearchable,
                ),
              ),
        );
      },
    );
  }
}

class _DrawerSelect<T> extends StatefulWidget {
  const _DrawerSelect({
    super.key,
    this.label,
    required this.builder,
    required this.onChanged,
    this.placeholder = '',
    this.onClosed,
    this.controller,
    required this.listBuilder,
    this.isSearchable = false,
    this.selectedValues,
  });

  final String? label;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final String placeholder;
  final VoidCallback? onClosed;
  final TextEditingController? controller;
  final OptimusDrawerListBuilder<T> listBuilder;
  final bool isSearchable;
  final List<T>? selectedValues;

  @override
  State<_DrawerSelect<T>> createState() => _DrawerSelectState<T>();
}

class _DrawerSelectState<T> extends State<_DrawerSelect<T>> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _effectiveController.addListener(_handleChange);
  }

  void _handleChange() => setState(() {});

  @override
  void dispose() {
    _effectiveController.removeListener(_handleChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _DrawerSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSearchable != widget.isSearchable) {
      _effectiveController.clear();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleChange);
      widget.controller?.addListener(_handleChange);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final items = widget.listBuilder(
      widget.isSearchable ? '' : _effectiveController.text,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.backgroundStaticFloating,
        borderRadius: BorderRadius.vertical(top: tokens.borderRadius300),
      ),
      child: Column(
        children: [
          const _DrawerHeader(),
          if (widget.label case final label?) _DrawerLabel(label: label),
          if (widget.isSearchable)
            OptimusInputField(
              placeholder: widget.placeholder,
              controller: _effectiveController,
            ),
          SizedBox(height: tokens.spacing200),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: tokens.spacing25,
                horizontal: tokens.spacing200,
              ),
              itemCount: items.length,
              itemBuilder:
                  (context, index) => _DrawerItem(
                    item: items[index],
                    onTap: () {
                      widget.onChanged(items[index].value);
                      Navigator.of(context).pop(items[index].value);
                      widget.onClosed?.call();
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem<T> extends StatelessWidget {
  const _DrawerItem({
    required this.item,
    this.isEnabled = true,
    required this.onTap,
  });

  final OptimusDropdownTile<T> item;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing50),
      child: GestureWrapper(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(tokens.borderRadius100),
          ),
          child: item,
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
