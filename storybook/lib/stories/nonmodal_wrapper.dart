import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalWrapper = Story(
  name: 'Non Modal Wrapper',
  builder: (context, k) => NonModalWrapper(
    child: _Content(k: k),
  ),
);

class _Content extends StatelessWidget {
  const _Content({
    Key key,
    @required this.k,
  }) : super(key: key);

  final KnobsBuilder k;

  @override
  Widget build(BuildContext context) {
    final isDismissible = k.boolean('Dismissible', initial: true);
    final hasActions = k.boolean('Has actions', initial: false);

    return OptimusButton(
      onPressed: () => {
        NonModalWrapper.of(context).show(
          title: const Text('Title'),
          content: const Text('Content'),
          isDismissible: isDismissible,
          actions:
              hasActions ? [const OptimusDialogAction(title: Text('OK'))] : [],
          size: OptimusDialogSize.small,
        ),
      },
      child: const Text('show'),
    );
  }
}
