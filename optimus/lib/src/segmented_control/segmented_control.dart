import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';
import 'package:optimus/src/segmented_control/wrapper.dart';
import 'package:optimus/src/typography/presets.dart';

/// Segmented Control is a set of two or more segments, that provide closely
/// related choices that affect an object, state, or view.
class OptimusSegmentedControl<T> extends StatelessWidget {
  OptimusSegmentedControl({
    Key? key,
    this.size = OptimusWidgetSize.large,
    required Iterable<OptimusGroupItem<T>> items,
    required this.value,
    required this.onItemSelected,
    this.label,
    this.error,
    this.isEnabled = true,
    this.isRequired = false,
    this.maxLines,
    this.direction = Axis.horizontal,
  })  : assert(
          items.map((i) => i.value).contains(value),
          'Segmented control should always have some existing value',
        ),
        items = List.unmodifiable(items),
        super(key: key);

  /// Size of the segmented control.
  final OptimusWidgetSize size;

  /// List of segment control items.
  final List<OptimusGroupItem<T>> items;

  /// Current selected value.
  final T value;

  /// Callback that is called when user selects a new item.
  final ValueChanged<T> onItemSelected;

  /// Label of the segmented control.
  final String? label;

  /// Error message that is displayed below the segmented control.
  final String? error;

  /// Whether the segmented control is enabled or not.
  final bool isEnabled;

  /// Whether the segmented control is required or not.
  final bool isRequired;

  /// Direction of the segmented control widget.
  final Axis direction;

  /// Limits the number of lines of the segmented item text. In case of
  /// the [Axis.horizontal] this will be set to 1.
  final int? maxLines;

  late final _selectedItemIndex =
      items.map((i) => i.value).toList().indexOf(value);

  int? get _maxLines => direction == Axis.horizontal ? 1 : maxLines;

  OptimusStackDistribution get _distribution => direction == Axis.horizontal
      ? OptimusStackDistribution.stretch
      : OptimusStackDistribution.basic;

  OptimusStackSpacing get _spacing => direction == Axis.horizontal
      ? OptimusStackSpacing.spacing0
      : OptimusStackSpacing.spacing50;

  Widget _buildGroupWrapper(Widget child) => direction == Axis.horizontal
      ? BorderWrapper(
          size: size,
          selectedItemIndex: _selectedItemIndex,
          listSize: items.length,
          isEnabled: isEnabled,
          child: child,
        )
      : child;

  Widget _buildChildWrapper(int index, OptimusGroupItem<T> value) =>
      direction == Axis.vertical
          ? _SegmentDecoration(
              isEnabled: isEnabled,
              isSelected: index == _selectedItemIndex,
              child: _buildControlItem(value),
            )
          : _buildControlItem(value);

  Widget _buildControlItem(OptimusGroupItem<T> item) =>
      _OptimusSegmentedControlItem<T>(
        value: item.value,
        size: size,
        groupValue: value,
        onItemSelected: onItemSelected,
        isEnabled: isEnabled,
        maxLines: _maxLines,
        child: item.label,
      );

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        isRequired: isRequired,
        child: OptimusEnabled(
          isEnabled: isEnabled,
          child: _buildGroupWrapper(
            OptimusStack(
              direction: direction,
              distribution: _distribution,
              spacing: _spacing,
              children: items.mapIndexed(_buildChildWrapper).toList(),
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
    required this.isEnabled,
    required this.maxLines,
  }) : super(key: key);

  final Widget child;

  final OptimusWidgetSize size;

  final T value;

  final T groupValue;

  final ValueChanged<T> onItemSelected;

  final bool isEnabled;

  final int? maxLines;

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

  Color get _iconColor =>
      widget.isEnabled ? theme.colors.primary500 : theme.colors.neutral100;

  Color? get _color => _isHovering || _isTappedDown
      ? theme.colors.primary500t8
      : Colors.transparent;

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
            constraints: BoxConstraints(minHeight: widget.size.value),
            padding: const EdgeInsets.symmetric(vertical: spacing50),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                if (_isSelected)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: spacing100),
                      child: IconTheme(
                        data: IconThemeData(
                          color: _iconColor,
                          size: 24,
                        ),
                        child: const Icon(OptimusIcons.done),
                      ),
                    ),
                  ),
                Center(
                  child: DefaultTextStyle.merge(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    maxLines: widget.maxLines,
                    style: preset300b.copyWith(
                      color: theme.isDark
                          ? theme.colors.neutral0
                          : theme.colors.neutral900,
                    ),
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
}

class _SegmentDecoration extends StatelessWidget {
  const _SegmentDecoration({
    Key? key,
    required this.child,
    required this.isEnabled,
    required this.isSelected,
  }) : super(key: key);

  final Widget child;
  final bool isEnabled;
  final bool isSelected;

  Color _color(OptimusThemeData theme) => (isEnabled && isSelected)
      ? theme.colors.primary500
      : theme.colors.neutral100;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(borderRadius50),
        border: Border.all(color: _color(theme)),
      ),
      child: child,
    );
  }
}
