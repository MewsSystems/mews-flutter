import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/tooltip/tooltip_arrow.dart';
import 'package:optimus/src/typography/presets.dart';

class OptimusTooltip extends StatelessWidget {
  const OptimusTooltip({
    Key? key,
    required this.content,
    this.size = OptimusToolTipSize.small,
    this.tooltipPosition = OptimusTooltipPosition.topCenter,
  }) : super(key: key);

  final Widget content;
  final OptimusToolTipSize size;
  final OptimusTooltipPosition tooltipPosition;

  Color tooltipColor(OptimusThemeData theme) => theme.colors.neutral1000;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          left: tooltipPosition.arrowLeft,
          top: tooltipPosition.arrowTop,
          right: tooltipPosition.arrowRight,
          bottom: tooltipPosition.arrowBottom,
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

enum OptimusTooltipPosition {
  leftBottom,
  leftCenter,
  leftTop,
  topLeft,
  topCenter,
  topRight,
  rightTop,
  rightCenter,
  rightBottom,
  bottomRight,
  bottomCenter,
  bottomLeft
}

extension on OptimusTooltipPosition {
  EdgeInsets get arrowPadding {
    switch (this) {
      case OptimusTooltipPosition.leftBottom:
      case OptimusTooltipPosition.leftCenter:
      case OptimusTooltipPosition.leftTop:
        return const EdgeInsets.only(right: _arrowPadding);
      case OptimusTooltipPosition.topLeft:
      case OptimusTooltipPosition.topCenter:
      case OptimusTooltipPosition.topRight:
        return const EdgeInsets.only(bottom: _arrowPadding);
      case OptimusTooltipPosition.rightTop:
      case OptimusTooltipPosition.rightCenter:
      case OptimusTooltipPosition.rightBottom:
        return const EdgeInsets.only(left: _arrowPadding);
      case OptimusTooltipPosition.bottomRight:
      case OptimusTooltipPosition.bottomCenter:
      case OptimusTooltipPosition.bottomLeft:
        return const EdgeInsets.only(top: _arrowPadding);
    }
  }

  double? get arrowLeft {
    switch (this) {
      case OptimusTooltipPosition.rightBottom:
      case OptimusTooltipPosition.rightCenter:
      case OptimusTooltipPosition.rightTop:
        return 0;
      case OptimusTooltipPosition.topRight:
      case OptimusTooltipPosition.bottomRight:
        return _arrowAlignOffset;
      case OptimusTooltipPosition.topCenter:
      case OptimusTooltipPosition.topLeft:
      case OptimusTooltipPosition.bottomLeft:
      case OptimusTooltipPosition.bottomCenter:
      case OptimusTooltipPosition.leftBottom:
      case OptimusTooltipPosition.leftCenter:
      case OptimusTooltipPosition.leftTop:
        return null;
    }
  }

  double? get arrowTop {
    switch (this) {
      case OptimusTooltipPosition.rightBottom:
      case OptimusTooltipPosition.leftBottom:
        return _arrowAlignOffset;
      case OptimusTooltipPosition.bottomCenter:
      case OptimusTooltipPosition.bottomLeft:
      case OptimusTooltipPosition.bottomRight:
        return 0;
      case OptimusTooltipPosition.rightCenter:
      case OptimusTooltipPosition.rightTop:
      case OptimusTooltipPosition.topLeft:
      case OptimusTooltipPosition.topCenter:
      case OptimusTooltipPosition.topRight:
      case OptimusTooltipPosition.leftCenter:
      case OptimusTooltipPosition.leftTop:
        return null;
    }
  }

  double? get arrowRight {
    switch (this) {
      case OptimusTooltipPosition.topLeft:
      case OptimusTooltipPosition.bottomLeft:
        return _arrowAlignOffset;
      case OptimusTooltipPosition.leftBottom:
      case OptimusTooltipPosition.leftCenter:
      case OptimusTooltipPosition.leftTop:
        return 0;
      case OptimusTooltipPosition.topCenter:
      case OptimusTooltipPosition.topRight:
      case OptimusTooltipPosition.bottomCenter:
      case OptimusTooltipPosition.bottomRight:
      case OptimusTooltipPosition.rightTop:
      case OptimusTooltipPosition.rightCenter:
      case OptimusTooltipPosition.rightBottom:
        return null;
    }
  }

  double? get arrowBottom {
    switch (this) {
      case OptimusTooltipPosition.rightTop:
      case OptimusTooltipPosition.leftTop:
        return _arrowAlignOffset;
      case OptimusTooltipPosition.topLeft:
      case OptimusTooltipPosition.topCenter:
      case OptimusTooltipPosition.topRight:
        return 0;
      case OptimusTooltipPosition.rightBottom:
      case OptimusTooltipPosition.rightCenter:
      case OptimusTooltipPosition.leftBottom:
      case OptimusTooltipPosition.leftCenter:
      case OptimusTooltipPosition.bottomCenter:
      case OptimusTooltipPosition.bottomLeft:
      case OptimusTooltipPosition.bottomRight:
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
