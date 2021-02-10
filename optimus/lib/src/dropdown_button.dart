import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';
import 'package:optimus/src/search/search_field_dropdown.dart';
import 'package:optimus/src/widget_size.dart';

class OptimusDropDownButton<T> extends StatefulWidget {
  const OptimusDropDownButton({
    Key key,
    this.label,
    @required this.items,
    this.isEnabled = true,
    this.size = OptimusWidgetSize.large,
    @required this.onChanged,
  }) : super(key: key);

  // todo: wrap with Merge, change to Widget
  final String label;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final OptimusWidgetSize size;
  final ValueSetter<T> onChanged;

  @override
  _OptimusDropDownButtonState createState() => _OptimusDropDownButtonState<T>();
}

class _OptimusDropDownButtonState<T> extends State<OptimusDropDownButton<T>> {
  final _selectFieldKey = GlobalKey();

  OverlayEntry _overlayEntry;
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _node.addListener(_onFocusChanged);
  }

  void _onFocusChanged() =>
      _node.hasFocus ? setState(_showOverlay) : setState(_removeOverlay);

  @override
  void didUpdateWidget(OptimusDropDownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry?.markNeedsBuild();
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _handleOnBackPressed,
        child: GestureDetector(
          onTap: () => widget.isEnabled ? _node.requestFocus() : null,
          child: Focus(
            focusNode: _node,
            child: Container(
              key: _selectFieldKey,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.label),
                  _icon,
                ],
              ),
            ),
          ),
        ),
      );

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<bool> _handleOnBackPressed() async {
    if (_node.hasFocus) {
      _node.unfocus();
      return false;
    }
    return true;
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) => Stack(
          key: const Key('OptimusSelectOverlay'),
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => _node.unfocus(),
            ),
            DropdownTapInterceptor(
              onTap: _node.unfocus,
              child: OptimusSearchFieldDropdown<T>(
                items: widget.items,
                anchorKey: _selectFieldKey,
                onChanged: widget.onChanged,
              ),
            )
          ],
        ),
      );

  Icon get _icon => Icon(
        _node.hasFocus
            ? OptimusIcons.chevron_up_1
            : OptimusIcons.chevron_down_1,
        size: 24,
        color: OptimusColors.neutral400,
      );

  @override
  void dispose() {
    _node.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }
}
