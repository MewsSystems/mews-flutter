import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
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
    this.description,
  });

  final OptimusProgressIndicatorItemState state;
  final String text;
  final Widget label;
  final Widget? description;

  @override
  State<ProgressIndicatorItem> createState() => _ProgressIndicatorItemState();
}

class _ProgressIndicatorItemState extends State<ProgressIndicatorItem>
    with ThemeGetter {
  bool _isHovered = false;
  bool _isPressed = false;

  bool get _isEnabled =>
      widget.state != OptimusProgressIndicatorItemState.disabled;

  bool get _isCompleted =>
      widget.state == OptimusProgressIndicatorItemState.completed;

  @override
  Widget build(BuildContext context) {
    final indicator = _isEnabled
        ? _EnabledIndicatorItem(
            text: widget.text,
            isCompleted: _isCompleted,
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

    return GestureWrapper(
      onHoverChanged: (value) => setState(() => _isHovered = value),
      onPressedChanged: (value) => setState(() => _isPressed = value),
      child: Padding(
        padding: EdgeInsets.only(top: context.tokens.spacing50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            indicator,
            Padding(
              padding: EdgeInsets.only(top: tokens.spacing100),
              child: ProgressIndicatorDescription(
                label: DefaultTextStyle.merge(
                  style: TextStyle(
                    decoration: _isEnabled && (_isPressed || _isHovered)
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                  child: widget.label,
                ),
                description: widget.description,
                state: widget.state,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnabledIndicatorItem extends StatelessWidget {
  const _EnabledIndicatorItem({
    // required this.state,
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
    final tokens = context.tokens;
    final size = tokens.sizing300;

    final child = isCompleted
        ? Icon(
            OptimusIcons.done,
            color: foregroundColor,
            size: tokens.sizing200,
          )
        : Text(
            text,
            style: tokens.bodySmallStrong.merge(
              TextStyle(color: foregroundColor),
            ),
          );

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
    final verticalSpacerLeftPadding = tokens.sizing500 / 2 + tokens.spacing100;

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

class ProgressIndicatorDescription extends StatelessWidget {
  const ProgressIndicatorDescription({
    super.key,
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
          child: OptimusTypography(
            resolveStyle: (_) => tokens.bodyMediumStrong.copyWith(
              overflow: TextOverflow.ellipsis,
            ),
            align: TextAlign.center,
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

extension OptimusProgressIndicatorItemTheme
    on OptimusProgressIndicatorItemState {
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
        if (isHovered) return tokens.textInteractiveHover;
        if (isPressed) return tokens.textInteractiveActive;

        return tokens.textInteractiveDefault;
      case OptimusProgressIndicatorItemState.active:
        return tokens.textStaticInverse;
      case OptimusProgressIndicatorItemState.enabled:
        return tokens.textStaticPrimary;
      case OptimusProgressIndicatorItemState.disabled:
        return Colors.transparent;
    }
  }

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
