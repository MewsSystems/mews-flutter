import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

class StepBarItem extends StatelessWidget {
  const StepBarItem({
    Key? key,
    required this.maxWidth,
    required this.item,
    required this.state,
    required this.type,
    required this.indicatorText,
  }) : super(key: key);

  final double maxWidth;
  final OptimusStepBarItem item;
  final OptimusStepBarItemState state;
  final OptimusStepBarType type;
  final String indicatorText;

  Widget get _icon {
    switch (type) {
      case OptimusStepBarType.icon:
        return StepBarItemIconIndicator(
          icon: item.icon,
          state: state,
          type: type,
        );
      case OptimusStepBarType.numbered:
        return StepBarItemNumberIndicator(state: state, text: indicatorText);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final description = item.description;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: min(_itemMaxWidth, maxWidth),
        minWidth: _itemMinWidth,
      ),
      child: OptimusEnabled(
        isEnabled: state != OptimusStepBarItemState.disabled,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: _itemLeftPadding),
            _icon,
            const SizedBox(width: spacing100),
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
                        color: theme.isDark
                            ? theme.colors.neutral0t64
                            : theme.colors.neutral1000t64,
                      ),
                      maxLines: 1,
                      child: description,
                    ),
                ],
              ),
            ),
            const SizedBox(width: spacing200),
          ],
        ),
      ),
    );
  }
}

class StepBarItemIconIndicator extends StatelessWidget {
  const StepBarItemIconIndicator({
    Key? key,
    required this.icon,
    required this.state,
    required this.type,
  }) : super(key: key);

  final IconData icon;
  final OptimusStepBarItemState state;
  final OptimusStepBarType type;

  Color _color(OptimusThemeData theme) =>
      state == OptimusStepBarItemState.active
          ? theme.colors.primary500t8
          : Colors.transparent;

  IconData get _icon =>
      state == OptimusStepBarItemState.completed ? OptimusIcons.done : icon;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      width: _iconWrapperSize,
      height: _iconWrapperSize,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _color(theme)),
      child: OptimusIcon(iconData: _icon, colorOption: state.iconColor),
    );
  }
}

class StepBarItemNumberIndicator extends StatelessWidget {
  const StepBarItemNumberIndicator({
    Key? key,
    required this.state,
    required this.text,
  }) : super(key: key);

  final OptimusStepBarItemState state;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    if (state == OptimusStepBarItemState.completed) {
      return const SizedBox(
        width: _iconWrapperSize,
        height: _iconWrapperSize,
        child: OptimusIcon(
          iconData: OptimusIcons.done,
          colorOption: OptimusIconColorOption.primary,
        ),
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: _iconWrapperSize,
            height: _iconWrapperSize,
            decoration: state == OptimusStepBarItemState.active
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colors.primary500t8,
                  )
                : null,
          ),
          Container(
            width: 24,
            height: 24,
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
}

class StepBarSpacer extends StatelessWidget {
  const StepBarSpacer({
    Key? key,
    required this.nextItemState,
    required this.layout,
  }) : super(key: key);

  final OptimusStepBarItemState nextItemState;
  final Axis layout;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final enabled = nextItemState.isAccessible;
    final color = enabled ? theme.colors.primary : theme.colors.neutral1000t32;
    switch (layout) {
      case Axis.horizontal:
        return Flexible(
          child: Container(
            constraints: const BoxConstraints(minWidth: _spacerMinWidth),
            height: _spacerThickness,
            color: color,
          ),
        );
      case Axis.vertical:
        return Padding(
          padding: const EdgeInsets.only(
            left: _verticalSpacerLeftPadding,
            bottom: spacing100,
            top: spacing100,
          ),
          child: SizedBox(
            height: _spacerHeight,
            width: _spacerThickness,
            child: Container(color: color),
          ),
        );
    }
  }
}

extension OptimusStepBarItemTheme on OptimusStepBarItemState {
  Color iconBackgroundColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return theme.colors.primary;
      case OptimusStepBarItemState.active:
        return theme.colors.primary;
      case OptimusStepBarItemState.enabled:
        return theme.isDark
            ? theme.colors.neutral500t40
            : theme.colors.neutral50;
      case OptimusStepBarItemState.disabled:
        return theme.isDark
            ? theme.colors.neutral500t40
            : theme.colors.neutral50;
    }
  }

  Color textColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return theme.colors.primary;
      case OptimusStepBarItemState.active:
        return theme.isDark ? theme.colors.neutral1000 : theme.colors.neutral0;
      case OptimusStepBarItemState.enabled:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
      case OptimusStepBarItemState.disabled:
        return theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;
    }
  }

  OptimusIconColorOption get iconColor {
    switch (this) {
      case OptimusStepBarItemState.completed:
        return OptimusIconColorOption.primary;
      case OptimusStepBarItemState.active:
        return OptimusIconColorOption.primary;
      case OptimusStepBarItemState.enabled:
        return OptimusIconColorOption.basic;
      case OptimusStepBarItemState.disabled:
        return OptimusIconColorOption.basic;
    }
  }

  bool get isAccessible =>
      this == OptimusStepBarItemState.completed ||
      this == OptimusStepBarItemState.active;
}

const _iconWrapperSize = spacing500;
const _itemLeftPadding = spacing100;
const _verticalSpacerLeftPadding = _iconWrapperSize / 2 + _itemLeftPadding;
const double _spacerHeight = 16;
const double _spacerThickness = 1;
const double _itemMinWidth = 112;
const double _itemMaxWidth = 320;
const double _spacerMinWidth = 16;
