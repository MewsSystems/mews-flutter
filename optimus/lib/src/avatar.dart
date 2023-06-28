import 'dart:typed_data';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

class OptimusAvatar extends StatelessWidget {
  const OptimusAvatar({
    super.key,
    required this.title,
    this.imageUrl,
    this.isSmall = true,
    this.isIndicatorVisible = false,
  });

  final String title;
  final String? imageUrl;
  final bool isSmall;
  final bool isIndicatorVisible;

  double get _radius => isSmall ? _smallRadius : _defaultRadius;
  double get _diameter => _radius * 2;

  @override
  Widget build(BuildContext context) {
    final colors = OptimusTheme.of(context).colors;
    final imageUrl = this.imageUrl;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        ClipOval(
          child: Container(
            constraints: BoxConstraints(
              minHeight: _diameter,
              minWidth: _diameter,
              maxWidth: _diameter,
              maxHeight: _diameter,
            ),
            decoration: BoxDecoration(
              color: imageUrl == null ? colors.neutral200 : colors.neutral0,
            ),
            child: Center(
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: imageUrl != null
                    ? FadeInImage.memoryNetwork(
                        width: _diameter,
                        height: _diameter,
                        placeholder: _transparentImage,
                        image: imageUrl,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (_, __, ___) => Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: colors.neutral200,
                          child: Center(child: _FallbackText(title: title)),
                        ),
                      )
                    : _FallbackText(title: title),
              ),
            ),
          ),
        ),
        if (isIndicatorVisible) const _Indicator(),
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
        style: preset300b.copyWith(
          color: OptimusTheme.of(context).colors.neutral0t64,
        ),
      );
}

class _Indicator extends StatelessWidget {
  const _Indicator();

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Positioned(
      top: -2,
      left: -2,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colors.primary500,
          border: Border.all(
            width: 2,
            color:
                theme.isDark ? theme.colors.neutral500 : theme.colors.neutral0,
          ),
        ),
        height: 14,
        width: 14,
      ),
    );
  }
}

final Uint8List _transparentImage = Uint8List.fromList(<int>[
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, //
  0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
  0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
  0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
  0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82,
]);

const double _smallRadius = 20;
const double _defaultRadius = 24;
