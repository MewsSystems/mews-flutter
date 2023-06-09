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
  final List<OptimusCheckbox> children;

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
        child: OptimusEnabled(
          isEnabled: isEnabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptimusCheckbox(
                tristate: true,
                isChecked: _isParentChecked,
                label: parent,
                onChanged: (bool value) {
                  for (final child in children) {
                    child.onChanged(value);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: spacing200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: children,
                ),
              ),
            ],
          ),
        ),
      );
}
