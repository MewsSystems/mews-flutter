import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story slidableStory = Story(
  name: 'Slidable',
  builder: (context) {
    final double actionsWidth = context.knobs
        .sliderInt(
          label: 'Actions Width',
          initial: 0,
          max: 500,
        )
        .toDouble();

    return _Content(actionsWidth: actionsWidth);
  },
);

class _Content extends StatelessWidget {
  const _Content({required this.actionsWidth});

  final double actionsWidth;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, i) => OptimusSlidable(
          actionsWidth: actionsWidth,
          actions: [
            OptimusSlideAction(
              color: Colors.red,
              onTap: () {},
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
          child: ListTile(
            title: Text('Slidable element #$i'),
            subtitle: Text('Subtitle #$i'),
            isThreeLine: i % 3 == 0,
          ),
        ),
        itemCount: 1000,
      );
}
