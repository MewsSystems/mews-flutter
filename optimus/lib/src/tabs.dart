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
    final tokens = context.tokens;
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
