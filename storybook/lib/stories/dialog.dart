import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dialogStory = Story(
  name: 'Modal dialog',
  section: 'Dialogs',
  builder: (context, k) {
    final isDismissible = k.boolean('Dismissible', initial: true);
    final content =
        k.boolean('Scrollable', initial: false) ? _scrollableContent : _content;
    final type =
        k.options('Type', initial: OptimusDialogType.common, options: _types);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: spacing300, bottom: spacing200),
              child: OptimusSectionTitle(child: Text('Small dialog')),
            ),
            Wrap(
              spacing: spacing100,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: spacing300, bottom: spacing200),
              child: OptimusSectionTitle(child: Text('Regular dialog')),
            ),
            Wrap(
              spacing: spacing100,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: spacing300, bottom: spacing200),
              child: OptimusSectionTitle(child: Text('Large dialog')),
            ),
            Wrap(
              spacing: spacing100,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: spacing300, bottom: spacing200),
              child: OptimusSectionTitle(child: Text('Custom content')),
            ),
            Wrap(
              spacing: spacing100,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showCustomContentDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    type: type,
                  ),
                  child: const Text('Custom content'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);

Future<void> _showThreeActionDialog({
  BuildContext context,
  bool isDismissible,
  OptimusDialogSize size,
  Widget content,
  OptimusDialogType type,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: const Text('Dialog title'),
      content: content,
      size: size,
      type: type,
      actions: const [
        OptimusDialogAction(title: Text('Next')),
        OptimusDialogAction(title: Text('Back')),
        OptimusDialogAction(title: Text('Cancel')),
      ],
    );

Future<void> _showTwoActionDialog({
  BuildContext context,
  bool isDismissible,
  OptimusDialogSize size,
  Widget content,
  OptimusDialogType type,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: const Text('Dialog title'),
      content: content,
      size: size,
      type: type,
      actions: const [
        OptimusDialogAction(title: Text('Submit')),
        OptimusDialogAction(title: Text('Cancel')),
      ],
    );

Future<void> _showOneActionDialog({
  BuildContext context,
  bool isDismissible,
  OptimusDialogSize size,
  Widget content,
  OptimusDialogType type,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: const Text('Dialog title'),
      content: content,
      size: size,
      type: type,
      actions: const [OptimusDialogAction(title: Text('Close'))],
    );

Future<void> _showCustomContentDialog({
  BuildContext context,
  bool isDismissible,
  OptimusDialogSize size,
  OptimusDialogType type,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: const Text('Dialog title'),
      content: Container(
        color: OptimusLightColors.neutral50,
        child: const Center(child: Text('Custom content without paddings')),
      ),
      contentWrapperBuilder: (_, child) => child,
      size: size,
      type: type,
    );

Widget get _content => Container(
      height: 200,
      width: double.infinity,
      color: OptimusLightColors.neutral50,
      child: const Center(child: Text('Content')),
    );

Widget get _scrollableContent => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:
          _iterable.map((i) => ListTile(title: Text('List tile #$i'))).toList(),
    );

final List<Option<OptimusDialogType>> _types =
    OptimusDialogType.values.toOptions();

final _iterable = Iterable<int>.generate(50);
