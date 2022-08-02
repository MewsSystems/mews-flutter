import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

/// Group of checkboxes with a parent checkbox, which displays the current state
/// of its children. Clicking on the parent checkbox will change the state of
/// all its children.
class OptimusNestedCheckboxGroup extends StatefulWidget {
  const OptimusNestedCheckboxGroup({
    Key? key,
    this.label,
    this.error,
    this.size = OptimusCheckboxSize.large,
    this.isEnabled = true,
    required this.parent,
    required this.children,
  }) : super(key: key);

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

  @override
  State<OptimusNestedCheckboxGroup> createState() =>
      _OptimusNestedCheckboxGroupState();
}

class _OptimusNestedCheckboxGroupState
    extends State<OptimusNestedCheckboxGroup> {
  bool? get _isParentChecked {
    final checked =
        widget.children.where((child) => child.isChecked == true).toList();

    return checked.isEmpty
        ? false
        : checked.length == widget.children.length
            ? true
            : null;
  }

  @override
  Widget build(BuildContext context) => GroupWrapper(
        label: widget.label,
        error: widget.error,
        child: OptimusEnabled(
          isEnabled: widget.isEnabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OptimusCheckbox(
                isEnabled: widget.isEnabled,
                tristate: true,
                isChecked: _isParentChecked,
                label: widget.parent,
                onChanged: (bool value) {
                  for (final child in widget.children) {
                    child.onChanged.call(value);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: spacing200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.children,
                ),
              ),
            ],
          ),
        ),
      );
}
