import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';

class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    Key? key,
    this.text = '',
  }) : super(key: key);

  final String text;

  bool get _hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
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
        minWidth: _hasText ? 20 : 10,
        maxWidth: _hasText ? double.infinity : 10,
      ),
      height: _hasText ? 20 : 10,
      decoration: decoration,
      padding: const EdgeInsets.symmetric(
        horizontal: spacing50,
        vertical: spacing25,
      ),
      child: IntrinsicWidth(
        child: Center(
          child: _hasText
              ? Text(
                  text,
                  textAlign: TextAlign.center,
                  // TODO(KB): Sync with text presets
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.isDark
                        ? theme.colors.neutral1000
                        : theme.colors.neutral0,
                    height: 1,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
