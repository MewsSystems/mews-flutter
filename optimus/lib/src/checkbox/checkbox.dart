import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/checkbox/checkbox_tick.dart';
import 'package:optimus/src/common/group_wrapper.dart';

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
/// independent (with exceptions). If [isTristate] is enabled, checkbox can be in
/// three states: checked, unchecked and indeterminate.
class OptimusCheckbox extends StatelessWidget {
  const OptimusCheckbox({
    super.key,
    required this.label,
    this.isChecked = false,
    this.error,
    this.isEnabled = true,
    this.size = OptimusCheckboxSize.large,
    this.isTristate = false,
    required this.onChanged,
    this.semanticLabel,
  }) : assert(
         isTristate || isChecked != null,
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
  // ignore: avoid-unnecessary-nullable-fields, required for the tristate
  final bool? isChecked;

  /// {@template optimus.checkbox.tristate}
  /// Whether this checkbox has 3 states.
  /// {@endtemplate}
  final bool isTristate;

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

  /// The semantic label for the screen reader.
  final String? semanticLabel;

  Color _labelColor(OptimusTokens tokens) =>
      isEnabled ? tokens.textStaticPrimary : tokens.textDisabled;

  TextStyle _labelStyle(OptimusTokens tokens) {
    final color = _labelColor(tokens);

    return switch (size) {
      OptimusCheckboxSize.large => tokens.bodyLargeStrong.copyWith(
        color: color,
      ),
      OptimusCheckboxSize.small => tokens.bodyMediumStrong.copyWith(
        color: color,
      ),
    };
  }

  bool get _isError {
    if (error case final error?) {
      return error.isNotEmpty;
    }

    return false;
  }

  void _handleTap() => onChanged(!(isChecked ?? false));

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final topPadding = size == OptimusCheckboxSize.large
        ? tokens.spacing50
        : tokens.spacing25;

    return IgnorePointer(
      ignoring: !isEnabled,
      child: GroupWrapper(
        error: error,
        isEnabled: isEnabled,
        child: MergeSemantics(
          child: GestureDetector(
            onTap: _handleTap,
            child: Semantics(
              label: semanticLabel,
              checked: isChecked ?? false,
              mixed: isTristate ? isChecked == null : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: topPadding),
                    child: CheckboxTick(
                      isError: _isError,
                      isChecked: isChecked,
                      isEnabled: isEnabled,
                      onChanged: onChanged,
                      onTap: _handleTap,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: tokens.spacing150,
                        bottom: tokens.spacing50,
                      ),
                      child: DefaultTextStyle.merge(
                        style: _labelStyle(tokens),
                        child: label,
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
}
