import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';
import 'package:optimus/src/typography/presets.dart';

/// The Checkbox + Label component is available in two size
/// variants to accommodate different environments with different requirements.
enum OptimusCheckboxSize {
  /// A checkbox with a large label is the most generally used across all
  /// the products and platforms and is considered the default option.
  large,

  /// A checkbox with a small label is intended for content-heavy environments
  /// and/or small mobile viewports.
  small,
}

/// A checkbox is a binary form of input and is used to let a user select one
/// or more options for a limited number of choices. Each selection is
/// independent (with exceptions). If [tristate] is enabled, checkbox can be in
/// three states: checked, unchecked and indeterminate.
class OptimusCheckbox extends StatefulWidget {
  const OptimusCheckbox({
    super.key,
    required this.label,
    this.isChecked = false,
    this.error,
    this.isEnabled = true,
    this.size = OptimusCheckboxSize.large,
    this.tristate = false,
    required this.onChanged,
  }) : assert(
          tristate || isChecked != null,
          'isChecked must be set if tristate is false',
        );

  /// Label displayed next to checkbox.
  ///
  /// Typically a [Text] widget.
  final Widget label;

  /// Whether this checkbox is checked.
  final bool? isChecked;

  /// Whether this checkbox has 3 states.
  final bool tristate;

  /// Controls error that appears below checkbox.
  final String? error;

  /// Whether this widget is enabled.
  final bool isEnabled;

  /// Controls size of the label.
  final OptimusCheckboxSize size;

  /// Called when the user clicks on this check button.
  ///
  /// The checkbox button passes `value` as a parameter to this callback.
  /// The checkbox button does not actually change state until the parent
  /// widget rebuilds the checkbox button with the new `value`.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method;
  /// for example:
  ///
  /// ```dart
  /// OptimusCheckbox(
  ///   isChecked: _checked,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _checked = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  @override
  State<OptimusCheckbox> createState() => _OptimusCheckboxState();
}

class _OptimusCheckboxState extends State<OptimusCheckbox> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  Color get _borderColor {
    switch (_state) {
      case _CheckboxState.checked:
      case _CheckboxState.undetermined:
        return theme.colors.primary500;
      case _CheckboxState.unchecked:
        return _isHovering || _isTappedDown
            ? theme.colors.primary500
            : theme.colors.neutral100;
    }
  }

  Color get _backgroundColor {
    switch (_state) {
      case _CheckboxState.undetermined:
      case _CheckboxState.checked:
        return theme.colors.primary500;
      case _CheckboxState.unchecked:
        return _isHovering || _isTappedDown
            ? theme.colors.primary500t8
            : Colors.transparent;
    }
  }

  _CheckboxState get _state => widget.isChecked.toState;

  TextStyle get _labelStyle {
    final color = theme.colors.defaultTextColor;
    switch (widget.size) {
      case OptimusCheckboxSize.large:
        return preset300s.copyWith(color: color);
      case OptimusCheckboxSize.small:
        return preset200s.copyWith(color: color);
    }
  }

  void _onTap() {
    final newValue = widget.isChecked ?? false;
    widget.onChanged.call(!newValue);
  }

  void _onHoverChanged(bool hovered) {
    setState(() => _isHovering = hovered);
  }

  @override
  Widget build(BuildContext context) {
    final label = Padding(
      padding: const EdgeInsets.fromLTRB(
        spacing100,
        spacing50,
        spacing0,
        spacing50,
      ),
      child: DefaultTextStyle.merge(style: _labelStyle, child: widget.label),
    );

    return OptimusEnabled(
      isEnabled: widget.isEnabled,
      child: GroupWrapper(
        error: widget.error,
        child: GestureDetector(
          onTap: _onTap,
          onTapDown: (_) => setState(() => _isTappedDown = true),
          onTapUp: (_) => setState(() => _isTappedDown = false),
          onTapCancel: () => setState(() => _isTappedDown = false),
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _backgroundColor,
                      border: Border.all(color: _borderColor, width: 1),
                      borderRadius: const BorderRadius.all(borderRadius25),
                    ),
                    width: 16,
                    height: 16,
                    child: _CheckboxIcon(
                      icon: _state.icon,
                    ),
                  ),
                ),
                Expanded(child: label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckboxIcon extends StatelessWidget {
  const _CheckboxIcon({this.icon});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return icon == null
        ? const SizedBox.shrink()
        : Center(
            child: Icon(
              icon,
              size: 10,
              color: theme.colors.neutral0,
            ),
          );
  }
}

enum _CheckboxState { checked, unchecked, undetermined }

extension on _CheckboxState {
  IconData? get icon {
    switch (this) {
      case _CheckboxState.checked:
        return OptimusIcons.done;
      case _CheckboxState.unchecked:
        return null;
      case _CheckboxState.undetermined:
        return OptimusIcons.minus_simple;
    }
  }
}

extension on bool? {
  _CheckboxState get toState {
    switch (this) {
      case true:
        return _CheckboxState.checked;
      case false:
        return _CheckboxState.unchecked;
      default:
        return _CheckboxState.undetermined;
    }
  }
}
