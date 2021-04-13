import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story selectStory = Story(
  section: 'Select',
  name: 'Select',
  builder: (_, k) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: _SelectStory(k),
  ),
);

final Story nestedSelectStory = Story(
  section: 'Select',
  name: 'Nested Select',
  builder: (_, k) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const _Bar(),
      Expanded(
        child: Navigator(
          initialRoute: 'initialRoute',
          onGenerateRoute: (settings) {
            late WidgetBuilder builder;
            switch (settings.name) {
              case 'initialRoute':
                builder = (context) => ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: _SelectStory(k),
                    );
                break;
            }

            return MaterialPageRoute<dynamic>(
              builder: builder,
              settings: settings,
              fullscreenDialog: true,
            );
          },
        ),
      ),
      const _Bar(),
    ],
  ),
);

class _Bar extends StatelessWidget {
  const _Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 100,
        color: Colors.lightBlue,
        child: const Center(
          child: Text(
            'Widget outside of Navigator',
            textAlign: TextAlign.center,
          ),
        ),
      );
}

class _SelectStory extends StatefulWidget {
  const _SelectStory(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  _SelectStoryState createState() => _SelectStoryState();
}

class _SelectStoryState extends State<_SelectStory> {
  int? _selectedValue;

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;
    return OptimusSelect<int>(
      value: _selectedValue,
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      isRequired: k.boolean(label: 'Required'),
      prefix:
          k.boolean(label: 'Prefix') ? const Icon(OptimusIcons.search) : null,
      size: k.options(
        label: 'Size',
        initial: OptimusWidgetSize.large,
        options: sizeOptions,
      ),
      label: k.text(label: 'Label', initial: 'Optimus input field'),
      placeholder: k.text(label: 'Placeholder', initial: 'Hint'),
      caption: Text(k.text(label: 'Caption', initial: '')),
      secondaryCaption: Text(k.text(label: 'Secondary caption', initial: '')),
      error: k.text(label: 'Error', initial: ''),
      items: Iterable<int>.generate(10)
          .map((i) =>
              ListDropdownTile<int>(value: i, title: Text('Dropdown tile #$i')))
          .toList(),
      builder: (context, option) => Text('Dropdown tile #$option'),
      onItemSelected: (i) => setState(() => _selectedValue = i),
    );
  }
}
