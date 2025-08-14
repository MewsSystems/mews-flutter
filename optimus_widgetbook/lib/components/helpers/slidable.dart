import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Slidable',
  type: OptimusSlideAction,
  path: '[Helpers]',
)
Widget createDefaultStyle(BuildContext context) {
  final double actionsWidth = context.knobs.int
      .slider(label: 'Actions Width', initialValue: 0, max: 500)
      .toDouble();

  return _Content(actionsWidth: actionsWidth);
}

class _Content extends StatelessWidget {
  const _Content({required this.actionsWidth});

  final double actionsWidth;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemBuilder: (context, i) => OptimusSlidable(
      actionsWidth: actionsWidth,
      actions: const [
        OptimusSlideAction(
          color: Colors.red,
          semanticLabel: 'Delete',
          child: OptimusIcon(
            iconData: OptimusIcons.delete,
            colorOption: OptimusIconColorOption.inverse,
          ),
        ),
      ],
      child: ListTile(
        title: Text('Slidable element #$i'),
        subtitle: Text('Subtitle #$i'),
        isThreeLine: i % 3 == 0,
      ),
    ),
    itemCount: 10,
  );
}
