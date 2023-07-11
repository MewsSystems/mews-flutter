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

  /// {@template optimus.checkbox.label}
  /// Label displayed next to checkbox.
  ///
  /// Typically a [Text] widget.
  /// {@endtemplate}
  final Widget label;

  /// {@template optimus.checkbox.isChecked}
  /// Whether this checkbox is checked.
  /// {@endtemplate}
  final bool? isChecked;

  /// {@template optimus.checkbox.tristate}
  /// Whether this checkbox has 3 states.
  /// {@endtemplate}
  final bool tristate;

  /// {@template optimus.checkbox.error}
  /// Controls error that appears below checkbox.
  /// {@endtemplate}
  final String? error;

  /// {@template optimus.checkbox.isEnabled}
  /// Whether this widget is enabled.
  /// {@endtemplate}
  final bool isEnabled;

  /// {@template optimus.checkbox.size}
  /// Controls size of the label.
  /// {@endtemplate}
  final OptimusCheckboxSize size;

  /// {@template optimus.checkbox.onChanged}
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
  /// {@endtemplate}
  final ValueChanged<bool> onChanged;

  @override
  State<OptimusCheckbox> createState() => _OptimusCheckboxState();
}

class _OptimusCheckboxState extends State<OptimusCheckbox> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  _CheckboxState get _state => widget.isChecked.toState;

  _InteractionState get _interactionState {
    if (!widget.isEnabled) return _InteractionState.disabled;
    if (_isTappedDown) return _InteractionState.active;
    if (_isHovering) return _InteractionState.hover;

    return _InteractionState.basic;
  }

  Color get _labelColor => widget.isEnabled
      ? theme.tokens.textStaticPrimary
      : theme.tokens.textDisabled;

  TextStyle get _labelStyle => switch (widget.size) {
        OptimusCheckboxSize.large => preset300s.copyWith(color: _labelColor),
        OptimusCheckboxSize.small => preset200s.copyWith(color: _labelColor),
      };

  bool get _isError {
    final error = widget.error;

    return error != null && error.isNotEmpty;
  }

  void _onTap() {
    final newValue = widget.isChecked ?? false;
    widget.onChanged.call(!newValue);
  }

  void _onHoverChanged(bool hovered) => setState(() => _isHovering = hovered);

  @override
  Widget build(BuildContext context) {
    final label = Padding(
      padding: const EdgeInsets.fromLTRB(
        spacing150,
        spacing50,
        spacing0,
        spacing50,
      ),
      child: DefaultTextStyle.merge(style: _labelStyle, child: widget.label),
    );

    return IgnorePointer(
      ignoring: !widget.isEnabled,
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    decoration: BoxDecoration(
                      color: _interactionState._fillColor(context, _state),
                      border: _state.isUnchecked
                          ? Border.all(
                              color: _isError
                                  ? theme.tokens.borderInteractiveError
                                  : _interactionState._borderColor(context),
                              width: 1,
                            )
                          : null,
                      borderRadius: const BorderRadius.all(borderRadius25),
                    ),
                    width: 16,
                    height: 16,
                    child: _CheckboxIcon(
                      icon: _state.icon,
                      isEnabled: widget.isEnabled,
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
  const _CheckboxIcon({this.icon, required this.isEnabled});

  final IconData? icon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => icon == null
      ? const SizedBox.shrink()
      : Center(
          child: Icon(
            icon,
            size: 10,
            color: isEnabled
                ? context.tokens.textStaticInverse
                : context.tokens.textDisabled,
          ),
        );
}

enum _CheckboxState { checked, unchecked, undetermined }

extension on _CheckboxState {
  IconData? get icon => switch (this) {
        _CheckboxState.checked => OptimusIcons.done,
        _CheckboxState.unchecked => null,
        _CheckboxState.undetermined => OptimusIcons.minus_simple,
      };

  bool get isUnchecked => this == _CheckboxState.unchecked;
}

enum _InteractionState { basic, hover, active, disabled }

extension on _InteractionState {
  Color _fillColor(BuildContext context, _CheckboxState state) =>
      switch (this) {
        _InteractionState.basic => state.isUnchecked
            ? context.tokens.backgroundInteractiveSubtleDefault
            : context.tokens.backgroundInteractivePrimaryDefault,
        _InteractionState.hover => state.isUnchecked
            ? context.tokens.backgroundInteractiveSubtleHover
            : context.tokens.backgroundInteractivePrimaryHover,
        _InteractionState.active => state.isUnchecked
            ? context.tokens.backgroundInteractiveSubtleActive
            : context.tokens.backgroundInteractivePrimaryActive,
        _InteractionState.disabled => state.isUnchecked
            ? context.tokens.backgroundStaticFlat
            : context.tokens.backgroundDisabled,
      };

  Color _borderColor(BuildContext context) => switch (this) {
        _InteractionState.basic =>
          context.tokens.borderInteractiveSecondaryDefault,
        _InteractionState.hover =>
          context.tokens.borderInteractiveSecondaryHover,
        _InteractionState.active =>
          context.tokens.borderInteractiveSecondaryActive,
        _InteractionState.disabled => context.tokens.borderDisabled,
      };
}

extension on bool? {
  _CheckboxState get toState => switch (this) {
        true => _CheckboxState.checked,
        false => _CheckboxState.unchecked,
        null => _CheckboxState.undetermined,
      };
}
