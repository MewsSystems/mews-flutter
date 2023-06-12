import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_side.dart';

class BaseListTile extends StatelessWidget {
  const BaseListTile({
    super.key,
    required this.content,
    this.onTap,
  });

  final Widget content;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      decoration: BoxDecoration(border: Border(bottom: borderSide(theme))),
      constraints: const BoxConstraints(minHeight: spacing700),
      child: InkWell(
        highlightColor:
            theme.isDark ? theme.colors.neutral300 : theme.colors.neutral50,
        hoverColor:
            theme.isDark ? theme.colors.neutral400 : theme.colors.neutral25,
        onTap: onTap,
        splashColor: Colors.transparent,
        child: content,
      ),
    );
  }
}
