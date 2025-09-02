import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:optimus/optimus.dart';

/// An embedded search that is designed to be used inside the dropdown menu.
/// Is styled to be in line with the default dropdown list items. Will call for
/// the focus on display.
class OptimusDropdownEmbeddedSearch extends StatefulWidget {
  const OptimusDropdownEmbeddedSearch({
    super.key,
    this.placeholder,
    this.onTextChanged,
    this.initialValue = '',
    this.isClearEnabled = true,
  });

  /// The initial value of the search when the dropdown becomes visible.
  final String initialValue;

  /// The callback to be called when the search value changes.
  final ValueSetter<String>? onTextChanged;

  /// The placeholder of the input field.
  final String? placeholder;

  final bool isClearEnabled;

  @override
  State<OptimusDropdownEmbeddedSearch> createState() =>
      _OptimusDropdownEmbeddedSearchState();
}

class _OptimusDropdownEmbeddedSearchState
    extends State<OptimusDropdownEmbeddedSearch> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widget.onTextChanged?.call(widget.initialValue),
    );
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
    controller: _controller,
    onChanged: widget.onTextChanged,
    focusNode: _focusNode,
    placeholder: widget.placeholder,
    leading: const Icon(OptimusIcons.search),
    isClearEnabled: widget.isClearEnabled,
    hasBorders: false,
  );
}
