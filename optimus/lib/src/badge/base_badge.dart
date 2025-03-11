import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

class BaseBadge extends StatelessWidget {
  const BaseBadge({
    super.key,
    required this.text,
    required this.isOutlined,
    this.overflow = TextOverflow.ellipsis,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
  });

  final String text;
  final bool isOutlined;
  final TextOverflow overflow;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? outlineColor;

  @override
  Widget build(BuildContext context) {
    final hasText = text.isNotEmpty;
    final tokens = context.tokens;
    final backgroundColor =
        this.backgroundColor ?? tokens.backgroundAccentPrimary;
    final textColor = this.textColor ?? tokens.textStaticInverse;
    final outlineColor = this.outlineColor ?? tokens.borderStaticInverse;
    final outlineSize = tokens.borderWidth200;
    final badgeHeight = tokens.sizing200;
    final bareHeight = text.isEmpty ? tokens.spacing100 : badgeHeight;
    final outlinedHeight = bareHeight + outlineSize * 2;
    final height = isOutlined ? outlinedHeight : bareHeight;

    final decoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      color: backgroundColor,
      border:
          isOutlined
              ? Border.all(width: outlineSize, color: outlineColor)
              : null,
    );

    final child =
        hasText
            ? Text(
              text,
              maxLines: 1,
              overflow: overflow,
              textAlign: TextAlign.center,
              style: tokens.bodyExtraSmallStrong.copyWith(color: textColor),
            )
            : null;

    return Container(
      constraints: BoxConstraints(
        minWidth: hasText ? badgeHeight : height,
        maxWidth: hasText ? double.infinity : height,
      ),
      height: height,
      decoration: decoration,
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing50,
        vertical: tokens.spacing25,
      ),
      child: child,
    );
  }
}
