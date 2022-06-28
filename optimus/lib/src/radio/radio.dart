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
    Key? key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.size = OptimusRadioSize.large,
    this.error,
    this.isEnabled = true,
  }) : super(key: key);

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

  TextStyle get _labelStyle {
    final color = theme.colors.defaultTextColor;
    switch (widget.size) {
      case OptimusRadioSize.small:
        return preset200s.copyWith(color: color);
      case OptimusRadioSize.large:
        return preset300s.copyWith(color: color);
    }
  }

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
  }

  void _onChanged() {
    if (!_isSelected) {
      widget.onChanged(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        error: widget.error,
        child: OptimusEnabled(
          isEnabled: widget.isEnabled,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: _onChanged,
              onTapDown: (_) => setState(() => _isTappedDown = true),
              onTapUp: (_) => setState(() => _isTappedDown = false),
              onTapCancel: () => setState(() => _isTappedDown = false),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: _RadioCircle(
                        isSelected: _isSelected,
                        isActive: _isHovering || _isTappedDown,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: spacing25),
                        child: DefaultTextStyle.merge(
                          style: _labelStyle,
                          child: widget.label,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _RadioCircle extends StatelessWidget {
  const _RadioCircle({
    Key? key,
    required this.isSelected,
    required this.isActive,
  }) : super(key: key);

  final bool isSelected;
  final bool isActive;

  Color _borderColor(OptimusThemeData theme) => (isSelected || isActive)
      ? theme.colors.primary500
      : theme.colors.neutral100;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: spacing100,
        bottom: spacing100,
        right: spacing200,
      ),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: isSelected ? 6 : 1,
            color: _borderColor(theme),
          ),
          color: isActive ? theme.colors.primary500t8 : null,
        ),
      ),
    );
  }
}
