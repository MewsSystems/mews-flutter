import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_side.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

class OptimusListTile extends StatefulWidget {
  const OptimusListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.prefix,
    this.suffix,
    this.info,
    this.infoWidget,
    this.onTap,
    this.fontVariant = FontVariant.normal,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? info;
  final Widget? infoWidget;
  final VoidCallback? onTap;
  final FontVariant fontVariant;

  @override
  _OptimusListTileState createState() => _OptimusListTileState();
}

class _OptimusListTileState extends State<OptimusListTile> with ThemeGetter {
  Widget get _prefix => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: OptimusTypography(
          color: OptimusTypographyColor.secondary,
          resolveStyle: (_) => preset200s,
          child: widget.prefix!,
        ),
      );

  Widget get _info => OptimusTypography(
        resolveStyle: (_) => preset100r,
        color: OptimusTypographyColor.secondary,
        child: widget.info!,
      );

  Widget get _title => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: OptimusTypography(
          resolveStyle: (_) {
            switch (widget.fontVariant) {
              case FontVariant.normal:
                return preset300s;
              case FontVariant.bold:
                return preset300b;
            }
          },
          child: widget.title,
        ),
      );

  Widget get _subtitle => widget.subtitle != null
      ? OptimusTypography(
          resolveStyle: (_) => preset200s,
          color: OptimusTypographyColor.secondary,
          child: widget.subtitle!,
        )
      : Container();

  Widget get _suffix => OptimusTypography(
        resolveStyle: (_) => preset200s,
        child: widget.suffix!,
      );

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(border: Border(bottom: borderSide(theme))),
        constraints: const BoxConstraints(minHeight: 94),
        child: InkWell(
          highlightColor:
              theme.isDark ? theme.colors.neutral300 : theme.colors.neutral50,
          hoverColor:
              theme.isDark ? theme.colors.neutral400 : theme.colors.neutral25,
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: spacing300,
              horizontal: spacing200,
            ),
            child: Row(
              children: <Widget>[
                if (widget.prefix != null) _prefix,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: _title),
                          if (widget.info != null) _info,
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: _subtitle),
                          if (widget.infoWidget != null) widget.infoWidget!,
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.suffix != null) _suffix,
              ],
            ),
          ),
        ),
      );
}

enum FontVariant { normal, bold }
