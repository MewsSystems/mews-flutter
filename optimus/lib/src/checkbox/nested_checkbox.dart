import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/group_wrapper.dart';

typedef OnItemChangeCallback<T> = void Function(
  OptimusGroupItem<T> item,
  bool checked,
);

/// Group of checkboxes with a parent checkbox, which displays the current state
/// of its children. Clicking on the parent checkbox will change the state of
/// all its children.
class OptimusNestedCheckboxGroup<T> extends StatefulWidget {
  OptimusNestedCheckboxGroup({
    Key? key,
    this.onChildTap,
    this.onParentTap,
    this.label,
    this.error,
    this.size = OptimusCheckboxSize.large,
    required this.isEnabled,
    required this.parent,
    required Iterable<OptimusGroupItem<T>> items,
    required Iterable<T> values,
  })  : _items = items.toSet(),
        _values = values.toSet(),
        super(key: key);

  /// Set of children of this nested checkbox group.
  final Set<OptimusGroupItem<T>> _items;

  /// Set of children that are currently selected.
  final Set<T> _values;

  /// Will be called when a child node is tapped.
  final ValueChanged<Iterable<T>>? onChildTap;

  /// Label displayed next to the parent checkbox.
  final Widget parent;

  /// Called when a parent node was tapped.
  final ValueChanged<bool?>? onParentTap;

  /// Controls size of each checkbox in the group.
  final OptimusCheckboxSize size;

  /// Controls the label of the group itself.
  final String? label;

  /// Controls the error message for the whole group.
  final String? error;

  /// Controls whether the whole group is enabled.
  final bool isEnabled;

  @override
  State<OptimusNestedCheckboxGroup<T>> createState() =>
      _OptimusNestedCheckboxGroupState<T>();
}

class _OptimusNestedCheckboxGroupState<T>
    extends State<OptimusNestedCheckboxGroup<T>> {
  List<T> get values => widget._values.toList(growable: false);

  List<OptimusGroupItem<T>> get items => widget._items.toList(growable: false);

  void onChildUpdate(OptimusGroupItem<T> item, bool checked) {
    setState(() {
      if (checked) {
        widget._values.add(item.value);
      } else {
        widget._values.remove(item.value);
      }
    });
    widget.onChildTap?.call(widget._values);
  }

  void onParentUpdate(bool checked) {
    setState(() {
      if (checked) {
        widget._values.addAll(widget._items.map((e) => e.value));
      } else {
        widget._values.clear();
      }
    });
    widget.onParentTap?.call(checked);
  }

  @override
  Widget build(BuildContext context) => _CheckboxNestedModel(
        items: items,
        values: values,
        onChildChangeCallback: onChildUpdate,
        onParentChangeCallback: onParentUpdate,
        child: _CheckboxNested<T>(
          isEnabled: widget.isEnabled,
          parent: widget.parent,
          error: widget.error,
          label: widget.label,
          size: widget.size,
        ),
      );
}

class _CheckboxNestedModel<T> extends InheritedWidget {
  const _CheckboxNestedModel({
    Key? key,
    required Widget child,
    required this.items,
    required this.values,
    required this.onChildChangeCallback,
    required this.onParentChangeCallback,
  }) : super(key: key, child: child);

  final List<OptimusGroupItem<T>> items;
  final List<T> values;
  final OnItemChangeCallback<T> onChildChangeCallback;
  final ValueChanged<bool> onParentChangeCallback;

  bool? get isParentChecked => values.isEmpty
      ? false
      : values.length == items.length
          ? true
          : null;

  static _CheckboxNestedModel<T>? of<T>(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CheckboxNestedModel<T>>();

  @override
  bool updateShouldNotify(_CheckboxNestedModel<T> oldWidget) =>
      items != oldWidget.items || values != oldWidget.values;
}

class _CheckboxNested<T> extends StatelessWidget {
  const _CheckboxNested({
    Key? key,
    this.label,
    this.error,
    required this.parent,
    required this.size,
    required this.isEnabled,
  }) : super(key: key);

  final Widget parent;
  final OptimusCheckboxSize size;
  final String? label;
  final String? error;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final model = _CheckboxNestedModel.of<T>(context);

    return model != null
        ? GroupWrapper(
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
                    onChanged: model.onParentChangeCallback,
                    isChecked: model.isParentChecked,
                    tristate: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: spacing200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: model.items
                          .mapIndexed(
                            (i, v) => OptimusCheckbox(
                              isChecked: model.values.contains(v.value),
                              size: size,
                              label: v.label,
                              onChanged: (checked) {
                                model.onChildChangeCallback(v, checked);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
