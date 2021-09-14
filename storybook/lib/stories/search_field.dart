import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story searchFieldStory = Story(
  name: 'Search field',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: SearchStory(k),
  ),
);

class SearchStory extends StatefulWidget {
  const SearchStory(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _SearchStoryState createState() => _SearchStoryState();
}

class _SearchStoryState extends State<SearchStory> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onValueChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onValueChanged);
    super.dispose();
  }

  void _onValueChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;

    return OptimusSearch<String>(
      controller: _controller,
      items: _characters
          .where(
            (c) => c.toLowerCase().contains(_controller.text.toLowerCase()),
          )
          .map(
            (c) => ListDropdownTile(
              value: c,
              title: Text(c),
              subtitle: Text('Subtitle #$c'),
            ),
          )
          .toList(),
      // ignore: prefer-extracting-callbacks
      onChanged: (_) {},
      label: k.text(label: 'Label', initial: 'Search field'),
      placeholder: k.text(
        label: 'Placeholder',
        initial: 'Start typing something',
      ),
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      isRequired: k.boolean(label: 'Required'),
      caption: Text(k.text(label: 'Caption', initial: '')),
      secondaryCaption: Text(k.text(label: 'Secondary caption', initial: '')),
      size: k.options(
        label: 'Size',
        initial: OptimusWidgetSize.large,
        options: sizeOptions,
      ),
      error: k.text(label: 'Error', initial: ''),
    );
  }
}

const _characters = [
  'Jon Snow',
  'Ned Stark',
  'Robb Stark',
  'Sansa Stark',
  'Daenerys Targaryen',
];
