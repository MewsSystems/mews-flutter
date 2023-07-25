import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story spacingStory = Story(
  name: 'Layout/Spacing',
  builder: (_) => SingleChildScrollView(
    child: Column(
      children: [
        _buildSpacing(spacing0, 'Spacing 0'),
        _buildSpacing(spacing25, 'Spacing 25'),
        _buildSpacing(spacing50, 'Spacing 50'),
        _buildSpacing(spacing100, 'Spacing 100'),
        _buildSpacing(spacing200, 'Spacing 200'),
        _buildSpacing(spacing300, 'Spacing 300'),
        _buildSpacing(spacing400, 'Spacing 400'),
        _buildSpacing(spacing500, 'Spacing 500'),
        _buildSpacing(spacing700, 'Spacing 700'),
        _buildSpacing(spacing900, 'Spacing 900'),
        _buildSpacing(spacing1200, 'Spacing 1200'),
      ],
    ),
  ),
);

Widget _buildSpacing(double spacing, String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: spacing,
            height: spacing,
            child: Container(color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(left: _getPadding(spacing)),
            child: Text(label, textAlign: TextAlign.left),
          ),
        ],
      ),
    );

double _getPadding(double spacing) => 24 + spacing1200 - spacing;
