import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/avatar/transparent_image.dart';

/// An avatar is a visual representation of a user or entity. It can display an
/// image, a fallback text, a badge, and an indicator.
class OptimusAvatar extends StatelessWidget {
  const OptimusAvatar({
    super.key,
    required this.title,
    this.imageUrl,
    this.badgeUrl,
    this.semanticLabel,
    this.isIndicatorVisible = false,
    this.size = OptimusWidgetSize.medium,
    this.alignment = AlignmentDirectional.center,
  });

  /// The title of the avatar. The title is displayed when the image is not
  /// available. The fallback text is the first two characters of the title in
  /// uppercase.
  final String title;

  /// The URL of the image to be displayed in the avatar.
  final String? imageUrl;

  /// The URl of the badge to be displayed in the avatar. For example, a badge
  /// can be used to indicate the user's company. The badge is displayed only
  /// for the [OptimusWidgetSize.medium] and [OptimusWidgetSize.large] sizes.
  final String? badgeUrl;

  /// Whether the indicator is visible. The indicator is displayed in the top
  /// right corner of the avatar. The indicator is displayed only for the
  /// [OptimusWidgetSize.medium] and [OptimusWidgetSize.large] sizes.
  final bool isIndicatorVisible;

  /// The size of the avatar.
  final OptimusWidgetSize size;

  /// The alignment of th Avatar inside its Stack. Defaults to
  /// [AlignmentDirectional.center].
  final AlignmentDirectional alignment;

  /// The semantic label of the avatar. Defaults to the "Avatar + title". We
  /// suggest using a localized string for better accessibility.
  final String? semanticLabel;

  bool get _isVisibleForSize =>
      size == OptimusWidgetSize.medium || size == OptimusWidgetSize.large;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final imageUrl = this.imageUrl;
    final badgeUrl = this.badgeUrl;
    final decoration = BoxDecoration(
      color: tokens.backgroundAlertBasicSecondary,
      shape: BoxShape.circle,
      border: Border.all(
        color: tokens.borderStaticPrimary,
        width: tokens.borderWidth150,
      ),
    );

    return MergeSemantics(
      child: Semantics(
        label: semanticLabel ?? 'Avatar: $title',
        child: Stack(
          clipBehavior: Clip.none,
          alignment: alignment,
          children: <Widget>[
            _CircleImage(
              imageUrl: imageUrl,
              decoration: decoration,
              diameter: size.getSize(tokens),
              fallbackWidget: _FallbackText(title: title, size: size),
            ),
            if (isIndicatorVisible && _isVisibleForSize)
              Positioned(
                right: tokens.spacing0,
                top: tokens.spacing0,
                child: const _Indicator(),
              ),
            if (badgeUrl != null && _isVisibleForSize)
              Positioned(
                right: tokens.spacing0,
                bottom: tokens.spacing0,
                child: _Indicator(url: badgeUrl),
              ),
          ],
        ),
      ),
    );
  }
}

class _CircleImage extends StatelessWidget {
  const _CircleImage({
    required this.diameter,
    required this.imageUrl,
    required this.fallbackWidget,
    this.decoration,
  });

  final double diameter;
  final String? imageUrl;
  final BoxDecoration? decoration;
  final Widget fallbackWidget;

  @override
  Widget build(BuildContext context) {
    final imageUrl = this.imageUrl;

    return ClipOval(
      child: Container(
        constraints: BoxConstraints(
          minHeight: diameter,
          minWidth: diameter,
          maxWidth: diameter,
          maxHeight: diameter,
        ),
        decoration: imageUrl == null ? decoration : null,
        child: Center(
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.noScaling),
            child:
                imageUrl != null
                    ? FadeInImage.memoryNetwork(
                      width: diameter,
                      height: diameter,
                      placeholder: _transparentImage,
                      image: imageUrl,
                      fit: BoxFit.cover,
                      imageErrorBuilder:
                          (_, _, _) => Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: decoration,
                            child: Center(child: fallbackWidget),
                          ),
                    )
                    : fallbackWidget,
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final outlineSize = tokens.borderWidth200;
    final height = context.avatarSize + outlineSize * 2;
    final url = this.url;

    final decoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      color: url == null ? tokens.backgroundAccentPrimary : null,
      border: Border.all(width: outlineSize, color: tokens.borderStaticInverse),
    );

    return Container(
      constraints: BoxConstraints(minWidth: height, maxWidth: height),
      height: height,
      decoration: decoration,
      child: url != null ? _BadgeImage(url: url) : null,
    );
  }
}

class _BadgeImage extends StatelessWidget {
  const _BadgeImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) => _CircleImage(
    imageUrl: url,
    diameter: context.avatarSize,
    fallbackWidget: const SizedBox.shrink(),
  );
}

class _FallbackText extends StatelessWidget {
  const _FallbackText({
    required this.title,
    this.size = OptimusWidgetSize.large,
  });

  final String title;
  final OptimusWidgetSize size;

  @override
  Widget build(BuildContext context) => Text(
    substring(title, 0, 2).toUpperCase(),
    style: size
        .getTextStyle(context.tokens)
        .copyWith(color: context.tokens.textStaticSecondary),
  );
}

extension on OptimusWidgetSize {
  double getSize(OptimusTokens tokens) => switch (this) {
    OptimusWidgetSize.small => tokens.sizing400,
    OptimusWidgetSize.medium => tokens.sizing500,
    OptimusWidgetSize.large => tokens.sizing700,
    OptimusWidgetSize.extraLarge => tokens.sizing1300,
  };

  TextStyle getTextStyle(OptimusTokens tokens) => switch (this) {
    OptimusWidgetSize.small => tokens.bodyExtraSmallStrong,
    OptimusWidgetSize.medium => tokens.bodySmallStrong,
    OptimusWidgetSize.large => tokens.bodyMediumStrong,
    OptimusWidgetSize.extraLarge => tokens.bodyLargeStrong,
  };
}

final Uint8List _transparentImage = Uint8List.fromList(transparentImageData);

extension on BuildContext {
  double get avatarSize => tokens.sizing150;
}
