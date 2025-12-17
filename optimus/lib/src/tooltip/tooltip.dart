import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_alignment.dart';
import 'package:optimus/src/tooltip/tooltip_overlay.dart';

/// Tooltip displays contextual content upon the click or focus of a UI trigger
/// element. Tooltip's content should be contextual, helpful, and nonessential
/// while providing that extra ability to communicate and give clarity to a
/// user.
class OptimusTooltip extends StatelessWidget {
  const OptimusTooltip({
    super.key,
    required this.content,
    this.size = OptimusToolTipSize.small,
    this.tooltipPosition = OptimusTooltipPosition.top,
  });

  /// The content of the tooltip. Typically a [Text] widget.
  /// Tooltip's content should be contextual, helpful, and nonessential.
  /// Tooltips should never contain essential content.
  final Widget content;

  /// The size of the tooltip. Defaults to [OptimusToolTipSize.small].
  final OptimusToolTipSize size;

  /// The position of the tooltip. Defaults to [OptimusTooltipPosition.top].
  /// If wrapped with [OptimusTooltipWrapper], the position will be set
  /// by the wrapper.
  final OptimusTooltipPosition tooltipPosition;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final alignment =
        TooltipOverlay.of(context)?.alignment ??
        tooltipPosition.toTooltipAlignment();
    final foregroundColor = tokens.textStaticInverse;
    final backgroundColor = tokens.backgroundStaticInverse;

    return Semantics(
      role: .tooltip,
      child: Padding(
        padding: const .all(_arrowHeight),
        child: CustomPaint(
          painter: _TooltipPainter(
            color: backgroundColor,
            alignment: alignment,
            borderRadius: tokens.borderRadius50,
          ),
          child: Container(
            width: size.maxWidth,
            padding: .symmetric(
              vertical: tokens.spacing50,
              horizontal: tokens.spacing150,
            ),
            child: Material(
              color: backgroundColor,
              child: DefaultTextStyle.merge(
                style: tokens.bodySmallStrong.copyWith(color: foregroundColor),
                textAlign: .center,
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TooltipPainter extends CustomPainter {
  const _TooltipPainter({
    required this.color,
    required this.alignment,
    required this.borderRadius,
  });

  final Color color;
  final TooltipAlignment alignment;
  final Radius borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = .fill;

    final width = size.width;
    final height = size.height;

    final Path tooltipPath = Path();

    switch (alignment) {
      case .leftBottom:
        tooltipPath.moveTo(width, _arrowOffset - _arrowWidth / 2);
        tooltipPath.lineTo(width + _arrowHeight, _arrowOffset);
        tooltipPath.lineTo(width, _arrowOffset + _arrowWidth / 2);
        tooltipPath.lineTo(width, _arrowOffset - _arrowWidth / 2);
      case .leftCenter:
        tooltipPath.moveTo(width, height / 2 - _arrowWidth / 2);
        tooltipPath.lineTo(width + _arrowHeight, height / 2);
        tooltipPath.lineTo(width, height / 2 + _arrowWidth / 2);
        tooltipPath.lineTo(width, height / 2 - _arrowWidth / 2);
      case .leftTop:
        tooltipPath.moveTo(width, height - _arrowOffset - _arrowWidth / 2);
        tooltipPath.lineTo(width + _arrowHeight, height - _arrowOffset);
        tooltipPath.lineTo(width, height - _arrowOffset + _arrowWidth / 2);
        tooltipPath.lineTo(width, height - _arrowOffset - _arrowWidth / 2);
      case .topLeft:
        tooltipPath.moveTo(width - _arrowOffset - _arrowWidth / 2, height);
        tooltipPath.lineTo(width - _arrowOffset, height + _arrowHeight);
        tooltipPath.lineTo(width - _arrowOffset + _arrowWidth / 2, height);
        tooltipPath.lineTo(width - _arrowOffset - _arrowWidth / 2, height);
      case .topCenter:
        tooltipPath.moveTo(width / 2 - _arrowWidth / 2, height);
        tooltipPath.lineTo(width / 2, _arrowHeight + height);
        tooltipPath.lineTo(width / 2 + _arrowWidth / 2, height);
        tooltipPath.lineTo(width / 2 - _arrowWidth / 2, height);
      case .topRight:
        tooltipPath.moveTo(_arrowOffset - _arrowWidth / 2, height);
        tooltipPath.lineTo(_arrowOffset, height + _arrowHeight);
        tooltipPath.lineTo(_arrowOffset + _arrowWidth / 2, height);
        tooltipPath.lineTo(_arrowOffset - _arrowWidth / 2, height);
      case .rightTop:
        tooltipPath.moveTo(0, height - _arrowOffset - _arrowWidth / 2);
        tooltipPath.lineTo(-_arrowHeight, height - _arrowOffset);
        tooltipPath.lineTo(0, height - _arrowOffset + _arrowWidth / 2);
        tooltipPath.lineTo(0, height - _arrowOffset - _arrowWidth / 2);
      case .rightCenter:
        tooltipPath.moveTo(0, height / 2 - _arrowWidth / 2);
        tooltipPath.lineTo(-_arrowHeight, height / 2);
        tooltipPath.lineTo(0, height / 2 + _arrowWidth / 2);
        tooltipPath.lineTo(0, height / 2 - _arrowWidth / 2);
      case .rightBottom:
        tooltipPath.moveTo(0, _arrowOffset - _arrowWidth / 2);
        tooltipPath.lineTo(-_arrowHeight, _arrowOffset);
        tooltipPath.lineTo(0, _arrowOffset + _arrowWidth / 2);
        tooltipPath.lineTo(0, _arrowOffset - _arrowWidth / 2);
      case .bottomRight:
        tooltipPath.moveTo(_arrowOffset - _arrowWidth / 2, 0);
        tooltipPath.lineTo(_arrowOffset, -_arrowHeight);
        tooltipPath.lineTo(_arrowOffset + _arrowWidth / 2, 0);
        tooltipPath.lineTo(_arrowOffset - _arrowWidth / 2, 0);
      case .bottomCenter:
        tooltipPath.moveTo(width / 2 - _arrowWidth / 2, 0);
        tooltipPath.lineTo(width / 2, -_arrowHeight);
        tooltipPath.lineTo(width / 2 + _arrowWidth / 2, 0);
        tooltipPath.lineTo(width / 2 - _arrowWidth / 2, 0);
      case .bottomLeft:
        tooltipPath.moveTo(width - _arrowOffset - _arrowWidth / 2, 0);
        tooltipPath.lineTo(width - _arrowOffset, -_arrowHeight);
        tooltipPath.lineTo(width - _arrowOffset + _arrowWidth / 2, 0);
        tooltipPath.lineTo(width - _arrowOffset - _arrowWidth / 2, 0);
    }

    tooltipPath.addRRect(RRect.fromLTRBR(0, 0, width, height, borderRadius));
    canvas.drawPath(tooltipPath, paint);
  }

  @override
  bool shouldRepaint(_TooltipPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.alignment != alignment;
}

enum OptimusToolTipSize { small, medium, large }

enum OptimusTooltipPosition { top, bottom, left, right }

extension on OptimusToolTipSize {
  double get maxWidth => switch (this) {
    .small => 100,
    .medium => 200,
    .large => 300,
  };
}

extension on OptimusTooltipPosition {
  TooltipAlignment toTooltipAlignment() => switch (this) {
    .left => .leftCenter,
    .top => .topCenter,
    .right => .rightCenter,
    .bottom => .bottomCenter,
  };
}

const double _arrowHeight = 4;
const double _arrowWidth = 9;
const double _arrowOffset = 16;
