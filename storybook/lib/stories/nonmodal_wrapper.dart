import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalWrapper = Story(
  name: 'nonModalWrapper',
  builder: (context, k) => NonModalWrapper(
    context: context,
    child: const _ButtonWithDialog(),
  ),
);

class _ButtonWithDialog extends StatelessWidget {
  const _ButtonWithDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => OptimusButton(
        onPressed: () => {
          NonModalWrapper.of(context).show(
            child: OptimusButton(
              onPressed: () => {NonModalWrapper.of(context).remove()},
              child: const Text('HIDE'),
            ),
          ),
        },
        child: const Text('SHOW'),
      );
}
