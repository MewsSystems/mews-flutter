import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/nesting.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Search Field',
  type: OptimusSearch,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext context) => ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: const _SearchStory(),
    );

@widgetbook.UseCase(
  name: 'Nested Search Field',
  type: OptimusSearch,
  path: '[Forms]',
)
Widget createNestedStyle(BuildContext context) => NestedWrapper(
      (context) => const _SearchStory(),
    );

class _SearchStory extends StatefulWidget {
  const _SearchStory({super.key});

  @override
  State<_SearchStory> createState() => _SearchStoryState();
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
    _controller
      ..removeListener(_onValueChanged)
      ..dispose();
    super.dispose();
  }

  void _onValueChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

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
      onChanged: (_) {},
      label: k.string(label: 'Label', initialValue: 'Search field'),
      placeholder: k.string(
        label: 'Placeholder',
        initialValue: 'Start typing something',
      ),
      isEnabled: k.boolean(label: 'Enabled', initialValue: true),
      isRequired: k.boolean(label: 'Required'),
      caption: Text(k.string(label: 'Caption', initialValue: '')),
      helperMessage:
          Text(k.string(label: 'Secondary caption', initialValue: '')),
      size: k.list(
        label: 'Size',
        initialOption: OptimusWidgetSize.large,
        options: OptimusWidgetSize.values,
      ),
      isUpdating: k.boolean(label: 'Updating', initialValue: false),
      isClearEnabled: k.boolean(label: 'Clear enabled', initialValue: false),
      error: k.string(label: 'Error', initialValue: ''),
      groupBy: k.boolean(label: 'Grouped', initialValue: false)
          ? (item) => item.split(' ')[1][0].toLowerCase()
          : null,
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
