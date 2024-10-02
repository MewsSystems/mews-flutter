import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Inline Dialog',
  type: OptimusInlineDialog,
  path: '[Layout]/Dialog',
)
Widget createDefaultStyle(BuildContext _) =>
    const DialogWrapper(child: InlineDialogStory());

class InlineDialogStory extends StatefulWidget {
  const InlineDialogStory({
    super.key,
  });

  @override
  State<InlineDialogStory> createState() => _InlineDialogStoryState();
}

class _InlineDialogStoryState extends State<InlineDialogStory> {
  final GlobalKey _anchor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final hasActions = k.boolean(label: 'Has actions', initialValue: false);
    final position = k.alignmentKnob;

    return Align(
      alignment: position.$1,
      child: OptimusButton(
        key: _anchor,
        onPressed: () => DialogWrapper.of(context)?.showInline(
          anchorKey: _anchor,
          size: OptimusDialogSize.regular,
          content: const Padding(
            padding: EdgeInsets.all(8.0),
            child: _InlineContentExample(),
          ),
          actions:
              hasActions ? [const OptimusDialogAction(title: Text('OK'))] : [],
        ),
        child: const Text('show'),
      ),
    );
  }
}

class _InlineContentExample extends StatelessWidget {
  const _InlineContentExample();

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          _NumberRow(
            title: 'Adults',
            description: 'From 13 to 100',
          ),
          _NumberRow(
            title: 'Children',
            description: 'From 3 to 12',
          ),
          _NumberRow(
            title: 'Toddlers',
            description: 'From 0 to 3',
          ),
        ],
      );
}

class _NumberRow extends StatelessWidget {
  const _NumberRow({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Title(title: title),
                _Description(description: description),
              ],
            ),
            const Spacer(),
            OptimusStepperFormField(
              initialValue: 8,
              size: OptimusWidgetSize.small,
            ),
          ],
        ),
      );
}

class _Description extends StatelessWidget {
  const _Description({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) =>
      OptimusLabelSmall(child: Text(description));
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => OptimusLabel(child: Text(title));
}
