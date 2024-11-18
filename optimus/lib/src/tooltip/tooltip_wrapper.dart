import 'package:flutter/material.dart';
import 'package:optimus/src/tooltip/tooltip.dart';
import 'package:optimus/src/tooltip/tooltip_controller.dart';

/// Wrapper for the [OptimusTooltip] widget. It is responsible for showing and
/// hiding the tooltip. Will try to position the tooltip depending on the
/// available space.
class OptimusTooltipWrapper extends StatefulWidget {
  const OptimusTooltipWrapper({
    super.key,
    required this.text,
    required this.child,
    this.tooltipPosition = OptimusTooltipPosition.top,
    this.size = OptimusToolTipSize.small,
    this.autoHideDuration = const Duration(seconds: 1),
  });

  /// Tooltip text. Typically a [Text] widget. This widget will be passed to the
  /// tooltip and styled accordingly.
  final Widget text;

  /// Widget that should be wrapped with the tooltip.
  final Widget child;

  /// Size of the tooltip.
  final OptimusToolTipSize size;

  /// Position of the tooltip relative to the child widget. If not specified,
  /// the tooltip will be positioned automatically. Defaults to
  /// [OptimusTooltipPosition.top] or [OptimusTooltipPosition.bottom], whichever
  /// has more space available.
  final OptimusTooltipPosition? tooltipPosition;

  /// Duration for which the tooltip will be shown.
  final Duration autoHideDuration;

  @override
  State<OptimusTooltipWrapper> createState() => _OptimusTooltipWrapperState();
}

class _OptimusTooltipWrapperState extends State<OptimusTooltipWrapper> {
  final GlobalKey _anchorKey = GlobalKey();
  final GlobalKey _tooltipKey = GlobalKey();

  @override
  Widget build(BuildContext context) => TooltipController(
        anchorKey: _anchorKey,
        tooltipKey: _tooltipKey,
        tooltipPosition: widget.tooltipPosition,
        autoHideDuration: widget.autoHideDuration,
        tooltip: OptimusTooltip(
          key: _tooltipKey,
          size: widget.size,
          tooltipPosition: widget.tooltipPosition,
          content: widget.text,
        ),
        child: KeyedSubtree(
          key: _anchorKey,
          child: widget.child,
        ),
      );
}
