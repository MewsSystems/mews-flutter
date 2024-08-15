import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nonModalDialogStory = Story(
  name: 'Data Display/Dialogs/Non-modal Dialog',
  builder: (context) => DialogWrapper(
    child: NonModalDialogStory(context.knobs),
  ),
);

class NonModalDialogStory extends StatelessWidget {
  const NonModalDialogStory(this.k, {super.key});

  final KnobsBuilder k;

  @override
  Widget build(BuildContext context) {
    final isDismissible = k.boolean(label: 'Dismissible', initial: true);
    final hasActions = k.boolean(label: 'Has actions', initial: false);
    final title = k.text(label: 'Title', initial: 'Dialog title');

    return OptimusButton(
      onPressed: () => DialogWrapper.of(context)?.show(
        title: Text(title),
        content: const Text('Content'),
        isDismissible: isDismissible,
        actions:
            hasActions ? [const OptimusDialogAction(title: Text('OK'))] : [],
        size: OptimusDialogSize.small,
      ),
      child: const Text('show'),
    );
  }
}
