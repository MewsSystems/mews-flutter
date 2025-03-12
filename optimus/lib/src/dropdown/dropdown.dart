import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/dropdown_group.dart';
import 'package:optimus/src/dropdown/dropdown_list.dart';
import 'package:optimus/src/dropdown/dropdown_size_data.dart';

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
  ) => DropdownSearchWrapper(
    width: controller.width,
    showDivider: widget.items.isNotEmpty,
    isOnTop: isOnTop,
    child: embeddedSearch,
  );

  Widget _buildList(bool isOnTop, double maxHeight) {
    if (widget.groupBy case final groupBy?) {
      return DropdownGroupedListView(
        items: widget.items,
        onChanged: widget.onChanged,
        isReversed: isOnTop,
        groupBy: groupBy,
        groupBuilder: widget.groupBuilder,
        maxHeight: maxHeight,
      );
    }

    return DropdownListView(
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
              : (widget.emptyResultPlaceholder ?? const SizedBox.shrink());
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
            child: Padding(
              padding: EdgeInsets.all(tokens.spacing100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: tokens.spacing50,
                children: isOnTop ? children : children.reversed.toList(),
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

const _embeddedSearchHeight =
    61.0; // TODO(witwash): calculate to avoid problems with tokens
