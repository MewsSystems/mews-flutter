import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

class BaseDropdownTile extends StatefulWidget {
  const BaseDropdownTile({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;

  @override
  _BaseDropdownTileState createState() => _BaseDropdownTileState();
}

class _BaseDropdownTileState extends State<BaseDropdownTile> {
  @override
  Widget build(BuildContext context) {
    final subtitle = widget.subtitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          OptimusTypography(
            resolveStyle: (_) => preset300b,
            child: widget.title,
          ),
          if (subtitle != null)
            OptimusTypography(
              resolveStyle: (_) => preset200b,
              color: OptimusTypographyColor.secondary,
              child: subtitle,
            ),
        ],
      ),
    );
  }
}
