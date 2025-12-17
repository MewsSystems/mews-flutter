import 'package:flutter/widgets.dart';
import 'package:optimus/src/feedback/common.dart';
import 'package:optimus/src/feedback/feedback_link.dart';
import 'package:optimus/src/feedback/feedback_variant.dart';
import 'package:optimus/src/theme/theme.dart';

/// Alert banners display critical banners about the state of
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
class OptimusSystemWideBanner extends StatelessWidget {
  const OptimusSystemWideBanner({
    super.key,
    required this.title,
    this.link,
    this.description,
    this.variant = OptimusFeedbackVariant.info,
    this.onPressed,
    this.titleMaxLines,
    this.descriptionMaxLines = 5,
    this.linkMaxLines = 1,
    this.overflow = TextOverflow.ellipsis,
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

  /// An optional callback to be called when the banner is pressed.
  final VoidCallback? onPressed;

  /// The maximum number of lines for the title. If null, no limit is applied.
  final int? titleMaxLines;

  /// The maximum number of lines for the description. Default is 5.
  final int descriptionMaxLines;

  /// The maximum number of lines for the link text. Default is 1.
  final int linkMaxLines;

  /// The overflow style for all text in the banner. Default is [TextOverflow.ellipsis].
  final TextOverflow overflow;

  bool get _isExpanded => description != null || link != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return GestureDetector(
      onTap: onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(color: variant.backgroundColor(tokens)),
        child: Padding(
          padding: .symmetric(
            horizontal: tokens.spacing100,
            vertical: tokens.spacing200,
          ),
          child: Row(
            crossAxisAlignment: _isExpanded ? .start : .center,
            children: [
              FeedbackIcon(variant: variant),
              Expanded(
                child: Padding(
                  padding: .only(left: tokens.spacing150),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      FeedbackTitle(
                        title: title,
                        maxLines: titleMaxLines,
                        overflow: overflow,
                      ),
                      if (description case final description?)
                        Padding(
                          padding: .only(top: tokens.spacing50),
                          child: FeedbackDescription(
                            description: description,
                            maxLines: descriptionMaxLines,
                            overflow: overflow,
                          ),
                        ),
                      if (link case final link?)
                        Padding(
                          padding: .only(top: tokens.spacing50),
                          child: FeedbackLink(
                            text: link.text,
                            onPressed: link.onPressed,
                            semanticLinkUri: link.semanticUri,
                            maxLines: linkMaxLines,
                            overflow: overflow,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
