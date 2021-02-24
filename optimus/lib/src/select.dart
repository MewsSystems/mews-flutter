import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/field_wrapper.dart';
import 'package:optimus/src/overlay_controller.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/widget_size.dart';

typedef CurrentValueBuilder<T> = Widget Function(BuildContext context, T value);

class OptimusSelect<T> extends StatefulWidget {
  const OptimusSelect({
    Key key,
    this.label,
    this.placeholder = '',
    this.value,
    @required this.items,
    @required this.builder,
    this.isEnabled = true,
    this.isRequired = false,
    this.prefix,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    @required this.onItemSelected,
  }) : super(key: key);

  final String label;
  final String placeholder;
  final T value;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final bool isRequired;
  final Widget prefix;
  final Widget caption;
  final Widget secondaryCaption;
  final String error;
  final OptimusWidgetSize size;
  final CurrentValueBuilder<T> builder;
  final ValueSetter<T> onItemSelected;

  @override
  _OptimusSelectState createState() => _OptimusSelectState<T>();
}

class _OptimusSelectState<T> extends State<OptimusSelect<T>> {
  final _selectFieldKey = GlobalKey();
  final _node = FocusNode();
  bool _isOpened = false;

  @override
  Widget build(BuildContext context) => OverlayController(
        onItemSelected: widget.onItemSelected,
        focusNode: _node,
        anchorKey: _selectFieldKey,
        items: widget.items,
        onShown: () => setState(() => _isOpened = true),
        onHidden: () => setState(() => _isOpened = false),
        child: GestureDetector(
          onTap: () => widget.isEnabled ? _node.requestFocus() : null,
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
            secondaryCaption: widget.secondaryCaption,
            children: [
              _SelectedValue(
                size: widget.size,
                textStyle: _textStyle,
                child: _fieldContent,
              ),
            ],
          ),
        ),
      );

  Widget get _fieldContent => widget.value == null
      ? Text(widget.placeholder, style: _textStyle)
      : DefaultTextStyle.merge(
          style: preset300m,
          child: widget.builder(context, widget.value),
        );

  Icon get _icon => Icon(
        _isOpened ? OptimusIcons.chevron_up_1 : OptimusIcons.chevron_down_1,
        size: 24,
        color: OptimusLightColors.neutral400,
      );

  // ignore: missing_return
  TextStyle get _textStyle {
    if (widget.value == null) {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200m.copyWith(color: OptimusLightColors.neutral1000t64);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300m.copyWith(color: OptimusLightColors.neutral1000t64);
      }
    } else {
      switch (widget.size) {
        case OptimusWidgetSize.small:
          return preset200m.copyWith(color: OptimusLightColors.neutral900);
        case OptimusWidgetSize.medium:
        case OptimusWidgetSize.large:
          return preset300m.copyWith(color: OptimusLightColors.neutral900);
      }
    }
  }
}

class _SelectedValue extends StatelessWidget {
  const _SelectedValue({
    Key key,
    @required this.child,
    @required this.size,
    @required this.textStyle,
  }) : super(key: key);

  final Widget child;
  final OptimusWidgetSize size;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildBorderContainer(),
          ],
        ),
      );

  Widget _buildBorderContainer() => Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: SizedBox(
          height: size.value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DefaultTextStyle(
                style: textStyle,
                child: child,
              ),
            ],
          ),
        ),
      );
}
