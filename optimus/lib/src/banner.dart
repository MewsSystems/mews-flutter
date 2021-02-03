import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/typography/styles.dart';

enum OptimusBannerVariant {
  /// To display an informative message.
  primary,

  /// To inform a user about a successful event.
  success,

  /// To display information that needs user attention.
  warning,

  /// To inform a user of potential danger or that something has gone wrong.
  error
}

/// Contextual banners display a notification relevant to a specific
/// part of the system.
/// They appear at the top of the page or section they apply to, but always
/// below the page header or navigation.
/// They don't cover content, but push it down.
///
/// At its most basic, the component is comprised of a background
/// layer (colored according to the meaning of the message) and text;
/// other elements (left icon, description, link, close icon) are optional.
///
/// A banner always takes the full width of the component it is within.
class OptimusBanner extends StatelessWidget {
  const OptimusBanner({
    Key key,
    @required this.content,
    this.variant = OptimusBannerVariant.primary,
    this.showIcon = false,
    this.additionalDescription,
    this.dismissible = false,
    this.onDismiss,
  }) : super(key: key);

  final Widget content;
  final OptimusBannerVariant variant;
  final bool showIcon;
  final String additionalDescription;
  final bool dismissible;
  final VoidCallback onDismiss;

  @override
  Widget build(Object context) => ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _bannerHeight),
        child: Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: const BorderRadius.all(borderRadius50),
          ),
          child: Stack(
            children: [
              Padding(
                padding: _padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (showIcon)
                      Padding(
                        padding: const EdgeInsets.only(right: 18),
                        child: OptimusIcon(
                          iconData: _icon,
                          colorOption: _iconColor,
                        ),
                      ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle.merge(
                          child: content,
                          style: _textStyle,
                        ),
                        if (_hasAdditionalDescription)
                          Padding(
                            padding: const EdgeInsets.only(top: spacing50),
                            child: Text(
                              additionalDescription,
                              style: _additionalDescriptionTextStyle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (dismissible)
                Positioned(
                  right: -4,
                  top: -5,
                  child: IconButton(
                    splashRadius: 12,
                    padding: EdgeInsets.zero,
                    onPressed: () => onDismiss,
                    icon: const OptimusIcon(
                      iconData: OptimusIcons.cross_close,
                      iconSize: OptimusIconSize.small,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  bool get _hasAdditionalDescription =>
      additionalDescription?.isNotEmpty ?? false;

  double get _bannerHeight => _hasAdditionalDescription ? 68 : 40;

  TextStyle get _textStyle =>
      _hasAdditionalDescription ? preset300m : preset200m;

  TextStyle get _additionalDescriptionTextStyle =>
      preset200m.merge(const TextStyle(
        fontWeight: FontWeight.normal,
        height: 1,
      ));

  EdgeInsets get _padding => EdgeInsets.fromLTRB(
        showIcon ? 18.0 : spacing200,
        9,
        onDismiss != null ? spacing100 : spacing400,
        spacing100,
      );

  // ignore: missing_return
  IconData get _icon {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusIcons.info;
      case OptimusBannerVariant.success:
        return OptimusIcons.done_circle;
      case OptimusBannerVariant.warning:
        return OptimusIcons.problematic;
      case OptimusBannerVariant.error:
        return OptimusIcons.blacklist;
    }
  }

  // ignore: missing_return
  OptimusColorOption get _iconColor {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusColorOption.primary;
      case OptimusBannerVariant.success:
        return OptimusColorOption.success;
      case OptimusBannerVariant.warning:
        return OptimusColorOption.warning;
      case OptimusBannerVariant.error:
        return OptimusColorOption.danger;
    }
  }

  // ignore: missing_return
  Color get _backgroundColor {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusColors.primary500t8;
      case OptimusBannerVariant.success:
        return OptimusColors.success500t8;
      case OptimusBannerVariant.warning:
        return OptimusColors.warning500t8;
      case OptimusBannerVariant.error:
        return OptimusColors.danger500t8;
    }
  }
}

enum OptimusWideBannerVariant {
  /// Used to notify users about crucial, but unproblematic, information.
  informative,

  /// Used to warn users about serious potential problems.
  warning,

  /// Used to inform users that there is a serious problem with the system.
  danger
}

/// System-wide banners display critical notifications about the state of
/// the entire system.
/// They are placed at the top of the screen, above all content
/// (including navigation).
/// Unlike contextual banners, system-wide banners remain in the same place
/// on all pages and cannot be dismissed.
///
/// System-wide banners display messages that are critical to the user
/// and affect how the system or user operates.
/// Because of their prominent appearance, they are used to communicate
/// only the most important information about the system. If overused,
/// users could stop perceiving them as something worth paying attention to.
/// System-wide banners must be removed when no longer necessary.
class OptimusWideBanner extends StatelessWidget {
  const OptimusWideBanner({
    Key key,
    @required this.content,
    this.variant = OptimusWideBannerVariant.informative,
    this.link,
    this.onLinkTap,
  }) : super(key: key);

  final Widget content;
  final OptimusWideBannerVariant variant;
  final Widget link;
  final VoidCallback onLinkTap;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(color: _backgroundColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Icon(OptimusIcons.info, color: _color),
              ),
              DefaultTextStyle.merge(child: content, style: _contentTextStyle),
              if (link != null)
                GestureDetector(
                  onTap: () => onLinkTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: DefaultTextStyle.merge(
                      child: link,
                      style: _linkTextStyle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );

  TextStyle get _contentTextStyle =>
      preset200s.merge(TextStyle(color: _color, height: 1));

  TextStyle get _linkTextStyle => preset200s.merge(TextStyle(
      decoration: TextDecoration.underline, color: _color, height: 1));

  // ignore: missing_return
  Color get _backgroundColor {
    switch (variant) {
      case OptimusWideBannerVariant.informative:
        return OptimusColors.primary500;
      case OptimusWideBannerVariant.warning:
        return OptimusColors.warning500;
      case OptimusWideBannerVariant.danger:
        return OptimusColors.danger500;
    }
  }

  // ignore: missing_return
  Color get _color {
    switch (variant) {
      case OptimusWideBannerVariant.informative:
      case OptimusWideBannerVariant.danger:
        return OptimusColors.basic0;
      case OptimusWideBannerVariant.warning:
        return OptimusColors.basic1000;
    }
  }
}
