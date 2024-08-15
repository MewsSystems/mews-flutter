import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

/// Group of checkboxes with a parent checkbox, which displays the current state
/// of its children. Clicking on the parent checkbox will change the state of
/// all its children.
class OptimusNestedCheckboxGroup extends StatelessWidget {
  const OptimusNestedCheckboxGroup({
    super.key,
    this.label,
    this.error,
    this.size = OptimusCheckboxSize.large,
    this.isEnabled = true,
    required this.parent,
    required this.children,
  });

  /// Children of this nested checkbox group.
  final List<OptimusNestedCheckbox> children;

  /// Label displayed next to the parent checkbox. Typically a [Text] widget.
  final Widget parent;

  /// Controls size of each checkbox in the group.
  final OptimusCheckboxSize size;

  /// Controls the label of the group itself.
  final String? label;

  /// Controls the error message for the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  bool? get _isParentChecked {
    final checked = children.where((child) => child.isChecked == true).toList();

    return checked.isEmpty
        ? false
        : checked.length == children.length
            ? true
            : null;
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: label,
        error: error,
        isEnabled: isEnabled,
        child: IgnorePointer(
          ignoring: !isEnabled,
          child: NestedCheckboxData(
            isEnabled: isEnabled,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OptimusCheckbox(
                  isTristate: true,
                  isEnabled: isEnabled,
                  isChecked: _isParentChecked,
                  label: parent,
                  onChanged: (bool isChecked) {
                    for (final child in children) {
                      child.onChanged(isChecked);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.tokens.spacing200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/// A checkbox that is a part of a [OptimusNestedCheckboxGroup]. It is a wrapper
/// around [OptimusCheckbox] that overrides it's [isEnabled] property with the
/// value from the parent checkbox group.
class OptimusNestedCheckbox extends StatelessWidget {
  const OptimusNestedCheckbox({
    super.key,
    required this.label,
    this.isChecked,
    this.size = OptimusCheckboxSize.large,
    this.isEnabled = true,
    required this.onChanged,
  });

  /// {@macro optimus.checkbox.label}
  final Widget label;

  /// {@macro optimus.checkbox.isChecked}
  final bool? isChecked;

  /// {@macro optimus.checkbox.size}
  final OptimusCheckboxSize size;

  /// {@macro optimus.checkbox.onChanged}
  final ValueChanged<bool> onChanged;

  /// {@macro optimus.checkbox.isEnabled}
  /// The value will be overridden by the parent of the checkbox group.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final isEnabled =
        NestedCheckboxData.of(context)?.isEnabled ?? this.isEnabled;

    return OptimusCheckbox(
      label: label,
      size: size,
      isTristate: false,
      isEnabled: isEnabled,
      isChecked: isChecked,
      onChanged: onChanged,
    );
  }
}

class NestedCheckboxData extends InheritedWidget {
  const NestedCheckboxData({
    super.key,
    required this.isEnabled,
    required super.child,
  });

  final bool isEnabled;

  static NestedCheckboxData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<NestedCheckboxData>();

  @override
  bool updateShouldNotify(NestedCheckboxData oldWidget) => true;
}
