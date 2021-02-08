import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalWrapper = Story(
  name: 'Non Modal Wrapper',
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
            child: OptimusCard(
              child: OptimusButton(
                onPressed: NonModalWrapper.of(context).hide,
                child: const Text('hide'),
              ),
            ),
          ),
        },
        child: const Text('show'),
      );
}
