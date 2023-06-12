import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    super.key,
    this.text = '',
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final hasText = text.isNotEmpty;
    final theme = OptimusTheme.of(context);
    final decoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: theme.colors.primary,
      border: Border.all(
        width: 2,
        color: theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
      ),
    );

    return Container(
      constraints: BoxConstraints(
        minWidth: hasText ? 20 : 10,
        maxWidth: hasText ? double.infinity : 10,
      ),
      height: hasText ? 20 : 10,
      decoration: decoration,
      padding: const EdgeInsets.symmetric(
        horizontal: spacing50,
        vertical: spacing25,
      ),
      child: IntrinsicWidth(
        child: Center(
          child: hasText
              ? Text(
                  text,
                  textAlign: TextAlign.center,
                  style: preset50b.copyWith(
                    color: theme.isDark
                        ? theme.colors.neutral1000
                        : theme.colors.neutral0,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
