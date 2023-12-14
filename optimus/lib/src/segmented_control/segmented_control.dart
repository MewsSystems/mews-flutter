import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/group_wrapper.dart';
import 'package:optimus/src/typography/presets.dart';

/// Segmented Control is a set of two or more segments, that provide closely
/// related choices that affect an object, state, or view.
class OptimusSegmentedControl<T> extends StatelessWidget {
  OptimusSegmentedControl({
    super.key,
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
        items = List.unmodifiable(items);

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

  int? get _maxLines => direction == Axis.horizontal ? 1 : maxLines;

  OptimusStackDistribution get _distribution => direction == Axis.horizontal
      ? OptimusStackDistribution.stretch
      : OptimusStackDistribution.basic;

  OptimusStackSpacing get _spacing => direction == Axis.horizontal
      ? OptimusStackSpacing.spacing0
      : OptimusStackSpacing.spacing50;

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        isRequired: isRequired,
        child: OptimusEnabled(
          isEnabled: isEnabled,
          child: DecoratedBox(
            decoration: direction == Axis.horizontal
                ? BoxDecoration(
                    color: OptimusTheme.of(context)
                        .tokens
                        .backgroundInteractiveNeutralDefault,
                    borderRadius:
                        BorderRadius.circular(context.tokens.borderRadius100),
                  )
                : const BoxDecoration(),
            child: OptimusStack(
              direction: direction,
              distribution: _distribution,
              spacing: _spacing,
              children: items
                  .map(
                    (item) => _OptimusSegmentedControlItem<T>(
                      value: item.value,
                      size: size,
                      groupValue: value,
                      onItemSelected: onItemSelected,
                      isEnabled: isEnabled,
                      maxLines: _maxLines,
                      child: item.label,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
}

class _OptimusSegmentedControlItem<T> extends StatefulWidget {
  const _OptimusSegmentedControlItem({
    super.key,
    required this.child,
    required this.size,
    required this.value,
    required this.groupValue,
    required this.onItemSelected,
    required this.isEnabled,
    required this.maxLines,
  });

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
  bool _isPressed = false;

  bool get _isSelected => widget.value == widget.groupValue;

  void _handleHoverChanged(bool isHovering) =>
      setState(() => _isHovering = isHovering);

  void _handlePressedChanged(bool isPressed) =>
      setState(() => _isPressed = isPressed);

  void _handleChanged() {
    if (!_isSelected) {
      widget.onItemSelected(widget.value);
    }
  }

  Color _color(OptimusTokens tokens) {
    if (!widget.isEnabled) return tokens.backgroundInteractiveNeutralDefault;
    if (_isPressed) return tokens.backgroundInteractiveNeutralActive;
    if (_isHovering) return tokens.backgroundInteractiveNeutralHover;

    return _isSelected
        ? tokens.backgroundStaticFlat
        : tokens.backgroundInteractiveNeutralDefault;
  }

  Color _foregroundColor(OptimusTokens tokens) {
    if (!widget.isEnabled) return tokens.textDisabled;

    return (_isSelected || _isHovering || _isPressed)
        ? tokens.textStaticPrimary
        : tokens.textStaticTertiary;
  }

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;

    return LayoutBuilder(
      builder: (context, constrains) => GestureWrapper(
        onTap: _handleChanged,
        onHoverChanged: _handleHoverChanged,
        onPressedChanged: _handlePressedChanged,
        child: Padding(
          padding: const EdgeInsets.all(spacing25),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            constraints: BoxConstraints(minHeight: widget.size.value),
            padding: const EdgeInsets.symmetric(vertical: spacing50),
            decoration: BoxDecoration(
              color: _color(tokens),
              borderRadius:
                  BorderRadius.circular(context.tokens.borderRadius100),
            ),
            alignment: Alignment.center,
            child: DefaultTextStyle.merge(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: widget.maxLines,
              style: preset200s.copyWith(color: _foregroundColor(tokens)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constrains.adaptivePadding,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on BoxConstraints {
  double get adaptivePadding => maxWidth < 300 ? spacing100 : spacing200;
}
