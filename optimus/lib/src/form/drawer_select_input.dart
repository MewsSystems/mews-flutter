import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/form/multiselect/multiselect_field.dart';
import 'package:optimus/src/form/multiselect/select_chip.dart';

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
                child: _BottomSheet(
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
    extends State<OptimusDrawerMultiSelectInput<T>> {
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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MultiSelectInputField(
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
                child: _BottomSheet(
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
      },
    );
  }
}

class _BottomSheet<T> extends StatefulWidget {
  const _BottomSheet({
    this.label,
    required this.builder,
    required this.onChanged,
    this.placeholder = '',
    this.onClosed,
    this.controller,
    required this.listBuilder,
    this.isSearchable = false,
    this.shouldCloseOnSelection = true,
    this.searchInputSize = OptimusWidgetSize.large,
  });

  final String? label;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final String placeholder;
  final VoidCallback? onClosed;
  final TextEditingController? controller;
  final OptimusDrawerListBuilder<T> listBuilder;
  final bool isSearchable;
  final bool shouldCloseOnSelection;
  final OptimusWidgetSize searchInputSize;

  @override
  State<_BottomSheet<T>> createState() => _BottomSheetState<T>();
}

class _BottomSheetState<T> extends State<_BottomSheet<T>> {
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
  void didUpdateWidget(covariant _BottomSheet<T> oldWidget) {
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
      widget.isSearchable ? _effectiveController.text : '',
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
              size: widget.searchInputSize,
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
                      setState(() {});
                      if (widget.shouldCloseOnSelection) {
                        Navigator.of(context).pop();
                        widget.onClosed?.call();
                      }
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem<T> extends StatefulWidget {
  const _DrawerItem({
    required this.item,
    this.isEnabled = true,
    required this.onTap,
  });

  final OptimusDropdownTile<T> item;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  State<_DrawerItem<T>> createState() => _DrawerItemState<T>();
}

class _DrawerItemState<T> extends State<_DrawerItem<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing50),
      child: GestureWrapper(
        onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
        onPressedChanged: (isPressed) => setState(() => _isPressed = isPressed),
        onTap: widget.onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(tokens.borderRadius100),
            color:
                _isPressed
                    ? tokens.backgroundInteractiveNeutralSubtleActive
                    : _isHovered
                    ? tokens.backgroundInteractiveNeutralSubtleHover
                    : null,
          ),
          child: widget.item,
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
