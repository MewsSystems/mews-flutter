import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/group_wrapper.dart';
import 'package:optimus/src/typography/styles.dart';

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
/// independent (with exceptions).
class OptimusCheckbox extends StatefulWidget {
  const OptimusCheckbox({
    Key key,
    this.label,
    this.isChecked = false,
    this.error,
    this.isEnabled = true,
    this.size = OptimusCheckboxSize.large,
    @required this.onChanged,
  }) : super(key: key);

  /// Label displayed next to checkbox.
  ///
  /// Typically a [Text] widget.
  final Widget label;

  /// Whether this checkbox is checked.
  final bool isChecked;

  /// Controls error that appears below checkbox.
  final String error;

  /// Whether this widget is enabled.
  final bool isEnabled;

  /// Controls size of the label.
  final OptimusCheckboxSize size;

  /// Called when the user clicks on this check button.
  ///
  /// The checkbox button passes [value] as a parameter to this callback.
  /// The checkbox button does not actually change state until the parent
  /// widget rebuilds the checkbox button with the new [value].
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
  _OptimusCheckboxState createState() => _OptimusCheckboxState();
}

class _OptimusCheckboxState extends State<OptimusCheckbox> {
  bool _isHovering = false;
  bool _isTappedDown = false;

  Color get _borderColor => widget.isChecked
      ? OptimusColors.primary500
      : _isHovering || _isTappedDown
          ? OptimusColors.primary500
          : OptimusColors.neutral100;

  Color get _backgroundColor => widget.isChecked
      ? OptimusColors.primary500
      : _isHovering || _isTappedDown
          ? OptimusColors.primary500t8
          : Colors.transparent;

  void _onTap() {
    widget.onChanged.call(!widget.isChecked);
  }

  void _onHoverChanged(bool hovered) {
    setState(() => _isHovering = hovered);
  }

  // ignore: missing_return
  TextStyle get _labelStyle {
    switch (widget.size) {
      case OptimusCheckboxSize.large:
        return preset300m;
      case OptimusCheckboxSize.small:
        return preset200m;
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkIcon = widget.isChecked
        ? const Center(
            child: Icon(OptimusIcons.done, size: 10, color: Colors.white),
          )
        : null;

    final label = Padding(
      padding: const EdgeInsets.fromLTRB(
        spacing100,
        spacing50,
        spacing0,
        spacing50,
      ),
      child: DefaultTextStyle.merge(style: _labelStyle, child: widget.label),
    );

    return Enabled(
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
                    child: checkIcon,
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
