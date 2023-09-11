import 'package:flutter/widgets.dart';
import 'package:optimus/src/spacing.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/typography/presets.dart';

class BaseBadge extends StatelessWidget {
  const BaseBadge({
    super.key,
    required this.text,
    required this.outline,
    this.overflow = TextOverflow.ellipsis,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
  });

  final String text;
  final bool outline;
  final TextOverflow overflow;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? outlineColor;

  double get _bareHeight => text.isEmpty ? _emptySize : _badgeHeight;
  double get _outlinedHeight => _bareHeight + _outlineSize * 2;
  double get _height => outline ? _outlinedHeight : _bareHeight;

  @override
  Widget build(BuildContext context) {
    final hasText = text.isNotEmpty;
    final tokens = OptimusTheme.of(context).tokens;
    final backgroundColor =
        this.backgroundColor ?? tokens.backgroundAccentPrimary;
    final textColor = this.textColor ?? tokens.textStaticInverse;
    final outlineColor = this.outlineColor ?? tokens.borderStaticInverse;
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
                maxLines: 1,
                overflow: overflow,
                textAlign: TextAlign.center,
                style: baseTextStyle.copyWith(
                  fontSize: 11,
                  letterSpacing: 0.2,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  color: textColor,
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
