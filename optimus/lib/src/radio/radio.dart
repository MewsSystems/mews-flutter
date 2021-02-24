import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/group_wrapper.dart';
import 'package:optimus/src/typography/styles.dart';

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
    Key key,
    @required this.label,
    @required this.value,
    @required this.groupValue,
    @required this.onChanged,
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
  final String error;

  /// Controls if the widget is enabled.
  final bool isEnabled;

  @override
  _OptimusRadioState<T> createState() => _OptimusRadioState<T>();
}

class _OptimusRadioState<T> extends State<OptimusRadio<T>> {
  bool _isHovering = false;
  bool _isTappedDown = false;

  bool get _isSelected => widget.value == widget.groupValue;

  // ignore: missing_return
  TextStyle get _labelStyle {
    switch (widget.size) {
      case OptimusRadioSize.small:
        return preset200m;
      case OptimusRadioSize.large:
        return preset300m;
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
        child: Enabled(
          isEnabled: widget.isEnabled,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: _onChanged,
              onTapDown: (_) => setState(() => _isTappedDown = true),
              onTapUp: (_) => setState(() => _isTappedDown = false),
              onTapCancel: () => setState(() => _isTappedDown = false),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RadioCircle(
                    isSelected: _isSelected,
                    isActive: _isHovering || _isTappedDown,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
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
      );
}

class _RadioCircle extends StatelessWidget {
  const _RadioCircle({
    Key key,
    @required this.isSelected,
    @required this.isActive,
  }) : super(key: key);

  final bool isSelected;
  final bool isActive;

  Color get _borderColor => (isSelected || isActive)
      ? OptimusLightColors.primary500
      : OptimusLightColors.neutral100;

  @override
  Widget build(BuildContext context) => Padding(
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
            border: Border.all(width: isSelected ? 6 : 1, color: _borderColor),
            color: isActive ? OptimusLightColors.primary500t8 : null,
          ),
        ),
      );
}
