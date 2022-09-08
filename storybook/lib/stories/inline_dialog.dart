import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story inlineDialogStory = Story(
  name: 'General/Dialogs/Inline dialog',
  builder: (context) => DialogWrapper(child: InlineDialogStory(context.knobs)),
);

class InlineDialogStory extends StatelessWidget {
  InlineDialogStory(
    this.k, {
    Key? key,
  }) : super(key: key);

  final KnobsBuilder k;
  final GlobalKey _anchor = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final hasActions = k.boolean(label: 'Has actions', initial: false);

    return Align(
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

class _InlineContentExample extends StatefulWidget {
  const _InlineContentExample({Key? key}) : super(key: key);

  @override
  State<_InlineContentExample> createState() => _InlineContentExampleState();
}

class _InlineContentExampleState extends State<_InlineContentExample> {
  @override
  Widget build(BuildContext context) => Column(
        children: const [
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
  const _NumberRow({Key? key, required this.title, required this.description})
      : super(key: key);

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
  const _Description({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) =>
      OptimusLabelSmall(child: Text(description));
}

class _Title extends StatelessWidget {
  const _Title({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => OptimusLabel(child: Text(title));
}
