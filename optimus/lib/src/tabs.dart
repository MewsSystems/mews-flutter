import 'package:flutter/material.dart';
import 'package:optimus/src/badge/badge_variant.dart';
import 'package:optimus/src/badge/base_badge.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';
import 'package:optimus/src/theme/theme.dart';

/// A tab that is displayed in the [OptimusTabBar].
class OptimusTab extends StatelessWidget {
  const OptimusTab({
    super.key,
    required this.label,
    this.icon,
    this.badge,
    this.badgeVariant = OptimusBadgeVariant.primary,
    this.maxWidth,
  });

  /// Icon to be displayed on the left side of the label.
  final IconData? icon;

  /// Label of the tab.
  final String label;

  /// Badge text. Typically used for the counter.
  final String? badge;

  /// The color variant of the badge.
  final OptimusBadgeVariant badgeVariant;

  /// The maximum width of the tab.
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      height: tokens.sizing600,
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: tokens.spacing50),
              child: Icon(icon, size: tokens.sizing200),
            ),
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
          if (badge case final badge?)
            Padding(
              padding: EdgeInsets.only(left: tokens.spacing50),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: tokens.sizing400),
                child: BaseBadge(
                  text: badge,
                  isOutlined: false,
                  textColor: badgeVariant.getTextColor(tokens),
                  backgroundColor: badgeVariant.getBackgroundColor(tokens),
                ),
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
    this.isScrollable = false,
    this.tabPadding,
  });

  /// The list of child tabs.
  final List<Widget> tabs;

  /// The list of child pages.
  final List<Widget> pages;

  /// The optional tab controller, for adding listeners and control the tab flow.
  final TabController? tabController;

  /// Defines if the [OptimusTabBar] is scrollable. The scroll is enabled in the horizontal axis only.
  final bool isScrollable;

  /// A padding between tabs. Defaults to the horizontal padding with [tokens.spacing150].
  final EdgeInsets? tabPadding;

  Decoration _buildIndicator(OptimusTokens tokens) => UnderlineTabIndicator(
        borderSide: BorderSide(
          color: tokens.borderInteractivePrimaryDefault,
          width: tokens.borderWidth250,
        ),
        insets: const EdgeInsets.only(bottom: -1),
      );

  TabAlignment? get _tabAlignment => isScrollable ? null : TabAlignment.fill;

  EdgeInsets _getLabelPadding(OptimusTokens tokens) =>
      tabPadding ?? EdgeInsets.symmetric(horizontal: tokens.spacing150);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final textStyle = tokens.bodyMediumStrong;

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
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
                isScrollable: isScrollable,
                splashFactory: NoSplash.splashFactory,
                labelPadding: _getLabelPadding(tokens),
                tabAlignment: _tabAlignment,
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
