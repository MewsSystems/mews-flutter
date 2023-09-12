import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/badge/base_badge.dart';
import 'package:optimus/src/typography/presets.dart';

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
    final badge = this.badge;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: spacing150),
      height: 48,
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: spacing50),
              child: Icon(icon, size: 16),
            ),
          Text(label, overflow: TextOverflow.ellipsis),
          if (badge != null)
            Padding(
              padding: const EdgeInsets.only(left: spacing50),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 32),
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
          width: 2.5,
        ),
        insets: const EdgeInsets.only(bottom: -1),
      );

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = preset200s;
    final tokens = OptimusTheme.of(context).tokens;

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: tokens.borderStaticSecondary,
                  width: 1.5,
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
