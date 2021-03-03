import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_side.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusListTile extends StatefulWidget {
  const OptimusListTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.prefix,
    this.suffix,
    this.info,
    this.infoWidget,
    this.onTap,
    this.fontVariant = FontVariant.normal,
  }) : super(key: key);

  final Widget title;
  final Widget subtitle;
  final Widget prefix;
  final Widget suffix;
  final Widget info;
  final Widget infoWidget;
  final VoidCallback onTap;
  final FontVariant fontVariant;

  @override
  _OptimusListTileState createState() => _OptimusListTileState();
}

class _OptimusListTileState extends State<OptimusListTile> with ThemeGetter {
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
                if (widget.prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: widget.prefix,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: _buildTitle()),
                          if (widget.info != null) _buildInfo(),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.subtitle != null
                                ? _buildSubTitle()
                                : Container(),
                          ),
                          if (widget.infoWidget != null) widget.infoWidget,
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.suffix != null) widget.suffix
              ],
            ),
          ),
        ),
      );

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: _wrapped(widget.title, _titleStyle),
      );

  Widget _buildSubTitle() => _wrapped(widget.subtitle, _subtitleStyle);

  Widget _buildInfo() => _wrapped(widget.info, _infoStyle);

  TextStyle get _titleStyle {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return preset300m;
      case FontVariant.bold:
        return preset300s;
      default:
        return preset300m;
    }
  }

  // ignore: missing_return
  TextStyle get _subtitleStyle {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return preset200m.copyWith(color: _subtitleColor);
      case FontVariant.bold:
        return preset200m;
    }
  }

  Color get _subtitleColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64;

  TextStyle get _infoStyle => preset100m.copyWith(
        color: theme.isDark
            ? theme.colors.neutral0t64
            : theme.colors.neutral1000t64,
      );

  Widget _wrapped(Widget child, TextStyle style) =>
      DefaultTextStyle.merge(style: style, child: child);
}

enum FontVariant { normal, bold }
