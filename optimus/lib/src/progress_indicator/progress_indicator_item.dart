import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
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

class ProgressIndicatorItem extends StatefulWidget {
  const ProgressIndicatorItem({
    super.key,
    required this.state,
    required this.text,
    required this.label,
    this.itemsCount,
    this.description,
    this.axis = Axis.horizontal,
  });

  final OptimusProgressIndicatorItemState state;
  final String text;
  final Widget label;
  final Widget? description;
  final Axis axis;
  final int? itemsCount;

  @override
  State<ProgressIndicatorItem> createState() => _ProgressIndicatorItemState();
}

class _ProgressIndicatorItemState extends State<ProgressIndicatorItem>
    with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final indicator = widget.state.isEnabled
        ? _EnabledIndicatorItem(
            text: widget.text,
            isCompleted: widget.state.isCompleted,
            foregroundColor: widget.state.getForegroundColor(
              tokens: tokens,
              isHovered: _isHovered,
              isPressed: _isPressed,
            ),
            backgroundColor: widget.state.getBackgroundColor(
              tokens: tokens,
              isHovered: _isHovered,
              isPressed: _isPressed,
            ),
          )
        : const _DisabledIndicatorItem();
    final itemsCount = widget.itemsCount;

    return GestureWrapper(
      onHoverChanged: (value) => setState(() => _isHovered = value),
      onPressedChanged: (value) => setState(() => _isPressed = value),
      child: switch (widget.axis) {
        Axis.horizontal => _HorizontalItem(
            indicator: indicator,
            label: widget.label,
            state: widget.state,
            description: widget.description,
          ),
        Axis.vertical => _VerticalItem(
            indicator: indicator,
            label: widget.label,
            state: widget.state,
            description: widget.description,
            trailing: itemsCount != null && widget.state.isActive
                ? OptimusCaption(
                    variation: Variation.variationSecondary,
                    child: Text('${widget.text}/${itemsCount + 1}'),
                  )
                : null,
          )
      },
    );
  }
}

class _HorizontalItem extends StatelessWidget {
  const _HorizontalItem({
    required this.indicator,
    required this.label,
    required this.state,
    this.description,
  });

  final Widget indicator;
  final Widget label;
  final Widget? description;
  final OptimusProgressIndicatorItemState state;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.only(top: tokens.spacing50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          indicator,
          Padding(
            padding: EdgeInsets.only(top: tokens.spacing100),
            child: _ProgressIndicatorDescription(
              label: label,
              description: description,
              state: state,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalItem extends StatelessWidget {
  const _VerticalItem({
    required this.indicator,
    required this.label,
    required this.state,
    this.description,
    this.trailing,
  });

  final Widget indicator;
  final Widget label;
  final Widget? description;
  final Widget? trailing;
  final OptimusProgressIndicatorItemState state;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: tokens.spacing100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          indicator,
          SizedBox(width: tokens.spacing200),
          _ProgressIndicatorDescription(
            label: label,
            description: description,
            state: state,
          ),
          const Spacer(),
          if (trailing case final trailing?) trailing,
        ],
      ),
    );
  }
}

class _EnabledIndicatorItem extends StatelessWidget {
  const _EnabledIndicatorItem({
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    required this.isCompleted,
  });

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final size = context.indicatorWidth;

    final child = isCompleted
        ? _DoneIndicator(foregroundColor: foregroundColor)
        : _TextIndicator(text: text, foregroundColor: foregroundColor);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(child: child),
    );
  }
}

class _TextIndicator extends StatelessWidget {
  const _TextIndicator({
    required this.text,
    required this.foregroundColor,
  });

  final String text;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: context.tokens.bodySmallStrong.merge(
          TextStyle(color: foregroundColor),
        ),
      );
}

class _DoneIndicator extends StatelessWidget {
  const _DoneIndicator({required this.foregroundColor});

  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) => Icon(
        OptimusIcons.done,
        color: foregroundColor,
        size: context.tokens.sizing200,
      );
}

class _DisabledIndicatorItem extends StatelessWidget {
  const _DisabledIndicatorItem();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = tokens.sizing300;

    return SizedBox(
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

    return switch (layout) {
      Axis.horizontal => Padding(
          padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
          child: SizedBox(
            height: tokens.borderWidth150,
            child: ColoredBox(color: color),
          ),
        ),
      Axis.vertical => Padding(
          padding: EdgeInsets.only(
            left: tokens.spacing150,
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

class _ProgressIndicatorDescription extends StatelessWidget {
  const _ProgressIndicatorDescription({
    required this.label,
    this.description,
    required this.state,
  });

  final Widget label;
  final Widget? description;
  final OptimusProgressIndicatorItemState state;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: DefaultTextStyle.merge(
            style: tokens.bodyMediumStrong.copyWith(
              overflow: TextOverflow.ellipsis,
              color: state.isEnabled
                  ? tokens.textStaticPrimary
                  : tokens.textStaticTertiary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            child: label,
          ),
        ),
        if (description case final description?)
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(top: tokens.spacing25),
              child: OptimusTypography(
                resolveStyle: (_) => tokens.bodySmall.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                align: TextAlign.center,
                color: OptimusTypographyColor.secondary,
                maxLines: 2,
                child: description,
              ),
            ),
          ),
      ],
    );
  }
}

extension on OptimusProgressIndicatorItemState {
  Color? getBackgroundColor({
    required OptimusTokens tokens,
    required bool isHovered,
    required bool isPressed,
  }) {
    switch (this) {
      case OptimusProgressIndicatorItemState.completed:
        if (isPressed) return tokens.backgroundInteractiveSecondaryActive;
        if (isHovered) return tokens.backgroundInteractiveSecondaryHover;

        return tokens.backgroundInteractiveSecondaryDefault;
      case OptimusProgressIndicatorItemState.active:
        return tokens.backgroundInteractivePrimaryDefault;
      case OptimusProgressIndicatorItemState.enabled:
        if (isPressed) return tokens.backgroundInteractiveNeutralActive;
        if (isHovered) return tokens.backgroundInteractiveNeutralHover;

        return tokens.backgroundInteractiveNeutralDefault;
      case OptimusProgressIndicatorItemState.disabled:
        return null;
    }
  }

  Color getForegroundColor({
    required OptimusTokens tokens,
    required bool isHovered,
    required bool isPressed,
  }) {
    switch (this) {
      case OptimusProgressIndicatorItemState.completed:
        if (isHovered) return tokens.textInteractivePrimaryHover;
        if (isPressed) return tokens.textInteractivePrimaryActive;

        return tokens.textInteractivePrimaryDefault;
      case OptimusProgressIndicatorItemState.active:
        return tokens.textStaticInverse;
      case OptimusProgressIndicatorItemState.enabled:
        return tokens.textStaticPrimary;
      case OptimusProgressIndicatorItemState.disabled:
        return Colors.transparent;
    }
  }

  bool get isEnabled => this != OptimusProgressIndicatorItemState.disabled;

  bool get isCompleted => this == OptimusProgressIndicatorItemState.completed;

  bool get isActive => this == OptimusProgressIndicatorItemState.active;

  bool get isAccessible =>
      this == OptimusProgressIndicatorItemState.completed ||
      this == OptimusProgressIndicatorItemState.active;
}
