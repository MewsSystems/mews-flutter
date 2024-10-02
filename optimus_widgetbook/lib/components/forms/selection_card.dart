import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Selection Card',
  type: OptimusSelectionCard,
  path: '[Forms]',
)
Widget createDefaultStyle(BuildContext _) => const _SelectionCardExample();

class _SelectionCardExample extends StatefulWidget {
  const _SelectionCardExample();

  @override
  State<_SelectionCardExample> createState() => _SelectionCardExampleState();
}

class _SelectionCardExampleState extends State<_SelectionCardExample> {
  bool _isSelected = false;

  void _handlePress() => setState(() => _isSelected = !_isSelected);

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final title = k.string(label: 'Title', initialValue: 'Title');
    final description =
        k.string(label: 'Description', initialValue: 'Description');
    final trailing = k.optimusIconOrNullKnob(label: 'Trailing Icon');
    final variant = k.list(
      label: 'Variant',
      initialOption: OptimusSelectionCardVariant.vertical,
      options: OptimusSelectionCardVariant.values,
      labelBuilder: (value) => value.name,
    );
    final borderRadius = k.list(
      label: 'Border radius',
      initialOption: OptimusSelectionCardBorderRadius.medium,
      options: OptimusSelectionCardBorderRadius.values,
      labelBuilder: (value) => value.name,
    );
    final selectorVariant = k.list(
      label: 'Selector variant',
      initialOption: OptimusSelectionCardSelectionVariant.radio,
      options: OptimusSelectionCardSelectionVariant.values,
      labelBuilder: (value) => value.name,
    );
    final isSelectorVisible =
        k.boolean(label: 'Selector visible', initialValue: true);
    final isEnabled = k.isEnabledKnob;

    return SizedBox(
      width: 500,
      child: OptimusSelectionCard(
        title: Text(title),
        description: description.isNotEmpty ? Text(description) : null,
        trailing: trailing != null ? Icon(trailing.data) : null,
        variant: variant,
        isSelected: _isSelected,
        isSelectorVisible: isSelectorVisible,
        selectionVariant: selectorVariant,
        borderRadius: borderRadius,
        isEnabled: isEnabled,
        onPressed: _handlePress,
      ),
    );
  }
}
