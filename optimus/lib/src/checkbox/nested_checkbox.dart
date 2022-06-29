import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

/// Group of checkboxes with a parent checkbox, which displays the current state
/// of its children. Clicking on the parent checkbox will change the state of
/// all its children.
class OptimusNestedCheckboxGroup<T> extends StatelessWidget {
  OptimusNestedCheckboxGroup({
    Key? key,
    required this.parent,
    required bool? isParentChecked,
    required Iterable<OptimusGroupItem<T>> items,
    required Iterable<T> values,
    required this.onChildrenChanged,
    required this.onParentChanged,
    this.size = OptimusCheckboxSize.large,
    this.label,
    this.error,
    this.isEnabled = true,
  })  : _values = values.toSet(),
        _items = items.toSet(),
        _isParentChecked = isParentChecked,
        super(key: key);

  /// Label displayed next to the parent checkbox.
  final Widget parent;

  /// Set of children of this nested checkbox group.
  final Set<OptimusGroupItem<T>> _items;

  /// Set of children that are currently selected.
  final Set<T> _values;

  /// Whether the parent checkbox is selected.
  final bool? _isParentChecked;

  /// Called when the user changes some checkbox button.
  ///
  /// The checkbox button passes [values] as a parameter to this callback.
  /// The checkbox button does not actually change state until the parent
  /// widget rebuilds the checkbox button with the new [values].
  final ValueChanged<Iterable<T>> onChildrenChanged;

  /// Called when there is a change in the group that requires parent change as
  /// well.
  final ValueChanged<bool?> onParentChanged;

  /// Controls size of each checkbox in the group.
  final OptimusCheckboxSize size;

  /// Controls the label of the group itself.
  final String? label;

  /// Controls the error message for the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  /// Controls the currently selected values for a group of checkbox buttons.
  Iterable<T> get values => _values.toList(growable: false);

  Iterable<OptimusGroupItem<T>> get items => _items.toList(growable: false);

  void _onChanged(OptimusGroupItem<T> v, bool checked) {
    if (checked) {
      _values.add(v.value);
    } else {
      _values.remove(v.value);
    }
    onParentChanged(
      values.isEmpty
          ? false
          : values.length == items.length
              ? true
              : null,
    );
    onChildrenChanged(_values);
  }

  void _onParentChanged(bool checked) {
    if (checked) {
      _values.addAll(items.map((e) => e.value));
    } else {
      _values.clear();
    }
    onParentChanged(checked);
    onChildrenChanged(_values);
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        child: OptimusEnabled(
          isEnabled: isEnabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptimusCheckbox(
                label: parent,
                onChanged: _onParentChanged,
                isChecked: _isParentChecked,
                tristate: true,
              ),
              Padding(
                padding: const EdgeInsets.only(left: spacing200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: _items
                      .mapIndexed(
                        (i, v) => OptimusCheckbox(
                          isChecked: _values.contains(v.value),
                          size: size,
                          label: v.label,
                          onChanged: (checked) => _onChanged(v, checked),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
}
