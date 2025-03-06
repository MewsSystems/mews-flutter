import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Non-modal Dialog',
  type: OptimusDialog,
  path: '[Data Display]',
)
Widget createDefaultStyle(BuildContext context) => DialogWrapper(
      child: NonModalDialogStory(context.knobs),
    );

class NonModalDialogStory extends StatelessWidget {
  const NonModalDialogStory(this.k, {super.key});

  final KnobsBuilder k;

  @override
  Widget build(BuildContext context) {
    final isDismissible = k.boolean(label: 'Dismissible', initialValue: true);
    final hasActions = k.boolean(label: 'Has actions', initialValue: false);
    final title = k.string(label: 'Title', initialValue: 'Dialog title');

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
