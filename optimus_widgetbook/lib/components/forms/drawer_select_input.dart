import 'package:dfunc/dfunc.dart';
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

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;

    return OptimusDrawerSelectInput(
      label: k.string(label: 'Label', initialValue: 'Label'),
      value: _selectedValue,
      items: const [
        ListDropdownTile<String>(value: '1', title: Text('Option 1')),
        ListDropdownTile<String>(value: '2', title: Text('Option 2')),
        ListDropdownTile<String>(value: '3', title: Text('Option 3')),
      ],
      builder: (value) => value,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }
}
