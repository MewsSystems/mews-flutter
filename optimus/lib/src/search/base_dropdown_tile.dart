import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

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

class _BaseDropdownTileState extends State<BaseDropdownTile> with ThemeGetter {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle.merge(style: preset300b, child: widget.title),
            if (widget.subtitle != null)
              DefaultTextStyle.merge(
                style: preset200b.copyWith(color: _subtitleColor),
                child: widget.subtitle!,
              )
          ],
        ),
      );

  Color get _subtitleColor => theme.isDark
      ? theme.colors.invertedSecondaryTextColor
      : theme.colors.secondaryTextColor;
}
