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

class OptimusSearchFieldDropdown<T> extends StatefulWidget {
  const OptimusSearchFieldDropdown({
    Key key,
    @required this.items,
    @required this.anchorKey,
    @required this.onChanged,
    this.isWidthFixed = false,
  }) : super(key: key);

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onChanged;
  final GlobalKey anchorKey;
  final bool isWidthFixed;

  @override
  _OptimusSearchFieldDropdownState<T> createState() =>
      _OptimusSearchFieldDropdownState<T>();
}

class _OptimusSearchFieldDropdownState<T>
    extends State<OptimusSearchFieldDropdown<T>> {
  Rect _savedRect;

  void _updateRect(dynamic _) {
    final newRect = _calculateRect();
    if (newRect != _savedRect) {
      setState(() {
        _savedRect = newRect;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return Container();

    _savedRect ??= _calculateRect();
    WidgetsBinding.instance.addPostFrameCallback(_updateRect);

    final isOnTop = _topSpace > _bottomSpace;
    final maxHeight = max(_topSpace, _bottomSpace);

    return Stack(
      children: <Widget>[
        // Some problem with AnimatedPosition here:
        // 'package:flutter/src/animation/tween.dart':
        // Failed assertion: line 258 pos 12: 'begin != null': is not true.
        // Switching to Positioned.
        Positioned(
          width: widget.isWidthFixed ? _width : _savedRect.width,
          left: _savedRect.left,
          top: isOnTop ? null : (_offsetTop ?? 0),
          bottom: isOnTop ? (_offsetBottom ?? 0) : null,
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
        widget.anchorKey.currentContext.findRenderObject() as RenderBox;
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

  double get availableRightSpace => _screenWidth - _savedRect.left;

  double get _width =>
      availableRightSpace < _minimumWidgetWidth + _widgetPadding
          ? availableRightSpace - _widgetPadding
          : _minimumWidgetWidth;
}

class _DropdownItem<T> extends StatefulWidget {
  const _DropdownItem({
    Key key,
    @required this.child,
    @required this.onChanged,
  }) : super(key: key);

  final OptimusDropdownTile<T> child;
  final ValueSetter<T> onChanged;

  @override
  _DropdownItemState<T> createState() => _DropdownItemState();
}

class _DropdownItemState<T> extends State<_DropdownItem<T>> {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) => InkWell(
        highlightColor: OptimusColors.primary,
        onHighlightChanged: (isHighlighted) =>
            setState(() => _isHighlighted = isHighlighted),
        onTap: () {
          widget.onChanged(widget.child.value);
          DropdownTapInterceptor.of(context).onTap();
        },
        child: _isHighlighted
            ? DefaultTextStyle.merge(
                style: const TextStyle(color: OptimusColors.neutral0),
                child: widget.child,
              )
            : widget.child,
      );
}

const _dropdownDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(borderRadius50),
  color: Colors.white,
  boxShadow: elevation50,
);

const double _screenPadding = spacing200;
const double _widgetPadding = spacing100;
const double _minimumWidgetWidth = 300;
