import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalDialogStory = Story(
  name: 'Non-modal dialog',
  section: 'Dialogs',
  builder: (context, k) => NonModalWrapper(
    child: NonModalDialogStory(k),
  ),
);

class NonModalDialogStory extends StatelessWidget {
  const NonModalDialogStory(this.k, {Key? key}) : super(key: key);

  final KnobsBuilder k;

  @override
  Widget build(BuildContext context) {
    final hasCrossButton = k.boolean(label: 'Has cross button', initial: true);
    final hasActions = k.boolean(label: 'Has actions', initial: false);
    final title = k.text(label: 'Title', initial: 'Dialog title');

    return OptimusButton(
      onPressed: () => {
        NonModalWrapper.of(context)?.show(
          title: Text(title),
          content: const Text('Content'),
          hasCrossButton: hasCrossButton,
          actions: hasActions || !hasCrossButton
              ? [const OptimusDialogAction(title: Text('OK'))]
              : [],
          size: OptimusDialogSize.small,
        ),
      },
      child: const Text('show'),
    );
  }
}
