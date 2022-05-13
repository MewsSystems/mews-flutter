import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story tagStory = Story(
  name: 'Tags/Tag',
  builder: (context) {
    final k = context.knobs;

    Widget buildSystemTags() => Wrap(
          children: OptimusColorOption.values
              .map(
                (c) => _PaddedSystemTag(
                  colorOption: c,
                  text: k.text(label: 'Text', initial: ''),
                ),
              )
              .toList(),
        );

    Widget buildCategoricalTags() => Wrap(
          children: OptimusCategoricalColorOption.values
              .map(
                (c) => _PaddedCategoricalTag(
                  colorOption: c,
                  text: k.text(label: 'Text', initial: ''),
                ),
              )
              .toList(),
        );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const OptimusSectionTitle(child: Text('System')),
        buildSystemTags(),
        const SizedBox(height: 20),
        const OptimusSectionTitle(child: Text('Categorical')),
        buildCategoricalTags(),
      ],
    );
  },
);

final Story interactiveTagStory = Story(
  name: 'Tags/Interactive tag',
  builder: (context) {
    final k = context.knobs;

    return OptimusInteractiveTag(
      text: k.text(label: 'Text', initial: 'Removable tag'),
      onRemoved: k.boolean(label: 'Enabled', initial: true) ? () {} : null,
    );
  },
);

class _PaddedSystemTag extends StatelessWidget {
  const _PaddedSystemTag({
    Key? key,
    required this.colorOption,
    required this.text,
  }) : super(key: key);

  final OptimusColorOption colorOption;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: OptimusTag(
          text: text.isEmpty ? describeEnum(colorOption) : text,
          colorOption: colorOption,
        ),
      );
}

class _PaddedCategoricalTag extends StatelessWidget {
  const _PaddedCategoricalTag({
    Key? key,
    required this.colorOption,
    required this.text,
  }) : super(key: key);

  final OptimusCategoricalColorOption colorOption;
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: OptimusCategoricalTag(
          text: text.isEmpty ? describeEnum(colorOption) : text,
          colorOption: colorOption,
        ),
      );
}
