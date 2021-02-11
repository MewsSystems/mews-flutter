import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/enabled.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';
import 'package:optimus/src/search/search_field_dropdown.dart';
import 'package:optimus/src/typography/styles.dart';
import 'package:optimus/src/widget_size.dart';

enum OptimusDropdownButtonType {
  /// The default option. Use this variant for the majority of cases.
  defaultButton,

  /// Use if you want to grab the user’s attention and group together main
  /// actions that don’t have any clear priority.
  primary,

  /// Use in non-crucial situations, e.g., to group “more” actions together.
  text,
}

/// Dropdown buttons trigger a dropdown menu with more actions related to the
/// context of the button.
class OptimusDropDownButton<T> extends StatefulWidget {
  const OptimusDropDownButton({
    Key key,
    this.label,
    @required this.items,
    this.onChanged,
    this.size = OptimusWidgetSize.large,
    this.type = OptimusDropdownButtonType.defaultButton,
  }) : super(key: key);

  final Widget label;
  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onChanged;
  final OptimusWidgetSize size;
  final OptimusDropdownButtonType type;

  @override
  _OptimusDropDownButtonState createState() => _OptimusDropDownButtonState<T>();
}

class _OptimusDropDownButtonState<T> extends State<OptimusDropDownButton<T>> {
  final _selectFieldKey = GlobalKey();
  bool _isHovering = false;
  bool _isTappedDown = false;

  OverlayEntry _overlayEntry;
  final _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _node.addListener(_onFocusChanged);
  }

  void _onHoverChanged(bool isHovering) {
    setState(() => _isHovering = isHovering);
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
        child: Enabled(
          isEnabled: _isEnabled,
          child: MouseRegion(
            onEnter: (_) => _onHoverChanged(true),
            onExit: (_) => _onHoverChanged(false),
            child: GestureDetector(
              onTap: _node.requestFocus,
              onTapDown: (_) => setState(() => _isTappedDown = true),
              onTapUp: (_) => setState(() => _isTappedDown = false),
              onTapCancel: () => setState(() => _isTappedDown = false),
              child: Focus(
                focusNode: _node,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: spacing200),
                  height: widget.size.value,
                  key: _selectFieldKey,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: const BorderRadius.all(borderRadius50),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: DefaultTextStyle.merge(
                          style: _labelStyle,
                          child: widget.label,
                        ),
                      ),
                      _icon,
                    ],
                  ),
                ),
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
                width: _dropdownWidth,
              ),
            )
          ],
        ),
      );

  bool get _isEnabled => widget.onChanged != null;

  TextStyle get _labelStyle => widget.size == OptimusWidgetSize.small
      ? preset200s.copyWith(color: _textColor, height: 1.3)
      : preset300s.copyWith(color: _textColor, height: 1.3);

  // ignore: missing_return
  Color get _textColor {
    switch (widget.type) {
      case OptimusDropdownButtonType.primary:
        return OptimusColors.neutral0;
      default:
        return OptimusColors.neutral500;
    }
  }

  Color get _color => _node.hasFocus || _isTappedDown
      ? _highlightColor
      : _isHovering
          ? _hoverColor
          : _normalColor;

  // ignore: missing_return
  Color get _normalColor {
    switch (widget.type) {
      case OptimusDropdownButtonType.defaultButton:
        return OptimusColors.neutral50;
      case OptimusDropdownButtonType.primary:
        return OptimusColors.primary500;
      case OptimusDropdownButtonType.text:
        return Colors.transparent;
    }
  }

  // ignore: missing_return
  Color get _hoverColor {
    switch (widget.type) {
      case OptimusDropdownButtonType.defaultButton:
        return OptimusColors.neutral100;
      case OptimusDropdownButtonType.primary:
        return OptimusColors.primary700;
      case OptimusDropdownButtonType.text:
        return OptimusColors.neutral500t8;
    }
  }

  // ignore: missing_return
  Color get _highlightColor {
    switch (widget.type) {
      case OptimusDropdownButtonType.defaultButton:
        return OptimusColors.neutral200;
      case OptimusDropdownButtonType.primary:
        return OptimusColors.primary900;
      case OptimusDropdownButtonType.text:
        return OptimusColors.neutral500t16;
    }
  }

  Icon get _icon => Icon(
        _node.hasFocus
            ? OptimusIcons.chevron_up_1
            : OptimusIcons.chevron_down_1,
        size: widget.size == OptimusWidgetSize.small ? 16 : 24,
        color: _textColor,
      );

  @override
  void dispose() {
    _node.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }
}

const double _dropdownWidth = 280;
