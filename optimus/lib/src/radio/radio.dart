import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';
import 'package:optimus/src/typography/presets.dart';

/// The radio component is available in two size variants to accommodate
/// different environments with different requirements.
enum OptimusRadioSize {
  ///  A radio with a small label is intended for content-heavy environments
  ///  and/or small mobile viewports.
  small,

  /// A radio with a large label is the most used across all products and
  /// platforms and is considered the default option.
  large,
}

/// The radio is a binary form of input used in a list of mutually exclusive
/// options. Users can make only one selection in a list at any given time.
class OptimusRadio<T> extends StatefulWidget {
  const OptimusRadio({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = OptimusRadioSize.large,
    this.error,
    this.isEnabled = true,
  });

  /// Controls label.
  final Widget label;

  /// Controls the value represented by this radio button.
  final T value;

  /// Controls the currently selected value for a group of radio buttons.
  ///
  /// This radio button is considered selected if its [value] matches the
  /// [groupValue].
  final T groupValue;

  /// Called when the user selects this radio button.
  ///
  /// The radio button passes [value] as a parameter to this callback. The radio
  /// button does not actually change state until the parent widget rebuilds the
  /// radio button with the new [groupValue].
  ///
  /// [onChanged] will not be invoked if this radio button is already selected.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method;
  /// for example:
  ///
  /// ```dart
  /// Radio<String>(
  ///   value: 'Option A',
  ///   groupValue: _groupValue,
  ///   onChanged: (String newValue) {
  ///     setState(() {
  ///       _groupValue = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<T> onChanged;

  /// Controls size.
  final OptimusRadioSize size;

  /// Controls error.
  final String? error;

  /// Controls if the widget is enabled.
  final bool isEnabled;

  @override
  State<OptimusRadio<T>> createState() => _OptimusRadioState<T>();
}

class _OptimusRadioState<T> extends State<OptimusRadio<T>> with ThemeGetter {
  bool _isHovering = false;
  bool _isTappedDown = false;

  bool get _isSelected => widget.value == widget.groupValue;

  Color get _textColor => widget.isEnabled
      ? theme.tokens.textStaticPrimary
      : theme.tokens.textDisabled;

  TextStyle get _labelStyle => switch (widget.size) {
        OptimusRadioSize.small => preset200s.copyWith(color: _textColor),
        OptimusRadioSize.large => preset300s.copyWith(color: _textColor),
      };

  void _onHoverChanged(bool isHovering) =>
      setState(() => _isHovering = isHovering);

  void _onChanged() {
    if (!_isSelected) {
      widget.onChanged(widget.value);
    }
  }

  _RadioState get _state {
    if (!widget.isEnabled) return _RadioState.disabled;
    if (_isTappedDown) return _RadioState.active;
    if (_isHovering) return _RadioState.hover;

    return _RadioState.basic;
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        error: widget.error,
        child: IgnorePointer(
          ignoring: !widget.isEnabled,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: _onChanged,
              onTapDown: (_) => setState(() => _isTappedDown = true),
              onTapUp: (_) => setState(() => _isTappedDown = false),
              onTapCancel: () => setState(() => _isTappedDown = false),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    width: _leadingSize,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: _RadioCircle(
                        state: _state,
                        isSelected: _isSelected,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: _leadingSize,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: _leadingSize),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: spacing25,
                            ),
                            child: DefaultTextStyle.merge(
                              style: _labelStyle,
                              child: widget.label,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _RadioCircle extends StatelessWidget {
  const _RadioCircle({
    required this.state,
    required this.isSelected,
  });

  final _RadioState state;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: spacing100,
          bottom: spacing100,
          right: spacing200,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: isSelected ? 6 : 1.5,
              color: state.borderColor(context, isSelected: isSelected),
            ),
            color: state.circleFillColor(context),
          ),
        ),
      );
}

enum _RadioState { basic, hover, active, disabled }

extension on _RadioState {
  Color borderColor(BuildContext context, {required bool isSelected}) =>
      switch (this) {
        _RadioState.basic => isSelected
            ? context.tokens.backgroundInteractivePrimaryDefault
            : context.tokens.borderInteractiveSecondaryDefault,
        _RadioState.hover => isSelected
            ? context.tokens.backgroundInteractivePrimaryHover
            : context.tokens.borderInteractiveSecondaryHover,
        _RadioState.active => isSelected
            ? context.tokens.backgroundInteractivePrimaryActive
            : context.tokens.borderInteractiveSecondaryActive,
        _RadioState.disabled => isSelected
            ? context.tokens.backgroundDisabled
            : context.tokens.borderDisabled,
      };

  Color circleFillColor(BuildContext context) => switch (this) {
        _RadioState.basic ||
        _RadioState.disabled =>
          context.tokens.backgroundInteractiveNeutralSubtleDefault,
        _RadioState.hover =>
          context.tokens.backgroundInteractiveNeutralSubtleHover,
        _RadioState.active =>
          context.tokens.backgroundInteractiveNeutralSubtleActive,
      };
}

const double _leadingSize = 32;
