import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_overlay.dart';

/// Controller for the tooltip widget. It is responsible for showing and hiding
/// the tooltip overlay entry.
class TooltipController extends StatefulWidget {
  const TooltipController({
    super.key,
    required this.anchorKey,
    required this.child,
    required this.tooltip,
    required this.tooltipKey,
    this.autoHideDuration = const Duration(seconds: 1),
    this.tooltipPosition,
  });

  /// Key of the widget that should be wrapped with the tooltip.
  final GlobalKey anchorKey;

  /// Key of the tooltip widget.
  final GlobalKey tooltipKey;

  /// Widget that should be wrapped with the tooltip.
  final Widget child;

  /// Tooltip widget.
  final OptimusTooltip tooltip;

  /// Position of the tooltip relative to the child widget. If not specified,
  /// the tooltip will be positioned automatically. Depending on the space
  /// available will be set to [OptimusTooltipPosition.top] or
  /// [OptimusTooltipPosition.bottom].
  final OptimusTooltipPosition? tooltipPosition;

  /// Duration for which the tooltip will be shown. Defaults to 1 second. If
  /// the tooltip is triggered by a mouse hover, it will not be hidden
  /// until the mouse leaves the widget.
  final Duration autoHideDuration;

  @override
  State<TooltipController> createState() => _TooltipControllerState();
}

class _TooltipControllerState extends State<TooltipController> {
  OverlayEntry? _entry;

  OverlayEntry _createEntry() => OverlayEntry(
    builder:
        (context) => GestureDetector(
          onTapDown: (_) => _handleHide(),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              TooltipOverlay(
                anchorKey: widget.anchorKey,
                tooltipKey: widget.tooltipKey,
                position: widget.tooltipPosition,
                tooltip: widget.tooltip,
              ),
            ],
          ),
        ),
  );

  void _handleShow({bool enableAutoHide = true}) {
    if (_entry != null) return;

    _entry = _createEntry().also((it) {
      Overlay.of(context).insert(it);
      if (enableAutoHide) Future.delayed(widget.autoHideDuration, _handleHide);
    });
  }

  void _handleHide() {
    _entry?.remove();
    _entry?.dispose();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => _handleShow(enableAutoHide: false),
    onExit: (_) => _handleHide(),
    child: GestureDetector(onTap: _handleShow, child: widget.child),
  );
}
