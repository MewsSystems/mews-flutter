import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalWrapper = Story(
  name: 'Non Modal Wrapper',
  builder: (context, k) => const NonModalWrapper(
    child: _Content(),
  ),
);

class _Content extends StatelessWidget {
  const _Content({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OptimusButton(
        onPressed: () => {
          NonModalWrapper.of(context).show(
            title: const Text('Title'),
            content: const Text('Content'),
            isDismissible: true,
          ),
        },
        child: const Text('show'),
      );
}
