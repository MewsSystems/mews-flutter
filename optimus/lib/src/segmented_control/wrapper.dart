import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';

class BorderWrapper extends StatefulWidget {
  const BorderWrapper({
    Key? key,
    required this.child,
    required this.size,
    required this.selectedItemIndex,
    required this.listSize,
  }) : super(key: key);

  final Widget child;

  final OptimusWidgetSize size;

  final int selectedItemIndex;

  final int listSize;

  @override
  _BorderWrapperState createState() => _BorderWrapperState();
}

class _BorderWrapperState extends State<BorderWrapper> with ThemeGetter {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              height: widget.size.value,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(borderRadius50),
                border: Border.all(color: theme.colors.neutral100),
              ),
              child: widget.child,
            ),
            Row(children: _dividers(constraints.maxWidth)),
            Positioned(
              left: _left(constraints.maxWidth),
              child: IgnorePointer(
                ignoring: true,
                child: Container(
                  width: _width(constraints.maxWidth),
                  height: widget.size.value,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: _borderRadius,
                    border: Border.all(color: theme.colors.primary500),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  List<Widget> _dividers(double maxWidth) =>
      Iterable<int>.generate(widget.listSize - 1)
          .map((e) => IgnorePointer(
                ignoring: true,
                child: Container(
                  height: widget.size.value,
                  width: maxWidth / widget.listSize,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: theme.colors.neutral100),
                    ),
                  ),
                ),
              ))
          .toList();

  double _left(double maxWidth) {
    final position = _position(widget.selectedItemIndex);
    final leftPosition =
        (maxWidth / widget.listSize) * widget.selectedItemIndex;

    switch (position) {
      case _ItemPosition.first:
        return leftPosition;
      case _ItemPosition.inBetween:
      case _ItemPosition.last:
        return leftPosition - _borderWidth;
    }
  }

  double _width(double maxWidth) {
    final position = _position(widget.selectedItemIndex);
    final itemWidth = maxWidth / widget.listSize;

    switch (position) {
      case _ItemPosition.first:
        return itemWidth;
      case _ItemPosition.inBetween:
      case _ItemPosition.last:
        return itemWidth + _borderWidth;
    }
  }

  BorderRadiusGeometry get _borderRadius {
    final position = _position(widget.selectedItemIndex);

    switch (position) {
      case _ItemPosition.first:
        return const BorderRadius.only(
          topLeft: borderRadius50,
          bottomLeft: borderRadius50,
        );
      case _ItemPosition.inBetween:
        return const BorderRadius.all(borderRadius0);
      case _ItemPosition.last:
        return const BorderRadius.only(
          topRight: borderRadius50,
          bottomRight: borderRadius50,
        );
    }
  }

  _ItemPosition _position(int index) {
    if (index == 0) {
      return _ItemPosition.first;
    } else if (index == widget.listSize - 1) {
      return _ItemPosition.last;
    }
    return _ItemPosition.inBetween;
  }
}

enum _ItemPosition { first, inBetween, last }

const _borderWidth = 1;
