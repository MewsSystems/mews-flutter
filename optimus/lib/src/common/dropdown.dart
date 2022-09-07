import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';

class OptimusDropdown<T> extends StatelessWidget {
  const OptimusDropdown({
    Key? key,
    required this.items,
    required this.anchorKey,
    required this.onChanged,
    this.width,
  }) : super(key: key);

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onChanged;
  final GlobalKey anchorKey;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return Container();

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        // Some problem with AnimatedPosition here:
        // 'package:flutter/src/animation/tween.dart':
        // Failed assertion: line 258 pos 12: 'begin != null': is not true.
        // Switching to Positioned.
        AnchoredOverlay(
          anchorKey: anchorKey,
          width: width,
          child: _DropdownContent(
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _DropdownContent<T> extends StatelessWidget {
  const _DropdownContent({
    Key? key,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;

  // TODO(VG): can be changed when final dark theme design is ready.
  BoxDecoration _dropdownDecoration(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return BoxDecoration(
      borderRadius: const BorderRadius.all(borderRadius50),
      color: theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
      boxShadow: elevation50,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AnchoredOverlay.of(context);
    if (controller != null) {
      final isOnTop = controller.topSpace > controller.bottomSpace;

      return Container(
        decoration: _dropdownDecoration(context),
        constraints: BoxConstraints(
          maxHeight: controller.maxHeight,
        ),
        child: _DropdownListView(
          items: items,
          onChanged: onChanged,
          isReversed: isOnTop,
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
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: OptimusScrollConfiguration(
          child: ListView.builder(
            reverse: isReversed,
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) => _DropdownItem(
              onChanged: onChanged,
              child: items[index],
            ),
          ),
        ),
      );
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
