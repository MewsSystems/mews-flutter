import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tabs = Story(
  name: 'Tabs',
  builder: (_, k) => OptimusTabBar(
    tabs: _tabs(k.text('Text', initial: 'Button')),
    pages: _pages,
  ),
);

List<Widget> _tabs(String text) =>
    _items.map((i) => OptimusTab(text: text)).toList();

List<Widget> get _pages => _items.map((i) => Container()).toList();

Iterable<int> _items = Iterable<int>.generate(3);
