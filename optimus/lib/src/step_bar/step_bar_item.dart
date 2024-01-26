import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/step_bar/common.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

/// Both types of step have dedicated states. State is shown through a visual
/// change in the step indicator and in the divider between steps.
/// All of this forms a visual distinction between the finished and unfinished
/// part of a process.
enum OptimusStepBarItemState {
  /// The step is finished. The icon is always changed to a check icon.
  completed,

  /// The step is active and unfinished.
  active,

  /// The step is inactive and unfinished.
  enabled,

  /// The step is disabled and unavailable.
  disabled,
}

class OptimusStepBarItem {
  const OptimusStepBarItem({
    required this.label,
    this.description,
    required this.icon,
  });

  final Widget label;
  final Widget? description;
  final IconData icon;
}

class StepBarItem extends StatelessWidget {
  const StepBarItem({
    super.key,
    required this.maxWidth,
    required this.item,
    required this.state,
    required this.type,
    required this.indicatorText,
  });

  final double maxWidth;
  final OptimusStepBarItem item;
  final OptimusStepBarItemState state;
  final OptimusStepBarType type;
  final String indicatorText;

  Widget get _icon => switch (type) {
        OptimusStepBarType.icon => StepBarItemIconIndicator(
            icon: item.icon,
            state: state,
            type: type,
          ),
        OptimusStepBarType.numbered =>
          StepBarItemNumberIndicator(state: state, text: indicatorText),
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final description = item.description;

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: itemMinWidth),
      child: OptimusEnabled(
        isEnabled: state != OptimusStepBarItemState.disabled,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: tokens.spacing100),
            _icon,
            SizedBox(width: tokens.spacing100),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptimusTypography(
                    resolveStyle: (_) =>
                        preset200b.copyWith(overflow: TextOverflow.ellipsis),
                    maxLines: 1,
                    child: item.label,
                  ),
                  if (description != null)
                    OptimusTypography(
                      resolveStyle: (_) => preset200s.copyWith(
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

class StepBarItemIconIndicator extends StatelessWidget {
  const StepBarItemIconIndicator({
    super.key,
    required this.icon,
    required this.state,
    required this.type,
  });

  final IconData icon;
  final OptimusStepBarItemState state;
  final OptimusStepBarType type;

  Color _color(OptimusThemeData theme) =>
      state == OptimusStepBarItemState.active
          ? theme.colors.primary500t8 // TODO(witwash): replace with tokens
          : Colors.transparent;

  IconData get _icon =>
      state == OptimusStepBarItemState.completed ? OptimusIcons.done : icon;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      width: context.tokens.sizing500,
      height: context.tokens.sizing500,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color(theme)),
      child: OptimusIcon(iconData: _icon, colorOption: state.iconColor),
    );
  }
}

class StepBarItemNumberIndicator extends StatelessWidget {
  const StepBarItemNumberIndicator({
    super.key,
    required this.state,
    required this.text,
  });

  final OptimusStepBarItemState state;
  final String text;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = OptimusTheme.of(context);
    final iconSize = tokens.sizing300;

    return state == OptimusStepBarItemState.completed
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
                decoration: state == OptimusStepBarItemState.active
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
                    style: preset200b.merge(
                      TextStyle(height: 1, color: state.textColor(theme)),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}

class StepBarSpacer extends StatelessWidget {
  const StepBarSpacer({
    super.key,
    required this.nextItemState,
    required this.layout,
  });

  final OptimusStepBarItemState nextItemState;
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

extension OptimusStepBarItemTheme on OptimusStepBarItemState {
  Color iconBackgroundColor(OptimusThemeData theme) => switch (this) {
        OptimusStepBarItemState.completed ||
        OptimusStepBarItemState.active =>
          theme.colors.primary,
        OptimusStepBarItemState.enabled ||
        OptimusStepBarItemState.disabled =>
          theme.isDark ? theme.colors.neutral500t40 : theme.colors.neutral50,
      };

  Color textColor(OptimusThemeData theme) => switch (this) {
        OptimusStepBarItemState.completed => theme.colors.primary,
        OptimusStepBarItemState.active =>
          theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0,
        OptimusStepBarItemState.enabled ||
        OptimusStepBarItemState.disabled =>
          theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000,
      };

  OptimusIconColorOption get iconColor => switch (this) {
        OptimusStepBarItemState.completed ||
        OptimusStepBarItemState.active =>
          OptimusIconColorOption.primary,
        OptimusStepBarItemState.enabled ||
        OptimusStepBarItemState.disabled =>
          OptimusIconColorOption.basic,
      };

  bool get isAccessible =>
      this == OptimusStepBarItemState.completed ||
      this == OptimusStepBarItemState.active;
}

const double _spacerThickness = 1;
