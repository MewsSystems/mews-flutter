import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/progress_indicator/common.dart';
import 'package:optimus/src/typography/typography.dart';

/// Both types of step have dedicated states. State is shown through a visual
/// change in the step indicator and in the divider between steps.
/// All of this forms a visual distinction between the finished and unfinished
/// part of a process.
enum OptimusProgressIndicatorItemState {
  /// The step is finished. The icon is always changed to a check icon.
  completed,

  /// The step is active and unfinished.
  active,

  /// The step is inactive and unfinished.
  enabled,

  /// The step is disabled and unavailable.
  disabled,
}

class OptimusProgressIndicatorItem {
  const OptimusProgressIndicatorItem({
    required this.label,
    this.description,
    required this.icon,
  });

  final Widget label;
  final Widget? description;
  final IconData icon;
}

class ProgressIndicatorItem extends StatelessWidget {
  const ProgressIndicatorItem({
    super.key,
    required this.maxWidth,
    required this.item,
    required this.state,
    required this.indicatorText,
    this.axis = Axis.horizontal,
  });

  final double maxWidth;
  final OptimusProgressIndicatorItem item;
  final OptimusProgressIndicatorItemState state;
  final String indicatorText;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final description = item.description;

    return axis == Axis.horizontal
        ? ConstrainedBox(
            constraints: const BoxConstraints(minWidth: itemMinWidth),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: tokens.spacing100),
                  child: ProgressIndicatorItemNumber(
                    state: state,
                    text: indicatorText,
                  ),
                ),
                OptimusTypography(
                  resolveStyle: (_) => tokens.bodyMediumStrong.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                  child: item.label,
                ),
                if (description != null)
                  Padding(
                    padding: EdgeInsets.only(top: tokens.spacing25),
                    child: OptimusTypography(
                      resolveStyle: (_) => tokens.bodySmall.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      color: OptimusTypographyColor.secondary,
                      maxLines: 1,
                      child: description,
                    ),
                  ),
              ],
            ),
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(minWidth: itemMinWidth),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: tokens.spacing100),
                  child: ProgressIndicatorItemNumber(
                    state: state,
                    text: indicatorText,
                  ),
                ),
                Column(
                  children: [
                    OptimusTypography(
                      resolveStyle: (_) => tokens.bodyMediumStrong.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                      child: item.label,
                    ),
                    if (description != null)
                      Padding(
                        padding: EdgeInsets.only(top: tokens.spacing25),
                        child: OptimusTypography(
                          resolveStyle: (_) => tokens.bodySmall.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                          color: OptimusTypographyColor.secondary,
                          maxLines: 1,
                          child: description,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
  }
}

class ProgressIndicatorItemNumber extends StatelessWidget {
  const ProgressIndicatorItemNumber({
    super.key,
    required this.state,
    required this.text,
  });

  final OptimusProgressIndicatorItemState state;
  final String text;

  bool get _isEnabled => state != OptimusProgressIndicatorItemState.disabled;

  bool get _isCompleted => state == OptimusProgressIndicatorItemState.completed;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = tokens.sizing300;

    return _isEnabled
        ? Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: state.iconBackgroundColor(tokens),
            ),
            child: Center(
              child: _isCompleted
                  ? const OptimusIcon(
                      iconData: OptimusIcons.done,
                      colorOption: OptimusIconColorOption.primary,
                      iconSize: OptimusIconSize.small,
                    )
                  : Text(
                      text,
                      style: tokens.bodySmallStrong.merge(
                        TextStyle(color: state.textColor(tokens)),
                      ),
                    ),
            ),
          )
        : SizedBox(
            height: size,
            width: size,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: tokens.sizing100,
                  maxWidth: tokens.sizing100,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: tokens.borderWidth150,
                    color: tokens.borderStaticPrimary,
                  ),
                ),
              ),
            ),
          );
  }
}

class ProgressIndicatorSpacer extends StatelessWidget {
  const ProgressIndicatorSpacer({
    super.key,
    required this.nextItemState,
    required this.layout,
  });

  final OptimusProgressIndicatorItemState nextItemState;
  final Axis layout;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final enabled = nextItemState.isAccessible;
    final color = enabled
        ? tokens.borderInteractivePrimaryDefault
        : tokens.borderStaticPrimary;
    final verticalSpacerLeftPadding = tokens.sizing500 / 2 + tokens.spacing100;
    final verticalMargin =
        tokens.sizing300 / 2; // center of the circle indicator

    return switch (layout) {
      Axis.horizontal => Container(
          margin: EdgeInsets.only(top: verticalMargin),
          constraints: BoxConstraints(minWidth: tokens.sizing200),
          height: tokens.borderWidth150,
          color: color,
        ),
      Axis.vertical => Padding(
          padding: EdgeInsets.only(
            left: verticalSpacerLeftPadding,
            bottom: tokens.spacing100,
            top: tokens.spacing100,
          ),
          child: SizedBox(
            height: tokens.sizing200,
            width: tokens.borderWidth150,
            child: Container(color: color),
          ),
        ),
    };
  }
}

extension OptimusProgressIndicatorItemTheme
    on OptimusProgressIndicatorItemState {
  Color iconBackgroundColor(OptimusTokens tokens) => switch (this) {
        OptimusProgressIndicatorItemState.completed =>
          tokens.backgroundInteractiveSecondaryDefault,
        OptimusProgressIndicatorItemState.active =>
          tokens.backgroundInteractivePrimaryDefault,
        OptimusProgressIndicatorItemState.enabled =>
          tokens.backgroundInteractiveNeutralDefault,
        OptimusProgressIndicatorItemState.disabled => Colors.transparent,
      };

  Color textColor(OptimusTokens tokens) => switch (this) {
        OptimusProgressIndicatorItemState.completed =>
          tokens.textInteractiveDefault,
        OptimusProgressIndicatorItemState.active => tokens.textStaticInverse,
        OptimusProgressIndicatorItemState.enabled => tokens.textStaticPrimary,
        OptimusProgressIndicatorItemState.disabled => Colors.transparent,
      };

  OptimusIconColorOption get iconColor => switch (this) {
        OptimusProgressIndicatorItemState.completed =>
          OptimusIconColorOption.primary,
        OptimusProgressIndicatorItemState.active =>
          OptimusIconColorOption.inverse,
        OptimusProgressIndicatorItemState.enabled ||
        OptimusProgressIndicatorItemState.disabled =>
          OptimusIconColorOption.basic,
      };

  bool get isAccessible =>
      this == OptimusProgressIndicatorItemState.completed ||
      this == OptimusProgressIndicatorItemState.active;
}
