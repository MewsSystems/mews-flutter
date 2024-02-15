import 'package:flutter/widgets.dart';
import 'package:optimus/src/feedback/feedback_link.dart';
import 'package:optimus/src/feedback/feedback_variant.dart';
import 'package:optimus/src/theme/theme.dart';

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
  final OptimusFeedbackLink? link;

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
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing100,
          vertical: tokens.spacing200,
        ),
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
