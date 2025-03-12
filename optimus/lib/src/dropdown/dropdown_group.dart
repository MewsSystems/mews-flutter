import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/common.dart';
import 'package:optimus/src/dropdown/dropdown_item.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
// import 'package:optimus/src/dropdown/dropdown_list.dart';

class DropdownGroupedListView<T> extends StatefulWidget {
  const DropdownGroupedListView({
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
  State<DropdownGroupedListView<T>> createState() =>
      _DropdownGroupedListViewState<T>();
}

class _DropdownGroupedListViewState<T> extends State<DropdownGroupedListView<T>>
    with ThemeGetter {
  late List<OptimusDropdownTile<T>> _sortedItems;
  late int _groupsCount;

  @override
  void initState() {
    super.initState();
    _sortedItems = _sortItems();
  }

  @override
  void didUpdateWidget(DropdownGroupedListView<T> oldWidget) {
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
        widget.items.length * itemMinHeight +
        tokens.spacing100 * 2;

    return SizedBox(
      height: min(minListHeight, widget.maxHeight),
      child: ListView.builder(
        reverse: widget.isReversed,
        padding: EdgeInsets.symmetric(vertical: tokens.spacing100),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final current = _sortedItems[index];
          final child = DropdownItem(
            width: AnchoredOverlay.of(context)?.width,
            height: itemMinHeight,
            onTap: () {
              widget.onChanged(current.value);
              DropdownTapInterceptor.of(context)?.onTap();
            },
            child: current,
          );

          if (index == _leadingIndex) {
            return DropdownGroupWrapper(
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
              : DropdownGroupWrapper(
                group: _effectiveGroupBuilder(widget.groupBy(current.value)),
                child: child,
              );
        },
      ),
    );
  }
}

class DropdownGroupWrapper extends StatelessWidget {
  const DropdownGroupWrapper({
    super.key,
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

const _groupMinHeight = 28.0;
