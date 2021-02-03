import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story searchFieldStory = Story(
  name: 'Search field',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: _SearchStory(k),
  ),
);

class _SearchStory extends StatefulWidget {
  const _SearchStory(this.knobs, {Key key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _SearchStoryState createState() => _SearchStoryState();
}

class _SearchStoryState extends State<_SearchStory> {
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
          .where((c) => c.toLowerCase().contains(_controller.text.toLowerCase()))
          .map((c) => ListDropdownTile(value: c, title: Text(c)))
          .toList(),
      onChanged: (_) {},
      label: k.text('Label', initial: 'Search field'),
      placeholder: k.text('Placeholder', initial: 'Start typing something'),
      isEnabled: k.boolean('Enabled', initial: true),
      isRequired: k.boolean('Required'),
      caption: Text(k.text('Caption', initial: '')),
      secondaryCaption: Text(k.text('Secondary caption', initial: '')),
      size: k.options('Size', initial: OptimusWidgetSize.large, options: sizeOptions),
      error: k.text('Error', initial: ''),
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
