import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Spacing',
  type: double,
  path: '[Layout]',
)
Widget createDefaultStyle(BuildContext context) {
  final tokens = context.tokens;

  return SingleChildScrollView(
    child: OptimusTheme(
      child: Column(
        children: [
          _buildSpacing(tokens, tokens.spacing0, 'Spacing 0'),
          _buildSpacing(tokens, tokens.spacing25, 'Spacing 25'),
          _buildSpacing(tokens, tokens.spacing50, 'Spacing 50'),
          _buildSpacing(tokens, tokens.spacing100, 'Spacing 100'),
          _buildSpacing(tokens, tokens.spacing200, 'Spacing 200'),
          _buildSpacing(tokens, tokens.spacing300, 'Spacing 300'),
          _buildSpacing(tokens, tokens.spacing400, 'Spacing 400'),
          _buildSpacing(tokens, tokens.spacing500, 'Spacing 500'),
          _buildSpacing(tokens, tokens.spacing700, 'Spacing 700'),
          _buildSpacing(tokens, tokens.spacing900, 'Spacing 900'),
          _buildSpacing(tokens, tokens.spacing1200, 'Spacing 1200'),
        ],
      ),
    ),
  );
}

Widget _buildSpacing(OptimusTokens tokens, double spacing, String label) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: spacing,
            height: spacing,
            child: Container(color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(left: _getPadding(tokens, spacing)),
            child: Text(label, textAlign: TextAlign.left),
          ),
        ],
      ),
    );

double _getPadding(OptimusTokens tokens, double spacing) =>
    24 + tokens.spacing1200 - spacing;
