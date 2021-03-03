import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusTab extends StatelessWidget {
  const OptimusTab({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Tab(child: Text(text));
}

class OptimusTabBar extends StatelessWidget {
  const OptimusTabBar({
    Key key,
    @required this.tabs,
    @required this.pages,
    this.tabController,
  }) : super(key: key);

  final List<Widget> tabs;
  final List<Widget> pages;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    // Think about better implementation with typography components
    final TextStyle textStyle = preset100s;
    final theme = OptimusTheme.of(context);

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: borderSide(theme)),
            ),
            child: Material(
              color: theme.isDark
                  ? theme.colors.neutral500
                  : theme.colors.neutral0,
              child: TabBar(
                controller: tabController,
                indicator: _buildIndicator(theme),
                unselectedLabelColor: theme.isDark
                    ? theme.colors.neutral0t64
                    : theme.colors.neutral1000t64,
                labelColor: theme.isDark
                    ? theme.colors.neutral0
                    : theme.colors.neutral1000,
                tabs: tabs,
                unselectedLabelStyle: textStyle,
                labelStyle: textStyle,
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

  Decoration _buildIndicator(OptimusThemeData theme) => UnderlineTabIndicator(
        borderSide: BorderSide(
          color:
              theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000,
          width: 1,
        ),
        insets: const EdgeInsets.only(bottom: -1),
      );
}
