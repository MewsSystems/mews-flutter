import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/theme/theme.dart';
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

  @override
  Widget build(BuildContext context) {
    final colors = OptimusTheme.of(context).colors;

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        ClipOval(
          child: CircleAvatar(
            radius: isSmall ? _smallRadius : _radius,
            backgroundColor:
                imageUrl == null ? colors.neutral200 : colors.neutral0,
            backgroundImage: imageUrl?.let(NetworkImage.new),
            child: imageUrl == null
                ? Text(
                    substring(title, 0, 1).toUpperCase(),
                    style: preset300b.copyWith(color: colors.neutral0t64),
                  )
                : null,
          ),
        ),
        if (isIndicatorVisible) const _Indicator(),
      ],
    );
  }
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

const double _smallRadius = 20;
const double _radius = 24;
