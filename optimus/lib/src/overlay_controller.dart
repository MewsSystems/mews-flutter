import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/dropdown/dropdown.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/dropdown/dropdown_tile.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';
import 'package:optimus/src/widget_size.dart';

class OverlayController<T> extends StatefulWidget {
  const OverlayController({
    super.key,
    required this.child,
    required this.items,
    required this.onItemSelected,
    required this.focusNode,
    required this.anchorKey,
    required this.size,
    this.width,
    this.onShown,
    this.onHidden,
    this.useRootOverlay = false,
  });

  final Widget child;

  final List<OptimusDropdownTile<T>> items;
  final ValueSetter<T> onItemSelected;
  final FocusNode focusNode;
  final double? width;
  final GlobalKey anchorKey;
  final VoidCallback? onShown;
  final VoidCallback? onHidden;
  final bool useRootOverlay;
  final OptimusWidgetSize size;

  @override
  State<OverlayController<T>> createState() => _OverlayControllerState<T>();
}

class _OverlayControllerState<T> extends State<OverlayController<T>>
    with ThemeGetter {
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
      Overlay.of(context, rootOverlay: widget.useRootOverlay).insert(it);
    });

    widget.onShown?.call();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    widget.onHidden?.call();
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
    builder: (BuildContext builderContext) => MediaQuery(
      data: MediaQuery.of(context),
      // We need to wrap the overlay in an OptimusTheme to ensure that the
      // dropdown is rendered in the correct theme. Context tokens are passed
      // to preserve any theme overrides.
      child: OptimusTheme(
        themeMode: theme.themeMode,
        darkTheme: context.effectiveDarkTokens,
        lightTheme: context.effectiveLightTokens,
        child: Stack(
          key: const Key('OptimusSelectOverlay'),
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (_) => widget.focusNode.unfocus(),
            ),
            DropdownTapInterceptor(
              onTap: widget.focusNode.unfocus,
              child: OptimusDropdown<T>(
                items: widget.items,
                size: widget.size,
                anchorKey: widget.anchorKey,
                onChanged: widget.onItemSelected,
                width: widget.width,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChanged);
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: !widget.focusNode.hasFocus,
    onPopInvokedWithResult: (bool didPop, _) {
      if (didPop) return;
      widget.focusNode.unfocus();
    },
    child: widget.child,
  );
}
