import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

//TODO(witwash): add nested use case
@widgetbook.UseCase(
  name: 'Modal Dialog',
  type: OptimusDialog,
  path: '[Layout]/Dialog',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final isDismissible = k.boolean(label: 'Dismissible', initialValue: true);
  final content = k.boolean(label: 'Scrollable', initialValue: false)
      ? _scrollableContent
      : _content(context);
  final type = k.list(
    label: 'Type',
    initialOption: OptimusDialogType.common,
    options: OptimusDialogType.values,
  );
  final title = k.string(label: 'Title', initialValue: 'Dialog title');

  return Center(
    child: SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 16),
            child: OptimusTitleMedium(child: Text('Small dialog')),
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
            child: OptimusTitleMedium(child: Text('Regular dialog')),
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
            child: OptimusTitleMedium(child: Text('Large dialog')),
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
            child: OptimusTitleMedium(child: Text('Custom content')),
          ),
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
    ),
  );
}

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
      //TODO(witwash): tokens
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

final _iterable = Iterable<int>.generate(50);
