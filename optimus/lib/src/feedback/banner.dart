import 'package:flutter/material.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/feedback/feedback_variant.dart';
import 'package:optimus/src/feedback/notification.dart';
import 'package:optimus/src/theme/theme.dart';

/// Contextual banners display a notification relevant to a specific
/// part of the system.
///
/// They appear at the top of the page or section they apply to, but always
/// below the page header or navigation. They don't cover content, but push it
/// down.
///
/// At its most basic, the component is comprised of a background
/// layer (colored according to the meaning of the message) and text;
/// other elements (left icon, description, link, close icon) are optional.
///
/// A banner always takes the full width of the component it is within.
class OptimusBanner extends StatelessWidget {
  const OptimusBanner({
    super.key,
    required this.title,
    this.variant = OptimusFeedbackVariant.info,
    this.hasIcon = false,
    this.description,
    this.isDismissible = false,
    this.onDismiss,
  });

  /// The title of the banner.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Variant of the banner which determines background color and icon
  /// (if [hasIcon] == true).
  final OptimusFeedbackVariant variant;

  /// If `true` the icon will be displayed. Which icon is used depends on
  /// [variant].
  final bool hasIcon;

  /// Banner's description rendered as a second line.
  ///
  /// Typically a [Text] widget.
  final Widget? description;

  /// If `true` close button will be rendered as well.
  ///
  /// It's your responsibility to process the button press with
  /// [onDismiss] callback parameter.
  final bool isDismissible;

  /// Called when close button is pressed (if [isDismissible] == true).
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: variant.backgroundColor(tokens),
        borderRadius: BorderRadius.circular(tokens.borderRadius100),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(tokens.spacing200),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (hasIcon)
                  Padding(
                    padding: EdgeInsets.only(right: tokens.spacing200),
                    child: Icon(
                      variant.icon,
                      color: variant.getIconColor(tokens),
                      size: tokens.sizing300,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: isDismissible
                            ? EdgeInsets.only(right: tokens.spacing200)
                            : EdgeInsets.zero,
                        child: DefaultTextStyle.merge(
                          child: title,
                          style: tokens.bodyMediumStrong
                              .copyWith(color: tokens.textStaticPrimary),
                        ),
                      ),
                      if (description case final description?)
                        Padding(
                          padding: EdgeInsets.only(top: tokens.spacing50),
                          child: DefaultTextStyle.merge(
                            child: description,
                            style: tokens.bodyMedium
                                .copyWith(color: tokens.textStaticSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isDismissible)
            Positioned(
              top: tokens.spacing200,
              right: tokens.spacing200,
              child: GestureDetector(
                onTap: onDismiss,
                child: Icon(
                  OptimusIcons.cross_close,
                  size: tokens.sizing200,
                  color: tokens.textStaticPrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Alert banners display critical notifications about the state of
/// the entire system.
///
/// They are placed at the top of the screen, above all content
/// (including navigation). Unlike contextual banners, alert banners
/// remain in the same place on all pages and cannot be dismissed.
///
/// Alert banners display messages that are critical to the user
/// and affect how the system or user operates.
/// Because of their prominent appearance, they are used to communicate
/// only the most important information about the system. If overused,
/// users could stop perceiving them as something worth paying attention to.
/// Alert banners must be removed when no longer necessary.
class OptimusAlert extends StatelessWidget {
  const OptimusAlert({
    super.key,
    required this.title,
    this.link,
    this.description,
    this.variant = OptimusFeedbackVariant.info,
  });

  /// Content of the banner.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Banner's description rendered as a second line.
  final Widget? description;

  /// Link to additional information.
  final OptimusNotificationLink? link;

  /// Variant of the banner.
  ///
  /// Controls background color.
  final OptimusFeedbackVariant variant;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DecoratedBox(
      decoration: BoxDecoration(color: variant.backgroundColor(tokens)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(variant.icon, color: variant.getIconColor(tokens)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: tokens.spacing150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle.merge(
                      child: title,
                      style: tokens.bodyMediumStrong
                          .copyWith(color: tokens.textStaticPrimary),
                    ),
                    if (description case final description?)
                      Padding(
                        padding: EdgeInsets.only(top: tokens.spacing50),
                        child: DefaultTextStyle.merge(
                          child: description,
                          style: tokens.bodyMedium
                              .copyWith(color: tokens.textStaticSecondary),
                        ),
                      ),
                    if (link case final link?)
                      Padding(
                        padding: EdgeInsets.only(top: tokens.spacing50),
                        child: GestureDetector(
                          onTap: link.onPressed,
                          child: DefaultTextStyle.merge(
                            child: link.text,
                            style: tokens.bodyMediumStrong.copyWith(
                              color: tokens.textStaticSecondary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
