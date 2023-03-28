import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_overlay.dart';

/// Controller for the tooltip widget. It is responsible for showing and hiding
/// the tooltip overlay entry.
class TooltipController extends StatefulWidget {
  const TooltipController({
    Key? key,
    required this.anchorKey,
    required this.child,
    required this.tooltip,
    required this.tooltipKey,
    this.autoHideDuration = const Duration(seconds: 1),
    this.tooltipPosition,
  }) : super(key: key);

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

  /// Duration for which the tooltip will be shown. Defaults to 1 second.
  final Duration autoHideDuration;

  @override
  State<TooltipController> createState() => _TooltipControllerState();
}

class _TooltipControllerState extends State<TooltipController> {
  OverlayEntry? _entry;

  OverlayEntry createEntry() => OverlayEntry(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => hideTooltip(),
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

  void showTooltip() {
    _entry = createEntry().also((it) {
      Overlay.of(context).insert(it);
      Future.delayed(widget.autoHideDuration, hideTooltip);
    });
  }

  void hideTooltip() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: showTooltip,
        child: widget.child,
      );
}
