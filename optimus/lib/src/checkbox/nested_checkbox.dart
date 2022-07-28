import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

typedef OnItemChangeCallback<T> = void Function(
  List<T> values,
);

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
    this.onChildrenChanged,
    required this.parent,
    required this.children,
  }) : super(key: key);

  /// Children of this nested checkbox group.
  final List<OptimusCheckbox> children;

  /// Callback to be executed when the children of this group change.
  /// It will be called when the parent checkbox will modify the state of all
  /// child checkboxes or on the single change of a sole checkbox.
  final OnItemChangeCallback<bool>? onChildrenChanged;

  /// Label displayed next to the parent checkbox.
  final OptimusCheckbox parent;

  /// Controls size of each checkbox in the group.
  final OptimusCheckboxSize size;

  /// Controls the label of the group itself.
  final String? label;

  /// Controls the error message for the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  static CheckboxManager? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_CheckboxNestedModel>()
      ?.manager;

  @override
  State<OptimusNestedCheckboxGroup> createState() =>
      _OptimusNestedCheckboxGroupState();
}

class _OptimusNestedCheckboxGroupState extends State<OptimusNestedCheckboxGroup>
    implements CheckboxManager {
  late List<bool> _values;

  @override
  void initState() {
    super.initState();
    _values = widget.children.map((c) => c.isChecked ?? false).toList();
  }

  bool? get _isParentChecked {
    final checked = _values.where((value) => value).toList();

    return checked.isEmpty
        ? false
        : checked.length == _values.length
            ? true
            : null;
  }

  @override
  void onUpdate(OptimusCheckbox checkbox, bool isChecked) {
    if (checkbox == widget.parent) {
      _onParentChanged(isChecked);
    } else {
      _onCheckboxChanged(checkbox, isChecked);
    }
    widget.onChildrenChanged?.call(_values);
  }

  @override
  bool? isChecked(OptimusCheckbox checkbox) {
    if (checkbox == widget.parent) {
      return _isParentChecked;
    }

    final index = widget.children.indexOf(checkbox);
    if (index != -1) {
      return _values[index];
    }

    return null;
  }

  void _onParentChanged(bool isChecked) {
    _values = List.filled(widget.children.length, isChecked);
    setState(() {});
  }

  void _onCheckboxChanged(OptimusCheckbox checkbox, bool isChecked) {
    final index = widget.children.indexOf(checkbox);
    if (index != -1) {
      _values[index] = isChecked;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => _CheckboxNestedModel(
        manager: this,
        child: _CheckboxNested(
          isEnabled: widget.isEnabled,
          parent: widget.parent,
          error: widget.error,
          label: widget.label,
          children: widget.children,
        ),
      );
}

class _CheckboxNestedModel extends InheritedWidget {
  const _CheckboxNestedModel({
    Key? key,
    required Widget child,
    required this.manager,
  }) : super(key: key, child: child);

  final CheckboxManager manager;

  @override
  bool updateShouldNotify(_CheckboxNestedModel oldWidget) => true;
}

abstract class CheckboxManager {
  void onUpdate(OptimusCheckbox checkbox, bool isChecked);
  bool? isChecked(OptimusCheckbox checkbox);
}

class _CheckboxNested extends StatelessWidget {
  const _CheckboxNested({
    Key? key,
    this.label,
    this.error,
    required this.parent,
    required this.children,
    required this.isEnabled,
  }) : super(key: key);

  final OptimusCheckbox parent;
  final List<OptimusCheckbox> children;
  final String? label;
  final String? error;
  final bool isEnabled;

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
              parent,
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
