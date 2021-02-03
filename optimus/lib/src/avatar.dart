import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/styles.dart';

class OptimusAvatar extends StatelessWidget {
  const OptimusAvatar({
    Key key,
    @required this.title,
    this.imageUrl,
    this.isSmall = true,
    this.isIndicatorVisible = false,
  }) : super(key: key);

  final String title;
  final String imageUrl;
  final bool isSmall;
  final bool isIndicatorVisible;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          _buildCircleAvatar(),
          if (isIndicatorVisible) _buildIndicator(),
        ],
      );

  Widget _buildCircleAvatar() => ClipOval(
        child: CircleAvatar(
          radius: isSmall ? _smallRadius : _radius,
          backgroundColor:
              imageUrl == null ? OptimusColors.basic200 : Colors.white,
          backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl),
          child: imageUrl == null
              ? Text(
                  _safeSubstring(title, 0, 1).toUpperCase(),
                  style: preset300s.copyWith(color: OptimusColors.basic0t64),
                )
              : null,
        ),
      );

  Widget _buildIndicator() => Positioned(
        top: -2,
        left: -2,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: OptimusColors.primary500,
            border: Border.all(width: 2, color: OptimusColors.basic0),
          ),
          height: 14,
          width: 14,
        ),
      );
}

const double _smallRadius = 20;
const double _radius = 24;

String _safeSubstring(String str, int from, int to) =>
    str == null ? '' : str.substring(from, min(to, str.length));
