import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

class BaseDropdownTile extends StatelessWidget {
  const BaseDropdownTile({
    super.key,
    required this.title,
    this.subtitle,
  });

  final Widget title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          OptimusTypography(
            resolveStyle: (_) => preset300s,
            child: title,
          ),
          if (subtitle != null)
            OptimusTypography(
              resolveStyle: (_) => preset200s,
              color: OptimusTypographyColor.secondary,
              child: subtitle,
            ),
        ],
      ),
    );
  }
}
