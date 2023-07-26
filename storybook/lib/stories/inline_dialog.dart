import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inlineDialogStory = Story(
  name: 'Data Display/Dialogs/Inline Dialog',
  builder: (context) => DialogWrapper(child: InlineDialogStory(context.knobs)),
);

class InlineDialogStory extends StatefulWidget {
  const InlineDialogStory(
    this.k, {
    super.key,
  });

  final KnobsBuilder k;

  @override
  State<InlineDialogStory> createState() => _InlineDialogStoryState();
}

class _InlineDialogStoryState extends State<InlineDialogStory> {
  final GlobalKey _anchor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final hasActions = widget.k.boolean(label: 'Has actions', initial: false);
    final position = widget.k.options(
      label: 'Button Position',
      options: alignments,
      initial: Alignment.center,
    );

    return Align(
      alignment: position,
      child: OptimusButton(
        key: _anchor,
        onPressed: () => {
          DialogWrapper.of(context)?.showInline(
            anchorKey: _anchor,
            content: const Padding(
              padding: EdgeInsets.all(8.0),
              child: _InlineContentExample(),
            ),
            actions: hasActions
                ? [const OptimusDialogAction(title: Text('OK'))]
                : [],
          ),
        },
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
          )
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
            OptimusNumberPickerFormField(initialValue: 8)
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
