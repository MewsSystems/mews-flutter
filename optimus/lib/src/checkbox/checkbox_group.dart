import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

/// Group of checkboxes with the same label and error messages.
class OptimusCheckboxGroup<T> extends StatelessWidget {
  OptimusCheckboxGroup({
    super.key,
    required Iterable<OptimusGroupItem<T>> items,
    required Iterable<T> values,
    required this.onChanged,
    this.size = OptimusCheckboxSize.large,
    this.label,
    this.error,
    this.isEnabled = true,
  })  : _values = values.toSet(),
        _items = items.toSet();

  final Set<OptimusGroupItem<T>> _items;

  final Set<T> _values;

  /// Controls the currently selected values for a group of checkbox buttons.
  Iterable<T> get values => _values.toList(growable: false);

  Iterable<OptimusGroupItem<T>> get items => _items.toList(growable: false);

  /// Called when the user changes some checkbox button.
  ///
  /// The checkbox button passes [values] as a parameter to this callback.
  /// The checkbox button does not actually change state until the parent
  /// widget rebuilds the checkbox button with the new [values].
  final ValueChanged<Iterable<T>> onChanged;

  /// Controls size of each checkbox in the group.
  final OptimusCheckboxSize size;

  /// Controls the label of the group itself.
  final String? label;

  /// Controls the error message for the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  void _handleChanged(OptimusGroupItem<T> v, bool checked) {
    if (checked) {
      _values.add(v.value);
    } else {
      _values.remove(v.value);
    }
    onChanged(_values);
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        isEnabled: isEnabled,
        child: IgnorePointer(
          ignoring: !isEnabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _items
                .mapIndexed(
                  (i, v) => OptimusCheckbox(
                    isChecked: _values.contains(v.value),
                    size: size,
                    label: v.label,
                    isEnabled: isEnabled,
                    onChanged: (checked) => _handleChanged(v, checked),
                  ),
                )
                .toList(),
          ),
        ),
      );
}
