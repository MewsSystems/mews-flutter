import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story navListTileStory = Story(
  name: 'Data Display/List/Navigation List Tile',
  builder: (context) => const _NavListExample(),
);

class _NavListExample extends StatefulWidget {
  const _NavListExample();

  @override
  State<_NavListExample> createState() => _NavListExampleState();
}

class _NavListExampleState extends State<_NavListExample> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final label = k.text(label: 'Label', initial: 'Label');
    final leading = k.options(
      label: 'Leading',
      initial: OptimusIcons.magic,
      options: exampleIcons,
    );
    final rightDetail =
        k.options(label: 'Right Detail', initial: null, options: exampleIcons);
    final isToggleVisible = k.boolean(
      label: 'Toggle',
      initial: false,
    );
    final isChevronVisible = k.boolean(label: 'Chevron', initial: false);
    final isEnabled = k.boolean(label: 'Enabled', initial: true);
    final useHorizontalPadding = k.boolean(label: 'Use Padding', initial: true);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: Iterable<int>.generate(10)
              .map(
                (i) => OptimusNavListTile(
                  label: Text(label),
                  rightDetail: rightDetail != null ? Icon(rightDetail) : null,
                  isChevronVisible: isChevronVisible,
                  isToggleVisible: isToggleVisible,
                  onTogglePressed: (isToggled) =>
                      setState(() => _isToggled = isToggled),
                  isToggled: _isToggled,
                  isEnabled: isEnabled,
                  leading: leading != null ? Icon(leading) : null,
                  useHorizontalPadding: useHorizontalPadding,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
