import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_alignment.dart';
import 'package:optimus/src/tooltip/tooltip_arrow.dart';
import 'package:optimus/src/typography/presets.dart';

/// Tooltip displays contextual content upon the click or focus of a UI trigger
/// element. Tooltip's content should be contextual, helpful, and nonessential
/// while providing that extra ability to communicate and give clarity to a
/// user.
class OptimusTooltip extends StatelessWidget {
  const OptimusTooltip({
    Key? key,
    required this.content,
    this.size = OptimusToolTipSize.small,
    this.tooltipPosition = OptimusTooltipPosition.top,
  }) : super(key: key);

  /// The content of the tooltip. Typically a [Text] widget.
  /// Tooltip's content should be contextual, helpful, and nonessential.
  /// Tooltips should never contain essential content.
  final Widget content;

  /// The size of the tooltip. Defaults to [OptimusToolTipSize.small].
  final OptimusToolTipSize size;

  /// The position of the tooltip.
  final OptimusTooltipPosition tooltipPosition;

  Color tooltipColor(OptimusThemeData theme) => theme.colors.neutral1000;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final alignment = tooltipPosition.toTooltipAlignment();

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          left: alignment.arrowLeft,
          top: alignment.arrowTop,
          right: alignment.arrowRight,
          bottom: alignment.arrowBottom,
          child: TooltipArrow(
            position: tooltipPosition,
            color: tooltipColor(theme),
          ),
        ),
        Padding(
          padding: tooltipPosition.arrowPadding,
          child: Container(
            width: size.maxWidth,
            padding: const EdgeInsets.symmetric(
              vertical: spacing50,
              horizontal: spacing100,
            ),
            decoration: BoxDecoration(
              color: tooltipColor(theme),
              borderRadius: const BorderRadius.all(borderRadius100),
            ),
            child: Material(
              color: tooltipColor(theme),
              child: DefaultTextStyle.merge(
                style: preset100b.copyWith(color: theme.colors.neutral0),
                textAlign: TextAlign.center,
                child: content,
              ),
            ),
          ),
        )
      ],
    );
  }
}

enum OptimusToolTipSize { small, medium, large }

enum OptimusTooltipPosition { top, bottom, left, right }

extension on OptimusTooltipPosition {
  EdgeInsets get arrowPadding {
    switch (this) {
      case OptimusTooltipPosition.left:
        return const EdgeInsets.only(right: _arrowPadding);
      case OptimusTooltipPosition.top:
        return const EdgeInsets.only(bottom: _arrowPadding);
      case OptimusTooltipPosition.right:
        return const EdgeInsets.only(left: _arrowPadding);
      case OptimusTooltipPosition.bottom:
        return const EdgeInsets.only(top: _arrowPadding);
    }
  }

  TooltipAlignment toTooltipAlignment() {
    switch (this) {
      case OptimusTooltipPosition.left:
        return TooltipAlignment.leftCenter;
      case OptimusTooltipPosition.top:
        return TooltipAlignment.topCenter;
      case OptimusTooltipPosition.right:
        return TooltipAlignment.rightCenter;
      case OptimusTooltipPosition.bottom:
        return TooltipAlignment.bottomCenter;
    }
  }
}

extension on TooltipAlignment {
  double? get arrowLeft {
    switch (this) {
      case TooltipAlignment.rightBottom:
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.rightTop:
        return 0;
      case TooltipAlignment.topRight:
      case TooltipAlignment.bottomRight:
        return _arrowAlignOffset;
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topLeft:
      case TooltipAlignment.bottomLeft:
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.leftBottom:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.leftTop:
        return null;
    }
  }

  double? get arrowTop {
    switch (this) {
      case TooltipAlignment.rightBottom:
      case TooltipAlignment.leftBottom:
        return _arrowAlignOffset;
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.bottomLeft:
      case TooltipAlignment.bottomRight:
        return 0;
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.rightTop:
      case TooltipAlignment.topLeft:
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topRight:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.leftTop:
        return null;
    }
  }

  double? get arrowRight {
    switch (this) {
      case TooltipAlignment.topLeft:
      case TooltipAlignment.bottomLeft:
        return _arrowAlignOffset;
      case TooltipAlignment.leftBottom:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.leftTop:
        return 0;
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topRight:
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.bottomRight:
      case TooltipAlignment.rightTop:
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.rightBottom:
        return null;
    }
  }

  double? get arrowBottom {
    switch (this) {
      case TooltipAlignment.rightTop:
      case TooltipAlignment.leftTop:
        return _arrowAlignOffset;
      case TooltipAlignment.topLeft:
      case TooltipAlignment.topCenter:
      case TooltipAlignment.topRight:
        return 0;
      case TooltipAlignment.rightBottom:
      case TooltipAlignment.rightCenter:
      case TooltipAlignment.leftBottom:
      case TooltipAlignment.leftCenter:
      case TooltipAlignment.bottomCenter:
      case TooltipAlignment.bottomLeft:
      case TooltipAlignment.bottomRight:
        return null;
    }
  }
}

extension on OptimusToolTipSize {
  double get maxWidth {
    switch (this) {
      case OptimusToolTipSize.small:
        return 100;
      case OptimusToolTipSize.medium:
        return 200;
      case OptimusToolTipSize.large:
        return 300;
    }
  }
}

const double _arrowPadding = 5;
const double _arrowAlignOffset = 7.0;
