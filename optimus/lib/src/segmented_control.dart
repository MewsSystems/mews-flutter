import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/group_wrapper.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusSegmentedControl<T> extends StatefulWidget {
  const OptimusSegmentedControl({
    Key? key,
    this.size = OptimusWidgetSize.large,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.error,
    this.isEnabled = true,
    this.isRequired = false,
  }) : super(key: key);

  final OptimusWidgetSize size;

  final List<OptimusGroupItem<T>> items;

  final T value;

  final ValueChanged<T> onChanged;

  final String? label;

  final String? error;

  final bool isEnabled;

  final bool isRequired;

  @override
  _OptimusSegmentedControlState<T> createState() =>
      _OptimusSegmentedControlState<T>();
}

class _OptimusSegmentedControlState<T>
    extends State<OptimusSegmentedControl<T>> {
  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    return GroupWrapper(
      label: widget.label,
      error: widget.error,
      isRequired: widget.isRequired,
      child: OptimusEnabled(
        isEnabled: widget.isEnabled,
        child: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(borderRadius100),
                  border: Border.all(color: theme.colors.neutral100),
                ),
                child: OptimusStack(
                  direction: Axis.horizontal,
                  distribution: OptimusStackDistribution.stretch,
                  children: widget.items
                      .mapIndexed((i, v) => OptimusSegmentedControlItem<T>(
                            value: v.value,
                            size: widget.size,
                            position: _position(i),
                            groupValue: widget.value,
                            onChanged: (value) {
                              widget.onChanged(value);
                              _selectedItemIndex = i;
                            },
                            child: v.label,
                          ))
                      .toList(),
                ),
              ),
              Positioned(
                left: (constraints.maxWidth / widget.items.length) *
                    _selectedItemIndex,
                child: IgnorePointer(
                  ignoring: true,
                  child: Container(
                    width: constraints.maxWidth / widget.items.length,
                    height: widget.size.value + 2,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(borderRadius100),
                      border: Border.all(color: theme.colors.danger500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ItemPosition _position(int index) {
    if (index == 0) {
      return _ItemPosition.first;
    } else if (index == widget.items.length - 1) {
      return _ItemPosition.last;
    }
    return _ItemPosition.inBetween;
  }
}

class OptimusSegmentedControlItem<T> extends StatefulWidget {
  const OptimusSegmentedControlItem({
    Key? key,
    required this.child,
    required this.size,
    required this.position,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final Widget child;

  final OptimusWidgetSize size;

  final _ItemPosition position;

  final T value;

  final T groupValue;

  final ValueChanged<T> onChanged;

  @override
  _OptimusSegmentedControlItemState<T> createState() =>
      _OptimusSegmentedControlItemState<T>();
}

class _OptimusSegmentedControlItemState<T>
    extends State<OptimusSegmentedControlItem<T>> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  bool get _isSelected => widget.value == widget.groupValue;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  void _onChanged() {
    if (!_isSelected) {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => _onHoverChanged(true),
        onExit: (_) => _onHoverChanged(false),
        child: GestureDetector(
          onTap: _onChanged,
          onTapDown: (_) => setState(() => _isTappedDown = true),
          onTapUp: (_) => setState(() => _isTappedDown = false),
          onTapCancel: () => setState(() => _isTappedDown = false),
          child: Container(
            height: widget.size.value,
            child: Stack(
              children: [
                if (_isSelected)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: spacing100),
                      child: OptimusIcon(
                        iconData: OptimusIcons.done,
                        colorOption: OptimusColorOption.primary,
                      ),
                    ),
                  ),
                Center(
                  child: DefaultTextStyle.merge(
                    overflow: TextOverflow.ellipsis,
                    style: preset300s.copyWith(color: _textColor),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: spacing500,
                      ),
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  BorderRadiusGeometry get _borderRadius {
    switch (widget.position) {
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

  Color get _textColor => _isSelected
      ? theme.isDark
          ? theme.colors.neutral0
          : theme.colors.neutral1000
      : theme.colors.neutral100;

  Color get _borderColor =>
      _isSelected ? theme.colors.primary500 : theme.colors.neutral100;

  Color? get _color =>
      _isHovering || _isTappedDown ? theme.colors.primary500t8 : null;
}

enum _ItemPosition { first, inBetween, last }
