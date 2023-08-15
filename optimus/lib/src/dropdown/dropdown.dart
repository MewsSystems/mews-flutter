import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/elevation.dart';

typedef Grouper<T> = String Function(T item);
typedef GroupBuilder = Widget Function(String value);

class OptimusDropdown<T> extends StatelessWidget {
  const OptimusDropdown({
    super.key,
    required this.items,
    required this.anchorKey,
    required this.onChanged,
    this.width,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
    this.groupBy,
    this.groupBuilder,
  });

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
    super.key,
    required this.onChanged,
    required this.items,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
    this.groupBy,
    this.groupBuilder,
  });

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
    double maxHeight,
  ) {
    final groupBy = this.groupBy;

    return groupBy != null
        ? _GroupedDropdownListView(
            items: items,
            onChanged: onChanged,
            isReversed: isOnTop,
            groupBy: groupBy,
            groupBuilder: groupBuilder,
            maxHeight: maxHeight,
          )
        : _DropdownListView(
            items: items,
            onChanged: onChanged,
            isReversed: isOnTop,
            maxHeight: maxHeight,
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
                    child: _buildList(isOnTop, listMaxHeight),
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
    }

    return const SizedBox.shrink();
  }
}

class _DropdownListView<T> extends StatelessWidget {
  const _DropdownListView({
    super.key,
    required this.onChanged,
    required this.items,
    required this.isReversed,
    required this.maxHeight,
  });

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;
  final double maxHeight;

  double get _minHeight =>
      items.length * _itemMinHeight + _listVerticalSpacing * 2;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: min(_minHeight, maxHeight),
        child: ListView.builder(
          reverse: isReversed,
          padding: const EdgeInsets.symmetric(vertical: _listVerticalSpacing),
          itemCount: items.length,
          itemBuilder: (context, index) =>
              _DropdownItem(onChanged: onChanged, child: items[index]),
        ),
      );
}

class _GroupedDropdownListView<T> extends StatefulWidget {
  const _GroupedDropdownListView({
    super.key,
    required this.onChanged,
    required this.items,
    required this.isReversed,
    required this.maxHeight,
    required this.groupBy,
    required this.groupBuilder,
  });

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;
  final double maxHeight;
  final Grouper<T> groupBy;
  final GroupBuilder? groupBuilder;

  @override
  State<_GroupedDropdownListView<T>> createState() =>
      _GroupedDropdownListViewState<T>();
}

class _GroupedDropdownListViewState<T>
    extends State<_GroupedDropdownListView<T>> with ThemeGetter {
  late List<OptimusDropdownTile<T>> _sortedItems;
  late int _groupsCount;

  @override
  void initState() {
    super.initState();
    _sortedItems = _sortItems();
  }

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

  List<OptimusDropdownTile<T>> _sortItems() {
    int groupsCount = 1;

    final sorted = [...widget.items]..sort((e1, e2) {
        final value1 = e1.value;
        final value2 = e2.value;

        int? result = widget.groupBy(value1).compareTo(widget.groupBy(value2));
        if (result == 0) {
          if (value1 is Comparable) {
            result = value1.compareTo(value2 as Comparable);
          }
        } else {
          groupsCount++;
        }

        return result;
      });
    _groupsCount = groupsCount;

    return sorted;
  }

  Widget _buildItem(OptimusDropdownTile<T> child) =>
      _DropdownItem(onChanged: widget.onChanged, child: child);

  Widget _buildHeader(
    bool useBorder,
    OptimusDropdownTile<T> child,
  ) =>
      _GroupWrapper(
        useBorder: useBorder,
        group: _effectiveGroupBuilder(widget.groupBy(child.value)),
        child: _buildItem(child),
      );

  int get _leadingIndex => widget.isReversed ? _sortedItems.length - 1 : 0;

  double get _minListHeight =>
      _groupsCount * _groupMinHeight +
      widget.items.length * _itemMinHeight +
      _listVerticalSpacing * 2;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: min(_minListHeight, widget.maxHeight),
        child: ListView.builder(
          reverse: widget.isReversed,
          padding: const EdgeInsets.symmetric(vertical: _listVerticalSpacing),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final current = _sortedItems[index];
            if (index == _leadingIndex) {
              return _buildHeader(false, current);
            }

            final previous = _sortedItems[index + (widget.isReversed ? 1 : -1)];

            return widget.groupBy(current.value) !=
                    widget.groupBy(previous.value)
                ? _buildHeader(true, current)
                : _buildItem(current);
          },
        ),
      );
}

class _GroupWrapper extends StatelessWidget {
  const _GroupWrapper({
    required this.group,
    required this.child,
    this.useBorder = true,
  });

  final bool useBorder;
  final Widget group;
  final Widget child;

  Widget _buildGroup(BuildContext context) => Container(
        width: AnchoredOverlay.of(context)?.width,
        decoration: BoxDecoration(
          border: Border(
            top: useBorder
                ? BorderSide(color: OptimusTheme.of(context).colors.neutral25)
                : BorderSide.none,
          ),
        ),
        child: group,
      );

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildGroup(context), child],
      );
}

class _DropdownItem<T> extends StatefulWidget {
  const _DropdownItem({
    super.key,
    required this.child,
    required this.onChanged,
  });

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
  Widget build(BuildContext context) => SizedBox(
        width: AnchoredOverlay.of(context)?.width,
        child: InkWell(
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
        ),
      );
}

class _SearchWrapper extends StatefulWidget {
  const _SearchWrapper({
    required this.width,
    required this.showDivider,
    required this.isOnTop,
    required this.child,
  });

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

const _embeddedSearchHeight = 54.0;
const _groupMinHeight = 28.0;
const _itemMinHeight = 69.0;
const _listVerticalSpacing = spacing100;
