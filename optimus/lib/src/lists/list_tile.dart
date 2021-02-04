import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusListTile extends StatelessWidget {
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
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          border: Border(bottom: borderSide),
        ),
        constraints: const BoxConstraints(minHeight: 94),
        child: InkWell(
          highlightColor: OptimusColors.neutral50,
          hoverColor: OptimusColors.neutral25,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: spacing300, horizontal: spacing200),
            child: Row(
              children: <Widget>[
                if (prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: prefix,
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: _buildTitle()),
                          if (info != null) _buildInfo(),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: subtitle != null
                                ? _buildSubTitle()
                                : Container(),
                          ),
                          if (infoWidget != null) infoWidget,
                        ],
                      ),
                    ],
                  ),
                ),
                if (suffix != null) suffix
              ],
            ),
          ),
        ),
      );

  Widget _buildTitle() => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: _wrapped(title, _titleStyle),
      );

  Widget _buildSubTitle() => _wrapped(subtitle, _subtitleStyle);

  Widget _buildInfo() => _wrapped(info, _infoStyle);

  TextStyle get _titleStyle {
    switch (fontVariant) {
      case FontVariant.normal:
        return preset300m;
      case FontVariant.bold:
        return preset300s;
      default:
        return preset300m;
    }
  }

  TextStyle get _subtitleStyle {
    switch (fontVariant) {
      case FontVariant.normal:
        return preset200m.copyWith(
          color: OptimusColors.neutral1000t64,
        );
      case FontVariant.bold:
        return preset200m;
      default:
        return preset200m.copyWith(
          color: OptimusColors.neutral1000t64,
        );
    }
  }

  TextStyle get _infoStyle =>
      preset100m.copyWith(color: OptimusColors.neutral1000t64);

  Widget _wrapped(Widget child, TextStyle style) =>
      DefaultTextStyle.merge(style: style, child: child);
}

enum FontVariant { normal, bold }
