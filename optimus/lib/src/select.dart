import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/typography/presets.dart';

typedef CurrentValueBuilder<T> = Widget Function(BuildContext context, T value);

@Deprecated('Use `OptimusSelectInput` instead')
class OptimusSelect<T> extends StatefulWidget {
  @Deprecated('Use `OptimusSelectInput` instead')
  const OptimusSelect({
    super.key,
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
    required this.onItemSelected,
  });

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
  final ValueSetter<T> onItemSelected;

  @override
  State<OptimusSelect<T>> createState() => _OptimusSelectState<T>();
}

class _OptimusSelectState<T> extends State<OptimusSelect<T>> with ThemeGetter {
  final _selectFieldKey = GlobalKey();
  final _node = FocusNode();
  bool _isOpened = false;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  void _handleOpenedChanged(bool isOpened) =>
      setState(() => _isOpened = isOpened);

  @override
  Widget build(BuildContext context) => OverlayController(
        onItemSelected: widget.onItemSelected,
        focusNode: _node,
        anchorKey: _selectFieldKey,
        items: widget.items,
        onShown: () => _handleOpenedChanged(true),
        onHidden: () => _handleOpenedChanged(false),
        child: GestureDetector(
          onTap: () => widget.isEnabled ? _node.requestFocus() : null,
          child: Focus(
            focusNode: _node,
            child: FieldWrapper(
              fieldBoxKey: _selectFieldKey,
              focusNode: _node,
              label: widget.label,
              error: widget.error,
              isEnabled: widget.isEnabled,
              isRequired: widget.isRequired,
              prefix: widget.prefix,
              suffix: _icon,
              caption: widget.caption,
              helperMessage: widget.secondaryCaption,
              children: [
                _SelectedValue(
                  size: widget.size,
                  textStyle: _textStyle,
                  child: _fieldContent,
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _fieldContent {
    final value = widget.value;

    return value == null
        ? Text(widget.placeholder, style: _textStyle)
        : DefaultTextStyle.merge(
            style: preset300s,
            child: widget.builder(context, value),
          );
  }

  Icon get _icon => Icon(
        _isOpened ? OptimusIcons.chevron_up : OptimusIcons.chevron_down,
        size: tokens.sizing300,
        color: theme.isDark
            ? theme.colors.neutral0
            : theme.colors.neutral400, // TODO(witwash): replace with tokens
      );

  TextStyle get _textStyle {
    final color = widget.value == null ? _placeholderColor : _textColor;

    return switch (widget.size) {
      OptimusWidgetSize.small => preset200s.copyWith(color: color),
      OptimusWidgetSize.medium ||
      OptimusWidgetSize.large =>
        preset300s.copyWith(color: color),
    };
  }

  Color get _placeholderColor =>
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

  Color get _textColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
}

class _SelectedValue extends StatelessWidget {
  const _SelectedValue({
    required this.child,
    required this.size,
    required this.textStyle,
  });

  final Widget child;
  final OptimusWidgetSize size;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.only(left: tokens.spacing200, right: tokens.spacing100),
        child: SizedBox(
          height: size.getValue(tokens),
          child: DefaultTextStyle(style: textStyle, child: child),
        ),
      ),
    );
  }
}
