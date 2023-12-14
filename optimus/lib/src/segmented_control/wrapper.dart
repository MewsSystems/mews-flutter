import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class BorderWrapper extends StatefulWidget {
  const BorderWrapper({
    super.key,
    required this.child,
    required this.size,
    required this.selectedItemIndex,
    required this.listSize,
    required this.isEnabled,
  });

  final Widget child;

  final OptimusWidgetSize size;

  final int selectedItemIndex;

  final int listSize;

  final bool isEnabled;

  @override
  State<BorderWrapper> createState() => _BorderWrapperState();
}

class _BorderWrapperState extends State<BorderWrapper> with ThemeGetter {
  List<Widget> _dividers(double maxWidth) =>
      Iterable<int>.generate(widget.listSize - 1)
          .map(
            (e) => IgnorePointer(
              child: Container(
                height: widget.size.value,
                width: maxWidth / widget.listSize,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: theme.colors.neutral100),
                  ),
                ),
              ),
            ),
          )
          .toList();

  double _left(double maxWidth) {
    final leftPosition =
        (maxWidth / widget.listSize) * widget.selectedItemIndex;

    return switch (_position) {
      _ItemPosition.first => leftPosition,
      _ItemPosition.inBetween ||
      _ItemPosition.last =>
        leftPosition - _borderWidth,
    };
  }

  double _width(double maxWidth) {
    final itemWidth = maxWidth / widget.listSize;

    return switch (_position) {
      _ItemPosition.first => itemWidth,
      _ItemPosition.inBetween || _ItemPosition.last => itemWidth + _borderWidth,
    };
  }

  BorderRadiusGeometry get _borderRadius {
    final borderRadius = Radius.circular(tokens.borderRadius50);

    return switch (_position) {
      _ItemPosition.first => BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
        ),
      _ItemPosition.inBetween => BorderRadius.zero,
      _ItemPosition.last => BorderRadius.only(
          topRight: borderRadius,
          bottomRight: borderRadius,
        ),
    };
  }

  _ItemPosition get _position {
    if (widget.selectedItemIndex == 0) {
      return _ItemPosition.first;
    } else if (widget.selectedItemIndex == widget.listSize - 1) {
      return _ItemPosition.last;
    }

    return _ItemPosition.inBetween;
  }

  Color get _borderColor =>
      widget.isEnabled ? theme.colors.primary500 : theme.colors.neutral100;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Container(
              height: widget.size.value,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(context.tokens.borderRadius50),
                border: Border.all(color: theme.colors.neutral100),
              ),
              child: widget.child,
            ),
            Row(children: _dividers(constraints.maxWidth)),
            Positioned(
              left: _left(constraints.maxWidth),
              child: IgnorePointer(
                child: Container(
                  width: _width(constraints.maxWidth),
                  height: widget.size.value,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: _borderRadius,
                    border: Border.all(color: _borderColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

enum _ItemPosition { first, inBetween, last }

const _borderWidth = 1;
