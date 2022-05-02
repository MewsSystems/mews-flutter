import 'package:flutter/material.dart';
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
  Widget _buildPrefix(Widget prefix) => Padding(
        padding: const EdgeInsets.only(right: spacing100),
        child: OptimusTypography(
          color: OptimusTypographyColor.secondary,
          resolveStyle: (_) => preset200s,
          child: prefix,
        ),
      );

  Widget _buildInfo(Widget info) => OptimusTypography(
        resolveStyle: (_) => preset100s,
        color: OptimusTypographyColor.secondary,
        child: info,
      );

  TextStyle get _titleStyle {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return preset300s;
      case FontVariant.bold:
        return preset300b;
    }
  }

  Widget get _title => Padding(
        padding: const EdgeInsets.only(right: spacing100),
        child: OptimusTypography(
          resolveStyle: (_) => _titleStyle,
          child: widget.title,
        ),
      );

  Widget get _subtitle {
    final subtitle = widget.subtitle;

    return subtitle != null
        ? OptimusTypography(
            resolveStyle: (_) => preset200s,
            color: _subtitleColor,
            child: subtitle,
          )
        : const SizedBox.shrink();
  }

  OptimusTypographyColor get _subtitleColor {
    switch (widget.fontVariant) {
      case FontVariant.normal:
        return OptimusTypographyColor.secondary;
      case FontVariant.bold:
        return OptimusTypographyColor.primary;
    }
  }

  Widget _buildSuffix(Widget suffix) => OptimusTypography(
        resolveStyle: (_) => preset200s,
        child: suffix,
      );

  @override
  Widget build(BuildContext context) {
    final prefix = widget.prefix;
    final info = widget.info;
    final suffix = widget.suffix;
    final infoWidget = widget.infoWidget;

    return Container(
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
              if (prefix != null) _buildPrefix(prefix),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(child: _title),
                        if (info != null) _buildInfo(info),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: _subtitle),
                        if (infoWidget != null) infoWidget,
                      ],
                    ),
                  ],
                ),
              ),
              if (suffix != null) _buildSuffix(suffix),
            ],
          ),
        ),
      ),
    );
  }
}

enum FontVariant { normal, bold }
