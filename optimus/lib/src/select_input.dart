import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/widget_size.dart';

typedef CurrentValueBuilder<T> = String Function(T value);

class OptimusSelectInput<T> extends StatefulWidget {
  const OptimusSelectInput({
    Key? key,
    this.label,
    this.placeholder = '',
    this.value,
    required this.items,
    required this.builder,
    this.isEnabled = true,
    this.isRequired = false,
    this.prefix,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    required this.onChanged,
    this.controller,
    this.onTextChanged,
  }) : super(key: key);

  final String? label;
  final String placeholder;
  final T? value;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final bool isRequired;
  final Widget? prefix;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final CurrentValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;

  @override
  _OptimusSelectInput createState() => _OptimusSelectInput<T>();
}

class _OptimusSelectInput<T> extends State<OptimusSelectInput<T>>
    with ThemeGetter {
  final _node = FocusNode();
  bool _isOpened = false;

  void _onFocusChanged() {
    setState(() {
      _isOpened = _node.hasFocus;
    });
  }

  @override
  void initState() {
    super.initState();
    _node.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _node.removeListener(_onFocusChanged);
    super.dispose();
  }

  bool get _isSearchable =>
      widget.controller != null || widget.onTextChanged != null;

  Widget get _icon => IgnorePointer(
        child: Icon(
          _isOpened ? OptimusIcons.chevron_up_1 : OptimusIcons.chevron_down_1,
          size: 24,
          color: theme.isDark ? theme.colors.neutral0 : theme.colors.neutral400,
        ),
      );

  TextStyle get _textStyle {
    if (widget.value == null) {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200s.copyWith(color: _placeholderColor);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300s.copyWith(color: _placeholderColor);
      }
    } else {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200s.copyWith(color: _textColor);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300s.copyWith(color: _textColor);
      }
    }
  }

  Color get _placeholderColor =>
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

  Color get _textColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;

  @override
  Widget build(BuildContext context) => OptimusSearch<T>(
        label: widget.label,
        placeholder: widget.value?.let(widget.builder) ?? widget.placeholder,
        items: widget.items,
        isEnabled: widget.isEnabled,
        isRequired: widget.isRequired,
        caption: widget.caption,
        secondaryCaption: widget.secondaryCaption,
        error: widget.error,
        size: widget.size,
        onChanged: widget.onChanged,
        prefix: widget.prefix,
        suffix: _icon,
        focusNode: _node,
        placeholderStyle: _textStyle,
        controller: widget.controller,
        onTextChanged: widget.onTextChanged,
        readOnly: _isSearchable,
        showCursor: _isSearchable,
      );
}
