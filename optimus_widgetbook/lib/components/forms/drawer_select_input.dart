import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final GlobalKey _drawerSelectUseCaseKey = GlobalKey();

@widgetbook.UseCase(
  name: 'Drawer Select Input',
  type: OptimusDrawerSelectInput,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) =>
    _DrawerExample(key: _drawerSelectUseCaseKey);

class _DrawerExample extends StatefulWidget {
  const _DrawerExample({super.key});

  @override
  State<_DrawerExample> createState() => _DrawerExampleState();
}

class _DrawerExampleState extends State<_DrawerExample> {
  String? _selectedValue;
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    return OptimusDrawerSelectInput(
      label: k.string(label: 'Label', initialValue: 'Label'),
      value: _selectedValue,
      controller: _controller,
      listBuilder:
          (query) =>
              _characters
                  .where((e) => e.toLowerCase().contains(query))
                  .map(
                    (e) => ListDropdownTile<String>(
                      value: e,
                      title: Text(e),
                      subtitle: Text(e.toUpperCase()),
                      isSelected: e == _selectedValue,
                      hasCheckbox: false,
                    ),
                  )
                  .toList(),
      builder: (value) => value,
      isSearchable: k.boolean(label: 'Is searchable', initialValue: true),
      onChanged: (value) {
        setState(() => _selectedValue = value);
      },
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
