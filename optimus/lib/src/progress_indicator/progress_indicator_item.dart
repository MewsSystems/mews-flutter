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
  });

  final double maxWidth;
  final OptimusProgressIndicatorItem item;
  final OptimusProgressIndicatorItemState state;
  final String indicatorText;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final description = item.description;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: itemMinWidth),
      child: OptimusEnabled(
        isEnabled: state != OptimusProgressIndicatorItemState.disabled,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: tokens.spacing100),
            _Indicator(
              state: state,
              text: indicatorText,
            ),
            SizedBox(width: tokens.spacing100),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptimusTypography(
                    resolveStyle: (_) => tokens.bodyMedium.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    child: item.label,
                  ),
                  if (description != null)
                    OptimusTypography(
                      resolveStyle: (_) => tokens.bodyMediumStrong.copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      color: OptimusTypographyColor.secondary,
                      maxLines: 1,
                      child: description,
                    ),
                ],
              ),
            ),
            SizedBox(width: tokens.spacing200),
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.state,
    required this.text,
  });

  final OptimusProgressIndicatorItemState state;
  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = OptimusTheme.of(context);
    final iconSize = tokens.sizing300;

    return state == OptimusProgressIndicatorItemState.completed
        ? SizedBox(
            width: tokens.sizing500,
            height: tokens.sizing500,
            child: const OptimusIcon(
              iconData: OptimusIcons.done,
              colorOption: OptimusIconColorOption.primary,
            ),
          )
        : Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: tokens.sizing500,
                height: tokens.sizing500,
                decoration: state == OptimusProgressIndicatorItemState.active
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colors.primary500t8,
                      )
                    : null,
              ),
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: state.iconBackgroundColor(theme),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: tokens.bodyMedium.merge(
                      TextStyle(
                        height: 1,
                        color: state.textColor(theme),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
    final theme = OptimusTheme.of(context);
    final tokens = context.tokens;
    final enabled = nextItemState.isAccessible;
    final color = enabled ? theme.colors.primary : theme.colors.neutral1000t32;
    final verticalSpacerLeftPadding = tokens.sizing500 / 2 + tokens.spacing100;

    return switch (layout) {
      Axis.horizontal => Flexible(
          child: Container(
            constraints: BoxConstraints(minWidth: tokens.sizing200),
            height: _spacerThickness,
            color: color,
          ),
        ),
      Axis.vertical => Padding(
          padding: EdgeInsets.only(
            left: verticalSpacerLeftPadding,
            bottom: tokens.spacing100,
            top: tokens.spacing100,
          ),
          child: SizedBox(
            height: tokens.sizing200,
            width: _spacerThickness,
            child: Container(color: color),
          ),
        ),
    };
  }
}

extension OptimusProgressIndicatorItemTheme
    on OptimusProgressIndicatorItemState {
  Color iconBackgroundColor(OptimusThemeData theme) => switch (this) {
        OptimusProgressIndicatorItemState.completed ||
        OptimusProgressIndicatorItemState.active =>
          theme.colors.primary,
        OptimusProgressIndicatorItemState.enabled ||
        OptimusProgressIndicatorItemState.disabled =>
          theme.isDark ? theme.colors.neutral500t40 : theme.colors.neutral50,
      };

  Color textColor(OptimusThemeData theme) => switch (this) {
        OptimusProgressIndicatorItemState.completed => theme.colors.primary,
        OptimusProgressIndicatorItemState.active =>
          theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0,
        OptimusProgressIndicatorItemState.enabled ||
        OptimusProgressIndicatorItemState.disabled =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000,
      };

  OptimusIconColorOption get iconColor => switch (this) {
        OptimusProgressIndicatorItemState.completed ||
        OptimusProgressIndicatorItemState.active =>
          OptimusIconColorOption.primary,
        OptimusProgressIndicatorItemState.enabled ||
        OptimusProgressIndicatorItemState.disabled =>
          OptimusIconColorOption.basic,
      };

  bool get isAccessible =>
      this == OptimusProgressIndicatorItemState.completed ||
      this == OptimusProgressIndicatorItemState.active;
}

const double _spacerThickness = 1;
