import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/common.dart';
import 'package:optimus_widgetbook/components/common/nesting.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Select Input',
  type: OptimusSelectInput,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const SelectInputStory();

@widgetbook.UseCase(
  name: 'Nested Select',
  type: OptimusSelectInput,
  path: '[Forms]',
)
Widget createNestedStyle(BuildContext _) => NestedWrapper(
      (context) => const SelectInputStory(),
    );

class SelectInputStory extends StatefulWidget {
  const SelectInputStory({super.key});

  @override
  State<SelectInputStory> createState() => _SelectInputStoryState();
}

class _SelectInputStoryState extends State<SelectInputStory> {
  String? _selectedValue;
  final List<String> _selectedValues = [];
  String _searchToken = '';

  void _handleTextChanged(String text) =>
      setState(() => _searchToken = text.toLowerCase());

  void _handleChanged(bool isMultiselect, String value) => setState(() {
        _selectedValue = value;
        if (isMultiselect) {
          if (_selectedValues.contains(value)) {
            _selectedValues.remove(value);
          } else {
            _selectedValues.add(value);
          }
        }
      });

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    final prefix = k.string(label: 'Prefix');
    final suffix = k.string(label: 'Suffix');
    final trailing = k.listOrNull(
      label: 'Trailing Icon',
      options: exampleIcons,
      initialOption: null,
    );
    final showLoader = k.boolean(label: 'Show loader', initialValue: false);
    final isSearchEmbedded =
        k.boolean(label: 'Embedded search', initialValue: false);
    final enableGrouping = k.boolean(label: 'Grouped', initialValue: true);
    final allowMultipleSelection =
        k.boolean(label: 'Multiselect', initialValue: true);

    return Align(
      alignment: k.list(
        label: 'Align',
        options: alignments,
        initialOption: Alignment.center,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: OptimusSelectInput<String>(
          value: _selectedValue,
          isEnabled: k.boolean(label: 'Enabled', initialValue: true),
          isRequired: k.boolean(label: 'Required'),
          leading: k.boolean(label: 'Leading Icon')
              ? const Icon(OptimusIcons.search)
              : null,
          onTextChanged:
              k.boolean(label: 'Searchable') ? _handleTextChanged : null,
          prefix: prefix.isNotEmpty ? Text(prefix) : null,
          suffix: suffix.isNotEmpty ? Text(suffix) : null,
          trailing: trailing != null ? Icon(trailing) : null,
          showLoader: showLoader,
          onChanged: (value) => _handleChanged(allowMultipleSelection, value),
          size: k.list(
            label: 'Size',
            initialOption: OptimusWidgetSize.large,
            options: OptimusWidgetSize.values,
          ),
          label: k.string(label: 'Label', initialValue: 'Optimus input field'),
          placeholder: k.string(label: 'Placeholder', initialValue: 'Hint'),
          caption: Text(k.string(label: 'Caption', initialValue: '')),
          secondaryCaption:
              Text(k.string(label: 'Secondary caption', initialValue: '')),
          error: k.string(label: 'Error', initialValue: ''),
          items: _characters
              .where((e) => e.toLowerCase().contains(_searchToken))
              .map(
                (e) => ListDropdownTile<String>(
                  value: e,
                  title: Text(e),
                  subtitle: Text(e.toUpperCase()),
                  isSelected: allowMultipleSelection
                      ? _selectedValues.contains(e)
                      : null,
                ),
              )
              .toList(),
          builder: (option) => option,
          emptyResultPlaceholder: const Padding(
            padding: EdgeInsets.all(8),
            child: OptimusLabel(child: Text('No results found')),
          ),
          allowMultipleSelection: allowMultipleSelection,
          selectedValues: allowMultipleSelection ? _selectedValues : null,
          embeddedSearch: isSearchEmbedded
              ? OptimusDropdownEmbeddedSearch(
                  initialValue: _searchToken,
                  onTextChanged: _handleTextChanged,
                  placeholder: 'Search',
                )
              : null,
          groupBy: enableGrouping
              ? (item) => item.split(' ')[1][0].toLowerCase()
              : null,
        ),
      ),
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
