import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/common/scroll.dart';
import 'package:optimus/src/elevation.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';
import 'package:optimus/src/search/dropdown_tile.dart';
import 'package:optimus/src/theme/theme.dart';

class OptimusDropdown<T> extends StatefulWidget {
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
  _OptimusDropdownState<T> createState() => _OptimusDropdownState<T>();
}

class _OptimusDropdownState<T> extends State<OptimusDropdown<T>>
    with ThemeGetter {
  late Rect _savedRect = _calculateRect();

  void _updateRect(dynamic _) {
    if (!mounted) return;
    final newRect = _calculateRect();
    if (newRect != _savedRect) {
      setState(() {
        _savedRect = newRect;
      });
    }
  }

  // TODO(VG): can be changed when final dark theme design is ready.
  BoxDecoration get _dropdownDecoration => BoxDecoration(
        borderRadius: const BorderRadius.all(borderRadius50),
        color: theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
        boxShadow: elevation50,
      );

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return Container();

    WidgetsBinding.instance?.addPostFrameCallback(_updateRect);

    final isOnTop = _topSpace > _bottomSpace;
    final maxHeight = max(_topSpace, _bottomSpace);

    final width = widget.width ?? _savedRect.width;
    final widthWithPadding = width + _widgetPadding;

    // If we have enough space to the right, dropdown's left side will be
    // aligned with anchor's left side. If there's not enough space to the
    // right, but enough space to the left, dropdown's right side will be
    // aligned with anchor's right side. If both conditions fail, left and
    // right will both be null, so dropdown will be aligned according to
    // Stack's alignment property.
    double? left, right;
    if (_rightSpace >= widthWithPadding) {
      left = _savedRect.left;
    } else if (_leftSpace >= widthWithPadding) {
      right = _screenWidth - _savedRect.right;
    }

    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        // Some problem with AnimatedPosition here:
        // 'package:flutter/src/animation/tween.dart':
        // Failed assertion: line 258 pos 12: 'begin != null': is not true.
        // Switching to Positioned.
        Positioned(
          width: width,
          left: left,
          right: right,
          top: isOnTop ? null : _offsetTop,
          bottom: isOnTop ? _offsetBottom : null,
          child: Container(
            decoration: _dropdownDecoration,
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: _buildListView(isOnTop),
          ),
        ),
      ],
    );
  }

  Rect _calculateRect() {
    final RenderBox renderBox =
        widget.anchorKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return renderBox.localToGlobal(Offset.zero) & size;
  }

  Widget _buildListView(bool isReversed) => Material(
        type: MaterialType.transparency,
        child: OptimusScrollConfiguration(
          child: ListView.builder(
            reverse: isReversed,
            padding: const EdgeInsets.symmetric(vertical: spacing100),
            shrinkWrap: true,
            itemCount: widget.items.length,
            itemBuilder: (context, index) => _DropdownItem(
              onChanged: widget.onChanged,
              child: widget.items[index],
            ),
          ),
        ),
      );

  double get _offsetBottom => _screenHeight - _savedRect.top + _widgetPadding;

  double get _offsetTop => _savedRect.top + _savedRect.height + _widgetPadding;

  double get _screenHeight => MediaQuery.of(context).size.height;

  double get _screenWidth => MediaQuery.of(context).size.width;

  double get _paddingBottom =>
      MediaQuery.of(context).viewInsets.bottom + _screenPadding;

  double get _paddingTop => MediaQuery.of(context).padding.top + _screenPadding;

  double get _topSpace => _savedRect.top - _paddingTop;

  double get _bottomSpace => _screenHeight - _paddingBottom - _savedRect.bottom;

  double get _rightSpace => _screenWidth - _savedRect.left;

  double get _leftSpace => _savedRect.right;
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

  @override
  Widget build(BuildContext context) => InkWell(
        highlightColor: theme.colors.primary,
        onHighlightChanged: (isHighlighted) =>
            setState(() => _isHighlighted = isHighlighted),
        onTap: () {
          widget.onChanged(widget.child.value);
          DropdownTapInterceptor.of(context)?.onTap();
        },
        child: DropDownHighlight(
          highlighted: _isHighlighted,
          child: widget.child,
        ),
      );
}

class DropDownHighlight extends InheritedWidget {
  const DropDownHighlight({
    Key? key,
    required this.highlighted,
    required Widget child,
  }) : super(key: key, child: child);

  final bool highlighted;

  static DropDownHighlight of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DropDownHighlight>()!;

  @override
  bool updateShouldNotify(DropDownHighlight oldWidget) =>
      oldWidget.highlighted != highlighted;
}

const double _screenPadding = spacing200;
const double _widgetPadding = spacing100;
