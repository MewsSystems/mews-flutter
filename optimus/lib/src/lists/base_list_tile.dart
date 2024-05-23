import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

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
    final tokens = context.tokens;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: tokens.borderStaticSecondary)),
      ),
      constraints: BoxConstraints(minHeight: tokens.spacing700),
      child: InkWell(
        highlightColor: tokens.backgroundInteractiveNeutralSubtleActive,
        hoverColor: tokens.backgroundInteractiveNeutralSubtleHover,
        onTap: onTap,
        splashColor: Colors.transparent,
        child: content,
      ),
    );
  }
}
