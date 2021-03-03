import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tabs = Story.simple(
  name: 'Tabs',
  child: Container(
    color: Colors.white,
    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 200),
    child: OptimusTabBar(
      tabs: _tabs(),
      pages: _pages,
    ),
  ),
);

List<Widget> _tabs() =>
    _items.map((i) => OptimusTab(text: 'Tab ${i + 1}')).toList();

List<Widget> get _pages =>
    _items.map((i) => Center(child: Text('Page ${i + 1}'))).toList();

Iterable<int> _items = Iterable<int>.generate(3);
