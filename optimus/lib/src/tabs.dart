import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/badge/base_badge.dart';

class OptimusTab extends StatelessWidget {
  const OptimusTab({
    super.key,
    required this.label,
    this.icon,
    this.badge,
    this.maxWidth,
  });

  final IconData? icon;
  final String label;
  final String? badge;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing150),
      height: 48,
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: tokens.spacing50),
              child: Icon(icon, size: tokens.sizing200),
            ),
          Text(label, overflow: TextOverflow.ellipsis),
          if (badge case final badge?)
            Padding(
              padding: EdgeInsets.only(left: tokens.spacing50),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: tokens.sizing400),
                child: BaseBadge(text: badge, outline: false),
              ),
            ),
        ],
      ),
    );
  }
}

class OptimusTabBar extends StatelessWidget {
  const OptimusTabBar({
    super.key,
    required this.tabs,
    required this.pages,
    this.tabController,
  });

  final List<Widget> tabs;
  final List<Widget> pages;
  final TabController? tabController;

  Decoration _buildIndicator(OptimusTokens tokens) => UnderlineTabIndicator(
        borderSide: BorderSide(
          color: tokens.borderInteractivePrimaryDefault,
          width: tokens.borderWidth250,
        ),
        insets: const EdgeInsets.only(bottom: -1),
      );

  @override
  Widget build(BuildContext context) {
    final tokens = OptimusTheme.of(context).tokens;
    final textStyle = tokens.bodyMediumStrong;

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: tokens.borderStaticSecondary,
                  width: tokens.borderWidth150,
                ),
              ),
            ),
            child: Material(
              color: tokens.backgroundStaticFlat,
              child: TabBar(
                controller: tabController,
                indicator: _buildIndicator(tokens),
                unselectedLabelColor: tokens.textStaticTertiary,
                labelColor: tokens.textStaticPrimary,
                tabs: tabs,
                unselectedLabelStyle: textStyle,
                labelStyle: textStyle,
                splashBorderRadius: null,
                splashFactory: NoSplash.splashFactory,
                labelPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}
