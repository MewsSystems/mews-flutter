import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/group_item.dart';
import 'package:optimus/src/common/group_wrapper.dart';
import 'package:optimus/src/radio/radio.dart';

class OptimusRadioGroup<T> extends StatelessWidget {
  const OptimusRadioGroup({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.size = OptimusRadioSize.large,
    this.label,
    this.error,
    this.isEnabled = true,
  });

  /// List of radio items.
  final List<OptimusGroupItem<T>> items;

  /// Controls the currently selected value for a group of radio buttons.
  final T value;

  /// Called when the user selects radio button.
  ///
  /// The radio button passes [value] as a parameter to this callback. The radio
  /// button does not actually change state until the parent widget rebuilds the
  /// radio button with the new [value].
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

  /// Controls the size of all buttons within this group.
  final OptimusRadioSize size;

  /// Controls the label of the whole group.
  final String? label;

  /// Controls the error of the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .radioGroup,
    enabled: isEnabled,
    child: GroupWrapper(
      label: label,
      error: error,
      isEnabled: isEnabled,
      child: Column(
        children: items
            .map(
              (i) => OptimusRadio<T>(
                label: i.label,
                isEnabled: isEnabled,
                semanticLabel: i.semanticLabel,
                value: i.value,
                groupValue: value,
                onChanged: onChanged,
                size: size,
              ),
            )
            .toList(),
      ),
    ),
  );
}
