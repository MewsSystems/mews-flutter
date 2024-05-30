import 'package:flutter/material.dart';
import 'package:optimus/src/badge/badge_variant.dart';
import 'package:optimus/src/badge/base_badge.dart';
import 'package:optimus/src/theme/theme.dart';

/// Badges are meant to give a subtle feedback about some state change.
/// Typically used with buttons, tabs and icons.
class OptimusBadge extends StatelessWidget {
  const OptimusBadge({
    super.key,
    this.text = '',
    this.outline = true,
    this.overflow = TextOverflow.ellipsis,
    this.variant = OptimusBadgeVariant.primary,
  });

  /// Text of the badge. If empty, badge will be represented as a simple dot.
  final String text;

  /// Whether to use the outline. Outlined version could be more accessible,
  /// depending on the underlying component.
  final bool outline;

  /// Define how to display the overflowing text. Defaults to
  /// [TextOverflow.ellipsis]. Due to small height of the badge, the
  /// [TextOverflow.fade] is not recommended, as it makes the badge unreadable.
  final TextOverflow overflow;

  /// The color variant of the badge.
  final OptimusBadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return BaseBadge(
      text: text,
      outline: outline,
      textColor: variant.getTextColor(tokens),
      backgroundColor: variant.getBackgroundColor(tokens),
    );
  }
}
