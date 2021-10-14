import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dialogStory = Story(
  name: 'Modal dialog',
  section: 'Dialogs',
  builder: (context, k) {
    final isDismissible = k.boolean(label: 'Dismissible', initial: true);
    final hasCloseButton = k.boolean(label: 'Close button', initial: false);
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
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.small,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
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
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.regular,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
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
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('1 button'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showTwoActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
                    size: OptimusDialogSize.large,
                    content: content,
                    type: type,
                    title: title,
                  ),
                  child: const Text('2 buttons'),
                ),
                OptimusButton(
                  variant: OptimusButtonVariant.primary,
                  onPressed: () => _showThreeActionDialog(
                    context: context,
                    isDismissible: isDismissible,
                    hasCloseButton: hasCloseButton,
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

Future<void> _showThreeActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required bool hasCloseButton,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      hasCloseButton: hasCloseButton,
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

Future<void> _showTwoActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required bool hasCloseButton,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      hasCloseButton: hasCloseButton,
      title: Text(title),
      content: content,
      size: size,
      type: type,
      actions: const [
        OptimusDialogAction(title: Text('Submit')),
        OptimusDialogAction(title: Text('Cancel')),
      ],
    );

Future<void> _showOneActionDialog({
  required BuildContext context,
  required bool isDismissible,
  required bool hasCloseButton,
  required OptimusDialogSize size,
  required Widget content,
  required OptimusDialogType type,
  required String title,
}) =>
    showOptimusDialog(
      context: context,
      isDismissible: isDismissible,
      hasCloseButton: hasCloseButton,
      title: Text(title),
      content: content,
      size: size,
      type: type,
      actions: const [OptimusDialogAction(title: Text('Close'))],
    );

Future<void> _showCustomContentDialog({
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
      child: Column(
        children: const [
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
