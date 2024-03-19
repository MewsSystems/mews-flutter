import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusAvatar extends StatelessWidget {
  const OptimusAvatar({
    super.key,
    required this.title,
    this.imageUrl,
    this.isIndicatorVisible = false,
    this.size = OptimusWidgetSize.medium,
  });

  final String title;
  final String? imageUrl;
  final bool isIndicatorVisible;
  final OptimusWidgetSize size;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final imageUrl = this.imageUrl;
    final emptyColor = tokens.backgroundAlertBasicSecondary;
    final diameter = size.getSize(tokens);

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        ClipOval(
          child: Container(
            constraints: BoxConstraints(
              minHeight: diameter,
              minWidth: diameter,
              maxWidth: diameter,
              maxHeight: diameter,
            ),
            decoration: BoxDecoration(color: emptyColor),
            child: Center(
              child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: imageUrl != null
                    ? FadeInImage.memoryNetwork(
                        width: diameter,
                        height: diameter,
                        placeholder: _transparentImage,
                        image: imageUrl,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (_, __, ___) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: emptyColor,
                          child: Center(child: _FallbackText(title: title)),
                        ),
                      )
                    : _FallbackText(title: title),
              ),
            ),
          ),
        ),
        if (isIndicatorVisible) const OptimusBadge(),
      ],
    );
  }
}

class _FallbackText extends StatelessWidget {
  const _FallbackText({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) => Text(
        substring(title, 0, 1).toUpperCase(),
        style: context.tokens.bodyLarge.copyWith(
          fontWeight: FontWeight.w700,
          color: OptimusTheme.of(context).colors.neutral0t64,
        ),
      );
}

extension on OptimusWidgetSize {
  double getSize(OptimusTokens tokens) => switch (this) {
        OptimusWidgetSize.small => tokens.sizing400,
        OptimusWidgetSize.medium => tokens.sizing500,
        OptimusWidgetSize.large => tokens.sizing700,
        OptimusWidgetSize.extraLarge => tokens.sizing1300,
      };
}

final Uint8List _transparentImage = Uint8List.fromList(_imageData);

const _imageData = [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
];
