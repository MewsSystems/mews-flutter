import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/elevation.dart';

typedef Grouper<T> = String Function(T item);
typedef GroupBuilder = Widget Function(String value);

class OptimusDropdown<T> extends StatelessWidget {
  const OptimusDropdown({
    Key? key,
    required this.items,
    required this.anchorKey,
    required this.onChanged,
    this.width,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
    this.groupBy,
    this.groupBuilder,
  }) : super(key: key);

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onChanged;
  final GlobalKey anchorKey;
  final double? width;
  final Widget? embeddedSearch;
  final Widget? emptyResultPlaceholder;
  final Grouper<T>? groupBy;
  final GroupBuilder? groupBuilder;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          AnchoredOverlay(
            anchorKey: anchorKey,
            width: width,
            child: _DropdownContent(
              items: items,
              onChanged: onChanged,
              embeddedSearch: embeddedSearch,
              emptyResultPlaceholder: emptyResultPlaceholder,
              groupBy: groupBy,
              groupBuilder: groupBuilder,
            ),
          ),
        ],
      );
}

class _DropdownContent<T> extends StatelessWidget {
  const _DropdownContent({
    Key? key,
    required this.onChanged,
    required this.items,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
    this.groupBy,
    this.groupBuilder,
  }) : super(key: key);

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final Widget? embeddedSearch;
  final Widget? emptyResultPlaceholder;
  final Grouper<T>? groupBy;
  final GroupBuilder? groupBuilder;

  // TODO(VG): can be changed when final dark theme design is ready.
  BoxDecoration _dropdownDecoration(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return BoxDecoration(
      borderRadius: const BorderRadius.all(borderRadius100),
      color: theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
      boxShadow: elevation50,
    );
  }

  Widget? _buildEmptyPlaceholder() {
    if (emptyResultPlaceholder != null) {
      return Material(
        color: Colors.transparent,
        child: emptyResultPlaceholder,
      );
    }
  }

  Widget _buildSearch(
    AnchoredOverlayController controller,
    bool isOnTop,
    Widget embeddedSearch,
  ) =>
      _SearchWrapper(
        width: controller.width,
        showDivider: items.isNotEmpty,
        isOnTop: isOnTop,
        child: embeddedSearch,
      );

  Widget _buildList(
    bool isOnTop,
  ) {
    final groupBy = this.groupBy;

    if (groupBy != null) {
      return _GroupedDropdownListView(
        items: items,
        onChanged: onChanged,
        isReversed: isOnTop,
        groupBy: groupBy,
        groupBuilder: groupBuilder,
      );
    }

    return _DropdownListView(
      items: items,
      onChanged: onChanged,
      isReversed: isOnTop,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AnchoredOverlay.of(context);
    final embeddedSearch = this.embeddedSearch;
    if (controller != null) {
      final isOnTop = controller.top > controller.bottom;
      final listMaxHeight = embeddedSearch != null
          ? controller.maxHeight - _embeddedSearchHeight
          : controller.maxHeight;

      return Container(
        constraints: BoxConstraints(maxHeight: controller.maxHeight),
        width: controller.width,
        decoration: _dropdownDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (embeddedSearch != null && !isOnTop)
              _buildSearch(controller, isOnTop, embeddedSearch),
            if (items.isNotEmpty)
              Container(
                constraints: BoxConstraints(
                  maxHeight: listMaxHeight,
                  maxWidth: controller.width,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: OptimusScrollConfiguration(
                    child: _buildList(isOnTop),
                  ),
                ),
              ),
            if (items.isEmpty)
              _buildEmptyPlaceholder() ?? const SizedBox.shrink(),
            if (embeddedSearch != null && isOnTop)
              _buildSearch(controller, isOnTop, embeddedSearch),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _DropdownListView<T> extends StatelessWidget {
  const _DropdownListView({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.isReversed,
  }) : super(key: key);

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;

  @override
  Widget build(BuildContext context) => ListView.builder(
        reverse: isReversed,
        padding: const EdgeInsets.symmetric(vertical: spacing100),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) =>
            _DropdownItem(onChanged: onChanged, child: items[index]),
      );
}

class _GroupedDropdownListView<T> extends StatefulWidget {
  const _GroupedDropdownListView({
    Key? key,
    required this.onChanged,
    required this.items,
    required this.isReversed,
    required this.groupBy,
    required this.groupBuilder,
  }) : super(key: key);

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;
  final Grouper<T> groupBy;
  final GroupBuilder? groupBuilder;

  @override
  State<_GroupedDropdownListView<T>> createState() =>
      _GroupedDropdownListViewState<T>();
}

class _GroupedDropdownListViewState<T>
    extends State<_GroupedDropdownListView<T>> with ThemeGetter {
  late List<OptimusDropdownTile<T>> _sortedItems = _sortItems();

  @override
  void didUpdateWidget(_GroupedDropdownListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _sortedItems = _sortItems();
    }
  }

  GroupBuilder get _effectiveGroupBuilder =>
      widget.groupBuilder ??
      (value) =>
          OptimusDropdownGroupSeparator(child: Text(value.toUpperCase()));

  List<OptimusDropdownTile<T>> _sortItems() =>
      [...widget.items]..sort((e1, e2) {
          int? result;
          result = widget.groupBy(e1.value).compareTo(widget.groupBy(e2.value));
          if (result == 0) {
            if (e1.value is Comparable) {
              result =
                  (e1.value as Comparable).compareTo(e2.value as Comparable);
            }
          }

          return result;
        });

  Widget _buildItem(OptimusDropdownTile<T> child) =>
      _DropdownItem(onChanged: widget.onChanged, child: child);

  @override
  Widget build(BuildContext context) {
    final leadingItem = widget.isReversed ? _sortedItems.length * 2 - 1 : 0;

    return ListView.builder(
      reverse: widget.isReversed,
      padding: const EdgeInsets.symmetric(vertical: spacing100),
      shrinkWrap: true,
      itemCount: _sortedItems.length * 2,
      itemBuilder: (context, index) {
        final itemIndex = index ~/ 2;
        final currentItem = _sortedItems[itemIndex];
        final currentGroup = widget.groupBy(currentItem.value);

        if (index == leadingItem) {
          return _GroupDecorator(
            useBorder: false,
            child: _effectiveGroupBuilder(currentGroup),
          );
        }

        if (index.isReserved(widget.isReversed)) {
          final previousGroup = widget.groupBy(
            _sortedItems[itemIndex + (widget.isReversed ? 1 : -1)].value,
          );

          return previousGroup != currentGroup
              ? _GroupDecorator(child: _effectiveGroupBuilder(currentGroup))
              : const SizedBox.shrink();
        } else {
          return _buildItem(currentItem);
        }
      },
    );
  }
}

class _GroupDecorator extends StatelessWidget {
  const _GroupDecorator({Key? key, this.useBorder = true, required this.child})
      : super(key: key);

  final bool useBorder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: useBorder
              ? BorderSide(color: theme.colors.neutral25)
              : BorderSide.none,
        ),
      ),
      child: child,
    );
  }
}

class _DropdownItem<T> extends StatefulWidget {
  const _DropdownItem({
    Key? key,
    required this.child,
    required this.onChanged,
  }) : super(key: key);

  final OptimusDropdownTile<T> child;
  final ValueSetter<T> onChanged;

  @override
  _DropdownItemState<T> createState() => _DropdownItemState();
}

class _DropdownItemState<T> extends State<_DropdownItem<T>> with ThemeGetter {
  bool _isHighlighted = false;

  void _onItemTap() {
    widget.onChanged(widget.child.value);
    DropdownTapInterceptor.of(context)?.onTap();
  }

  @override
  Widget build(BuildContext context) => InkWell(
        highlightColor: theme.colors.primary,
        onHighlightChanged: (isHighlighted) =>
            setState(() => _isHighlighted = isHighlighted),
        onTap: _onItemTap,
        child: _isHighlighted
            ? OptimusTheme(
                themeMode: ThemeMode.dark,
                darkTheme: OptimusTheme.of(context).copyWith(
                  brightness: Brightness.dark,
                ),
                child: widget.child,
              )
            : widget.child,
      );
}

class _SearchWrapper extends StatefulWidget {
  const _SearchWrapper({
    Key? key,
    required this.width,
    required this.showDivider,
    required this.isOnTop,
    required this.child,
  }) : super(key: key);

  final double width;
  final Widget child;
  final bool showDivider;
  final bool isOnTop;

  @override
  State<_SearchWrapper> createState() => _SearchWrapperState();
}

class _SearchWrapperState extends State<_SearchWrapper> {
  final GlobalKey _searchKey = GlobalKey();

  Widget _buildDivider(OptimusThemeData theme) =>
      Divider(thickness: 1, height: 1, color: theme.colors.neutral50);

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return SizedBox(
      child: Column(
        children: [
          if (widget.showDivider && widget.isOnTop) _buildDivider(theme),
          KeyedSubtree(key: _searchKey, child: widget.child),
          if (widget.showDivider && !widget.isOnTop) _buildDivider(theme),
        ],
      ),
    );
  }
}

extension on int {
  bool isReserved(bool isReversed) => isReversed ? isOdd : isEven;
}

const _embeddedSearchHeight = 54.0;
