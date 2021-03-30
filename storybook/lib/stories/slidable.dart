import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story slidableStory = Story.simple(
  padding: EdgeInsets.zero,
  name: 'Slidable',
  child: ListView.builder(
    itemBuilder: (context, i) => OptimusSlidable(
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
      ),
    ),
    itemCount: 1000,
  ),
);
