import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

/// Badges are meant to give a subtle feedback about some state change.
/// Typically used with buttons, tabs and icons.
class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    super.key,
    this.text = '',
    this.outline = true,
  });

  /// Text of the badge. If empty, badge will be represented as a simple dot.
  final String text;

  /// Whether to use the outline. Intended to be enabled when the badge is used
  /// for example on top of the [OptimusButtonVariant.ghost]. Outlined version
  /// could be more accessible, depending on the underlying component.
  final bool outline;

  double get _bareHeight => text.isEmpty ? _emptySize : _badgeHeight;
  double get _outlinedHeight => _bareHeight + _outlineSize * 2;
  double get _height => outline ? _outlinedHeight : _bareHeight;

  @override
  Widget build(BuildContext context) {
    final hasText = text.isNotEmpty;
    final tokens = OptimusTheme.of(context).tokens;
    final backgroundColor = tokens.backgroundAccentPrimary;
    final foregroundColor = tokens.textStaticInverse;
    final outlineColor = tokens.borderStaticInverse;
    final decoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      color: backgroundColor,
      border:
          outline ? Border.all(width: _outlineSize, color: outlineColor) : null,
    );

    final child = hasText
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: baseTextStyle.copyWith(
                  fontSize: 11,
                  letterSpacing: 0.2,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor,
                ),
              ),
            ],
          )
        : null;

    return Container(
      constraints: BoxConstraints(
        minWidth: hasText ? _badgeHeight : _height,
        maxWidth: hasText ? double.infinity : _height,
      ),
      height: _height,
      decoration: decoration,
      padding: const EdgeInsets.symmetric(
        horizontal: spacing50,
        vertical: spacing25,
      ),
      child: child,
    );
  }
}

const _emptySize = spacing100;
const _outlineSize = 2.0;
const _badgeHeight = 16.0;
