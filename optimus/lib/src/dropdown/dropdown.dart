import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/elevation.dart';

class OptimusDropdown<T> extends StatelessWidget {
  const OptimusDropdown({
    super.key,
    required this.items,
    required this.anchorKey,
    required this.onChanged,
    this.width,
    this.embeddedSearch,
    this.emptyResultPlaceholder,
  });

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onChanged;
  final GlobalKey anchorKey;
  final double? width;
  final Widget? embeddedSearch;
  final Widget? emptyResultPlaceholder;

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
  });

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final Widget? embeddedSearch;
  final Widget? emptyResultPlaceholder;

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
                child: _DropdownListView(
                  items: items,
                  onChanged: onChanged,
                  isReversed: isOnTop,
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
  });

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: OptimusScrollConfiguration(
          child: ListView.builder(
            reverse: isReversed,
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) =>
                _DropdownItem(onChanged: onChanged, child: items[index]),
          ),
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
