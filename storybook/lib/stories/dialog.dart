import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dialogStory = Story(
  name: 'Layout/Dialogs/Modal Dialog',
  builder: (context) {
    final k = context.knobs;
    final isDismissible = k.boolean(label: 'Dismissible', initial: true);
    final content = k.boolean(label: 'Scrollable', initial: false)
        ? _scrollableContent
        : _content(context);
    final type = k.options(
      label: 'Type',
      initial: OptimusDialogType.common,
      options: _types,
    );
    final title = k.text(label: 'Title', initial: 'Dialog title');

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 16),
              child: OptimusSectionTitle(child: Text('Small dialog')),
            ),
            Wrap(
              spacing: 8,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 16),
              child: OptimusSectionTitle(child: Text('Regular dialog')),
            ),
            Wrap(
              spacing: 8,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 16),
              child: OptimusSectionTitle(child: Text('Large dialog')),
            ),
            Wrap(
              spacing: 8,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowOneActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('3 buttons'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24, bottom: 16),
              child: OptimusSectionTitle(child: Text('Custom content')),
            ),
            Wrap(
              spacing: 8,
              children: [
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _handleShowCustomContentDialog(
                    context: context,
                    isDismissible: isDismissible,
                    size: OptimusDialogSize.large,
                    type: type,
                    title: title,
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

Future<void> _handleShowThreeActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: Text(title),
      content: content,
      size: size,
      type: type,
      actions: const [
        OptimusDialogAction(title: Text('Next')),
        OptimusDialogAction(title: Text('Back')),
        OptimusDialogAction(title: Text('Cancel')),
      ],
    );

Future<void> _handleShowTwoActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: Text(title),
      content: content,
      size: size,
      type: type,
      actions: const [
        OptimusDialogAction(title: Text('Submit')),
        OptimusDialogAction(title: Text('Cancel')),
      ],
    );

Future<void> _handleShowOneActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      title: Text(title),
      content: content,
      size: size,
      type: type,
      actions: const [OptimusDialogAction(title: Text('Close'))],
    );

Future<void> _handleShowCustomContentDialog({
  required BuildContext context,
  required bool isDismissible,
  required OptimusDialogSize size,
  required OptimusDialogType type,
  required String title,
}) {
  final theme = OptimusTheme.of(context);

  return showOptimusDialog(
    context: context,
    isDismissible: isDismissible,
    title: Text(title),
    content: Container(
      color: theme.isDark ? theme.colors.neutral400 : theme.colors.neutral100,
      padding: const EdgeInsets.all(8),
      child: const Column(
        children: [
          Center(child: Text('Custom content without paddings')),
          OptimusInputField(
            placeholder: 'Input field to test offsets on keyboard',
          ),
        ],
      ),
    ),
    contentWrapperBuilder: (_, child) => child,
    size: size,
    type: type,
  );
}

Widget _content(BuildContext context) {
  final theme = OptimusTheme.of(context);

  return Container(
    height: 200,
    width: double.infinity,
    color: theme.isDark ? theme.colors.neutral400 : theme.colors.neutral100,
    child: const Center(child: Text('Content')),
  );
}

Widget get _scrollableContent => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:
          _iterable.map((i) => ListTile(title: Text('List tile #$i'))).toList(),
    );

final List<Option<OptimusDialogType>> _types =
    OptimusDialogType.values.toOptions();

final _iterable = Iterable<int>.generate(50);
