import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const List<BoxShadow> elevation0 = [];

const List<BoxShadow> elevation25 = [
  BoxShadow(
    color: _shadowt8,
    offset: Offset(0, 4),
    blurRadius: 4,
    spreadRadius: -2,
  ),
  BoxShadow(
    color: _shadowt16,
    offset: Offset(0, -1),
    blurRadius: 4,
    spreadRadius: -2,
  ),
];

const List<BoxShadow> elevation50 = [
  BoxShadow(
    color: _shadowt10,
    offset: Offset(0, 8),
    blurRadius: 24,
    spreadRadius: -4,
  ),
  BoxShadow(
    color: _shadowt10,
    offset: Offset(0, 6),
    blurRadius: 12,
    spreadRadius: -6,
  ),
];

const List<BoxShadow> elevation100 = [
  BoxShadow(
    color: _shadowt10,
    offset: Offset(0, 18),
    blurRadius: 88,
    spreadRadius: -4,
  ),
  BoxShadow(
    color: _shadowt10,
    offset: Offset(0, 12),
    blurRadius: 28,
    spreadRadius: -6,
  ),
];

const _shadowt8 = Color(0x14242435);
const _shadowt10 = Color(0x1a242435);
const _shadowt16 = Color(0x29242435);
