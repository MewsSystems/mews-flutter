import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/dropdown/dropdown.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/dropdown/dropdown_tile.dart';

class OverlayController<T> extends StatefulWidget {
  const OverlayController({
    Key? key,
    required this.child,
    required this.items,
    required this.onItemSelected,
    required this.focusNode,
    required this.anchorKey,
    this.width,
    this.onShown,
    this.onHidden,
  }) : super(key: key);

  final Widget child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onItemSelected;
  final FocusNode focusNode;
  final double? width;
  final GlobalKey anchorKey;
  final VoidCallback? onShown;
  final VoidCallback? onHidden;

  @override
  State<OverlayController<T>> createState() => _OverlayControllerState<T>();
}

class _OverlayControllerState<T> extends State<OverlayController<T>> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() => widget.focusNode.hasFocus
      ? setState(_showOverlay)
      : setState(_removeOverlay);

  @override
  void didUpdateWidget(OverlayController<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry().also((it) {
      Overlay.of(context, rootOverlay: true)?.insert(it);
    });

    widget.onShown?.call();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    widget.onHidden?.call();
  }

  Future<bool> _handleOnBackPressed() async {
    if (widget.focusNode.hasFocus) {
      widget.focusNode.unfocus();

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
              onTapDown: (_) => widget.focusNode.unfocus(),
            ),
            DropdownTapInterceptor(
              onTap: widget.focusNode.unfocus,
              child: OptimusDropdown<T>(
                items: widget.items,
                anchorKey: widget.anchorKey,
                onChanged: widget.onItemSelected,
                width: widget.width,
              ),
            )
          ],
        ),
      );

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _handleOnBackPressed,
        child: widget.child,
      );
}
