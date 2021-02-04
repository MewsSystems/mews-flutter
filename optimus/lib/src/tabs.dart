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

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: borderSide),
            ),
            child: Material(
              color: Colors.white,
              child: TabBar(
                controller: tabController,
                indicator: _buildIndicator(),
                unselectedLabelColor: OptimusColors.neutral1000t64,
                labelColor: OptimusColors.neutral900,
                indicatorColor: OptimusColors.neutral900,
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

  Decoration _buildIndicator() => const UnderlineTabIndicator(
        borderSide: BorderSide(
          color: OptimusColors.neutral900,
          width: 1,
        ),
        insets: EdgeInsets.only(bottom: -1),
      );
}
