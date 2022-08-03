import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story selectInputStory = Story(
  name: 'Forms/Select Input',
  builder: (context) => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 400),
    child: SelectInputStory(context.knobs),
  ),
);

class SelectInputStory extends StatefulWidget {
  const SelectInputStory(this.knobs, {Key? key}) : super(key: key);

  final KnobsBuilder knobs;

  @override
  State<SelectInputStory> createState() => _SelectInputStoryState();
}

class _SelectInputStoryState extends State<SelectInputStory> {
  String? _selectedValue;
  String _searchToken = '';

  void _onTextChanged(String text) {
    setState(() {
      _searchToken = text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final k = widget.knobs;

    final prefix = k.text(label: 'Prefix');
    final suffix = k.text(label: 'Suffix');
    final trailing =
        k.options(label: 'Trailing Icon', options: exampleIcons, initial: null);
    final showLoader = k.boolean(label: 'Show loader', initial: false);

    return OptimusSelectInput<String>(
      value: _selectedValue,
      isEnabled: k.boolean(label: 'Enabled', initial: true),
      isRequired: k.boolean(label: 'Required'),
      leading: k.boolean(label: 'Leading Icon')
          ? const Icon(OptimusIcons.search)
          : null,
      onTextChanged: k.boolean(label: 'Searchable') ? _onTextChanged : null,
      prefix: prefix.isNotEmpty ? Text(prefix) : null,
      suffix: suffix.isNotEmpty ? Text(suffix) : null,
      trailing: trailing != null ? Icon(trailing) : null,
      showLoader: showLoader,
      onChanged: (i) => setState(() => _selectedValue = i),
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
      items: _characters
          .where((e) => e.toLowerCase().contains(_searchToken))
          .map(
            (e) => ListDropdownTile<String>(
              value: e,
              title: Text(e),
              subtitle: Text(e.toUpperCase()),
            ),
          )
          .toList(),
      builder: (option) => option,
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
