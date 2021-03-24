import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/group_wrapper.dart';
import 'package:optimus/src/segmented_control/wrapper.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusSegmentedControl<T> extends StatelessWidget {
  OptimusSegmentedControl({
    Key? key,
    this.size = OptimusWidgetSize.large,
    required this.items,
    required this.value,
    required this.onItemSelected,
    this.label,
    this.error,
    this.isEnabled = true,
    this.isRequired = false,
  })  : assert(
          items.map((i) => i.value).contains(value),
          'Segmented control should always have some existing value',
        ),
        super(key: key);

  final OptimusWidgetSize size;

  final List<OptimusGroupItem<T>> items;

  final T value;

  final ValueChanged<T> onItemSelected;

  final String? label;

  final String? error;

  final bool isEnabled;

  final bool isRequired;

  int get _selectedItemIndex =>
      items.map((i) => i.value).toList().indexOf(value);

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        isRequired: isRequired,
        child: OptimusEnabled(
          isEnabled: isEnabled,
          child: BorderWrapper(
            size: size,
            selectedItemIndex: _selectedItemIndex,
            listSize: items.length,
            child: OptimusStack(
              direction: Axis.horizontal,
              distribution: OptimusStackDistribution.stretch,
              children: items
                  .mapIndexed((i, v) => _OptimusSegmentedControlItem<T>(
                        value: v.value,
                        size: size,
                        groupValue: value,
                        onItemSelected: onItemSelected,
                        child: v.label,
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}

class _OptimusSegmentedControlItem<T> extends StatefulWidget {
  const _OptimusSegmentedControlItem({
    Key? key,
    required this.child,
    required this.size,
    required this.value,
    required this.groupValue,
    required this.onItemSelected,
  }) : super(key: key);

  final Widget child;

  final OptimusWidgetSize size;

  final T value;

  final T groupValue;

  final ValueChanged<T> onItemSelected;

  @override
  _OptimusSegmentedControlItemState<T> createState() =>
      _OptimusSegmentedControlItemState<T>();
}

class _OptimusSegmentedControlItemState<T>
    extends State<_OptimusSegmentedControlItem<T>> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  bool get _isSelected => widget.value == widget.groupValue;

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  void _onChanged() {
    if (!_isSelected) {
      widget.onItemSelected(widget.value);
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
            color: _color,
            height: widget.size.value,
            child: Stack(
              clipBehavior: Clip.none,
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
                    style: preset300s.copyWith(color: theme.colors.neutral900),
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

  Color? get _color => _isHovering || _isTappedDown
      ? theme.colors.primary500t8
      : Colors.transparent;
}
