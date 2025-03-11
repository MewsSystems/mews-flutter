import 'package:flutter/material.dart';
import 'package:optimus/src/feedback/common.dart';
import 'package:optimus/src/feedback/feedback_variant.dart';
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
    this.onPressed,
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

  /// An optional callback when the banner is pressed.
  final VoidCallback? onPressed;

  bool get _isExpanded => description != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: variant.backgroundColor(tokens),
          borderRadius: BorderRadius.all(tokens.borderRadius100),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(tokens.spacing200),
              child: Row(
                crossAxisAlignment:
                    _isExpanded
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                children: [
                  if (hasIcon)
                    Padding(
                      padding: EdgeInsets.only(right: tokens.spacing200),
                      child: FeedbackIcon(variant: variant),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              isDismissible
                                  ? EdgeInsets.only(right: tokens.spacing200)
                                  : EdgeInsets.zero,
                          child: FeedbackTitle(title: title),
                        ),
                        if (description case final description?)
                          Padding(
                            padding: EdgeInsets.only(top: tokens.spacing50),
                            child: FeedbackDescription(
                              description: description,
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
                child: FeedbackDismissButton(onDismiss: onDismiss),
              ),
          ],
        ),
      ),
    );
  }
}
