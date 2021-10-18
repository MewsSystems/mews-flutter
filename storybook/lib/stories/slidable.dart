import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story slidableStory = Story(
  padding: EdgeInsets.zero,
  name: 'Slidable',
  builder: (_, k) {
    final double actionsWidth = k
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
  const _Content({Key? key, required this.actionsWidth}) : super(key: key);

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
