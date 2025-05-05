import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/common/nesting.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final GlobalKey _selectUseCaseKey = GlobalKey();
final GlobalKey _nestedSelectUseCaseKey = GlobalKey();

@widgetbook.UseCase(name: 'Default', type: OptimusSelectInput, path: '[Forms]')
Widget createDefaultStyle(BuildContext _) =>
    SelectInputStory(key: _selectUseCaseKey);

@widgetbook.UseCase(name: 'Nested', type: OptimusSelectInput, path: '[Forms]')
Widget createNestedStyle(BuildContext _) =>
    NestedWrapper((_) => SelectInputStory(key: _nestedSelectUseCaseKey));

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
    final trailing = k.optimusIconOrNullKnob(label: 'Trailing Icon');
    final showLoader = k.boolean(label: 'Show loader', initialValue: false);
    final isSearchEmbedded = k.boolean(
      label: 'Embedded search',
      initialValue: false,
    );
    final enableGrouping = k.boolean(label: 'Grouped', initialValue: true);
    final allowMultipleSelection = k.boolean(
      label: 'Multiselect',
      initialValue: true,
    );

    final alignment = k.alignmentKnob();

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: OptimusSelectInput<String>(
          value: _selectedValue,
          isEnabled: k.isEnabledKnob,
          isRequired: k.boolean(label: 'Required'),
          leading:
              k.boolean(label: 'Leading Icon')
                  ? const Icon(OptimusIcons.search)
                  : null,
          onTextChanged:
              k.boolean(label: 'Searchable') ? _handleTextChanged : null,
          prefix: prefix.maybeToWidget(),
          suffix: suffix.maybeToWidget(),
          trailing: trailing?.toWidget(),
          showLoader: showLoader,
          onChanged: (value) => _handleChanged(allowMultipleSelection, value),
          size: k.widgetSizeKnob,
          label: k.string(label: 'Label', initialValue: 'Optimus input field'),
          placeholder: k.string(label: 'Placeholder', initialValue: 'Hint'),
          caption: Text(k.string(label: 'Caption', initialValue: '')),
          isCompact: k.boolean(label: 'Compact', initialValue: false),
          secondaryCaption: Text(
            k.string(label: 'Secondary caption', initialValue: ''),
          ),
          error: k.string(label: 'Error', initialValue: ''),
          items:
              _characters
                  .where((e) => e.toLowerCase().contains(_searchToken))
                  .map(
                    (e) => ListDropdownTile<String>(
                      value: e,
                      title: Text(e),
                      subtitle: Text(e.toUpperCase()),
                      isSelected:
                          allowMultipleSelection
                              ? _selectedValues.contains(e)
                              : e == _selectedValue,
                      hasCheckbox: allowMultipleSelection,
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
          embeddedSearch:
              isSearchEmbedded
                  ? OptimusDropdownEmbeddedSearch(
                    initialValue: _searchToken,
                    onTextChanged: _handleTextChanged,
                    placeholder: 'Search',
                  )
                  : null,
          groupBy:
              enableGrouping
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
