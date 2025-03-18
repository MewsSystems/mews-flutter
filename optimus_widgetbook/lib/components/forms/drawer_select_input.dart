import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
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
  final _controller = TextEditingController();
  String? _value;

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
      error: k.string(label: 'Error'),
      isEnabled: k.isEnabledKnob,
      isRequired: k.boolean(label: 'Required'),
      leading: k.optimusIconWidgetOrNullKnob(label: 'Leading'),
      trailing: k.optimusIconWidgetOrNullKnob(label: 'Trailing'),
      prefix: k.string(label: 'Prefix').maybeToWidget(),
      suffix: k.string(label: 'Suffix').maybeToWidget(),
      showLoader: k.boolean(label: 'Show loader'),
      caption: k.string(label: 'Caption').maybeToWidget(),
      secondaryCaption: k.string(label: 'Secondary caption').maybeToWidget(),
      size: k.widgetSizeKnob,
      isReadOnly: k.boolean(label: 'Read only'),
      placeholder: k.string(label: 'Placeholder'),
      value: _value,
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
                      isSelected: _value == e,
                      hasCheckbox: false,
                    ),
                  )
                  .toList(),
      builder: (value) => value,
      isSearchable: k.boolean(label: 'Is searchable', initialValue: true),
      onChanged: (value) => setState(() => _value = value),
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
