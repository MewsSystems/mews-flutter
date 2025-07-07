import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/common/semantics.dart';
import 'package:optimus/src/common/text_scaling.dart';
import 'package:optimus/src/dropdown/dropdown_size_data.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';

typedef Grouper<T> = String Function(T item);
typedef GroupBuilder = Widget Function(String value);

class OptimusDropdown<T> extends StatelessWidget {
  const OptimusDropdown({
    super.key,
    required this.items,
    required this.anchorKey,
    required this.onChanged,
    required this.size,
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
  final OptimusWidgetSize size;

  @override
  Widget build(BuildContext context) => DropdownSizeData(
    size: size,
    child: Stack(
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
    ),
  );
}

class _DropdownContent<T> extends StatefulWidget {
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

  @override
  State<_DropdownContent<T>> createState() => _DropdownContentState<T>();
}

class _DropdownContentState<T> extends State<_DropdownContent<T>>
    with SingleTickerProviderStateMixin, ThemeGetter {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );

  late final _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.25, 1.0, curve: Curves.easeInOutCubic),
    ),
  );

  late final _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1, curve: Curves.decelerate),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSearch(
    AnchoredOverlayController controller,
    bool isOnTop,
    Widget embeddedSearch,
  ) => _SearchWrapper(
    width: controller.width,
    showDivider: widget.items.isNotEmpty,
    isOnTop: isOnTop,
    child: embeddedSearch,
  );

  Widget _buildList(bool isOnTop, double maxHeight) {
    if (widget.groupBy case final groupBy?) {
      return _GroupedDropdownListView(
        items: widget.items,
        onChanged: widget.onChanged,
        isReversed: isOnTop,
        groupBy: groupBy,
        groupBuilder: widget.groupBuilder,
        maxHeight: maxHeight,
      );
    }

    return _DropdownListView(
      items: widget.items,
      onChanged: widget.onChanged,
      isReversed: isOnTop,
      maxHeight: maxHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AnchoredOverlay.of(context);
    if (controller != null) {
      final isOnTop = controller.top > controller.bottom;
      final listMaxHeight =
          widget.embeddedSearch != null
              ? controller.maxHeight - _embeddedSearchHeight
              : controller.maxHeight;

      final content =
          widget.items.isNotEmpty
              ? Container(
                constraints: BoxConstraints(
                  maxHeight: listMaxHeight,
                  maxWidth: controller.width,
                ),
                child: OptimusScrollConfiguration(
                  child: _buildList(isOnTop, listMaxHeight),
                ),
              )
              : (widget.emptyResultPlaceholder ?? const SizedBox.shrink())
                  .excludeSemantics();
      final children = [
        Material(color: Colors.transparent, child: content),
        if (widget.embeddedSearch case final embeddedSearch?)
          _buildSearch(controller, isOnTop, embeddedSearch),
      ];
      final decoration =
          widget.items.isNotEmpty || widget.emptyResultPlaceholder != null
              ? BoxDecoration(
                borderRadius: BorderRadius.all(tokens.borderRadius100),
                color: tokens.backgroundStaticFloating,
                boxShadow: tokens.shadow200,
              )
              : null;

      return FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          constraints: BoxConstraints(maxHeight: controller.maxHeight),
          width: controller.width,
          decoration: decoration,
          child: SizeTransition(
            sizeFactor: _sizeAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: tokens.spacing50,
              children: isOnTop ? children : children.reversed.toList(),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink().excludeSemantics();
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

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final minHeight = items.length * _itemMinHeight + tokens.spacing100 * 2;

    return SizedBox(
      height: min(minHeight, maxHeight),
      child: ListView.builder(
        reverse: isReversed,
        padding: EdgeInsets.symmetric(vertical: tokens.spacing100),
        itemCount: items.length,
        itemBuilder:
            (context, index) =>
                _DropdownItem(onChanged: onChanged, child: items[index]),
      ),
    );
  }
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
    extends State<_GroupedDropdownListView<T>>
    with ThemeGetter {
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
    if (!listEquals(oldWidget.items, widget.items)) {
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
        if (value1 is Comparable && value2 is Comparable) {
          result = value1.compareTo(value2);
        }
      } else {
        groupsCount++;
      }

      return result;
    });
    _groupsCount = groupsCount;

    return sorted;
  }

  int get _leadingIndex => widget.isReversed ? _sortedItems.length - 1 : 0;

  bool _isSameGroup(
    OptimusDropdownTile<T> first,
    OptimusDropdownTile<T> second,
  ) => widget.groupBy(second.value) == widget.groupBy(first.value);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final minListHeight =
        _groupsCount * _groupMinHeight +
        widget.items.length * _itemMinHeight +
        tokens.spacing100 * 2;

    return SizedBox(
      height: min(minListHeight, widget.maxHeight).toScaled(context),
      child: ListView.builder(
        reverse: widget.isReversed,
        padding: EdgeInsets.symmetric(vertical: tokens.spacing100),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final current = _sortedItems[index];
          final child = _DropdownItem(
            onChanged: widget.onChanged,
            child: current,
          );

          if (index == _leadingIndex) {
            return _GroupWrapper(
              useBorder: false,
              group: _effectiveGroupBuilder(widget.groupBy(current.value)),
              child: child,
            );
          }

          final previous = _sortedItems[index + (widget.isReversed ? 1 : -1)];

          return _isSameGroup(current, previous)
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: tokens.spacing50),
                child: child,
              )
              : _GroupWrapper(
                group: _effectiveGroupBuilder(widget.groupBy(current.value)),
                child: child,
              );
        },
      ),
    );
  }
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

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: useBorder ? context.tokens.spacing50 : context.tokens.spacing0,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: AnchoredOverlay.of(context)?.width,
          decoration:
              useBorder
                  ? BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: context.tokens.borderStaticSecondary,
                      ),
                    ),
                  )
                  : null,
          child: group,
        ),
        child,
      ],
    ),
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
  void _handleItemTap() {
    widget.onChanged(widget.child.value);
    DropdownTapInterceptor.of(context)?.onTap();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: AnchoredOverlay.of(context)?.width,
    height: _itemMinHeight.toScaled(context),
    child: InkWell(
      borderRadius: BorderRadius.all(tokens.borderRadius100),
      onTap: _handleItemTap,
      child: widget.child,
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

class _SearchWrapperState extends State<_SearchWrapper> with ThemeGetter {
  final GlobalKey _searchKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final children = [
      if (widget.showDivider)
        Divider(
          thickness: 1,
          height: 1,
          color: context.tokens.borderStaticPrimary,
        ),
      KeyedSubtree(key: _searchKey, child: widget.child),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.isOnTop ? children : children.reversed.toList(),
    );
  }
}

const _embeddedSearchHeight =
    61.0; // TODO(witwash): calculate to avoid problems with tokens
const _groupMinHeight = 28.0;
const _itemMinHeight = 69.0;
