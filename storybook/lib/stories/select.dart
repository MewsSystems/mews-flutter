import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story selectStory = Story(
  name: 'Select',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: _SelectStory(k),
  ),
);

class _SelectStory extends StatefulWidget {
  const _SelectStory(this.knobs, {Key key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _SelectStoryState createState() => _SelectStoryState();
}

class _SelectStoryState extends State<_SelectStory> {
  int _selectedValue;

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;
    return OptimusSelect<int>(
      value: _selectedValue,
      isEnabled: k.boolean('Enabled', initial: true),
      isRequired: k.boolean('Required'),
      prefix: k.boolean('Prefix') ? const Icon(OptimusIcons.search) : null,
      size: k.options(
        'Size',
        initial: OptimusWidgetSize.large,
        options: sizeOptions,
      ),
      label: k.text('Label', initial: 'Optimus input field'),
      placeholder: k.text('Placeholder', initial: 'Hint'),
      caption: Text(k.text('Caption', initial: '')),
      secondaryCaption: Text(k.text('Secondary caption', initial: '')),
      error: k.text('Error', initial: ''),
      items: Iterable<int>.generate(10)
          .map((i) =>
              ListDropdownTile<int>(value: i, title: Text('Dropdown tile #$i')))
          .toList(),
      builder: (context, option) => Text('Dropdown tile #$option'),
      onItemSelected: (i) => setState(() => _selectedValue = i),
    );
  }
}
