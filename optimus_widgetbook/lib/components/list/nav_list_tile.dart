import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Navigation List Tile',
  type: OptimusNavListTile,
  path: '[Data Display]/List',
)
Widget createDefaultStyle(BuildContext _) => const _NavListExample();

class _NavListExample extends StatefulWidget {
  const _NavListExample();

  @override
  State<_NavListExample> createState() => _NavListExampleState();
}

class _NavListExampleState extends State<_NavListExample> {
  bool _isToggled = false;

  void _handleToggle(bool isToggled) => setState(() => _isToggled = isToggled);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final label = k.string(label: 'Label', initialValue: 'Label');
    final leading = k.optimusIconOrNullKnob(label: 'Leading Icon');
    final rightDetail = k.optimusIconOrNullKnob(label: 'Right Detail');
    final isToggleVisible = k.boolean(label: 'Toggle', initialValue: false);
    final isChevronVisible = k.boolean(label: 'Chevron', initialValue: false);
    final isEnabled = k.isEnabledKnob;
    final useHorizontalPadding = k.boolean(
      label: 'Use Padding',
      initialValue: true,
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children:
              Iterable<int>.generate(10)
                  .map(
                    (i) => OptimusNavListTile(
                      label: Text(label),
                      semanticLabel: label,
                      rightDetail:
                          rightDetail != null ? Icon(rightDetail.data) : null,
                      isChevronVisible: isChevronVisible,
                      isToggleVisible: isToggleVisible,
                      onTogglePressed: _handleToggle,
                      isToggled: _isToggled,
                      isEnabled: isEnabled,
                      leading: leading != null ? Icon(leading.data) : null,
                      useHorizontalPadding: useHorizontalPadding,
                      onTap: () {},
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
