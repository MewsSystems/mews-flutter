import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story dialogStory = Story(
  name: 'Dialog',
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
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showOneActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.small,
                  content: content,
                ),
                child: const Text('Small 1'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showOneActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.small,
                  content: content,
                  type: type,
                ),
                child: const Text('Small 2'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showTwoActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.small,
                  content: content,
                  type: type,
                ),
                child: const Text('Small 2'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showOneActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.regular,
                  content: content,
                  type: type,
                ),
                child: const Text('Regular 1'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showTwoActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.regular,
                  content: content,
                  type: type,
                ),
                child: const Text('Regular 2'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showThreeActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.regular,
                  content: content,
                  type: type,
                ),
                child: const Text('Regular 3'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showOneActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.large,
                  content: content,
                  type: type,
                ),
                child: const Text('Large 1'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showTwoActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.large,
                  content: content,
                  type: type,
                ),
                child: const Text('Large 2'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showThreeActionDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.large,
                  content: content,
                  type: type,
                ),
                child: const Text('Large 3'),
              ),
            ),
            _padding(
              child: OptimusButton(
                variant: OptimusButtonVariant.primary,
                onPressed: () => _showCustomContentDialog(
                  context: context,
                  isDismissible: isDismissible,
                  size: OptimusDialogSize.large,
                  type: type,
                ),
                child: const Text('Custom content'),
              ),
            ),
          ],
        ),
      ),
    );
  },
);

Widget _padding({Widget child}) =>
    Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: child);

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
      content: ListView.builder(
        itemCount: _iterable.length,
        itemBuilder: (_, index) => ListTile(
          title: Text('List tile #${_iterable.toList()[index]}'),
        ),
      ),
      contentWrapperBuilder: (_, child) => child,
      size: size,
      type: type,
    );

Widget get _content => Container(
      height: 200,
      width: double.infinity,
      color: OptimusColors.neutral50,
      child: const Center(child: Text('Content')),
    );

Widget get _scrollableContent => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children:
          _iterable.map((i) => ListTile(title: Text('List tile #$i'))).toList(),
    );

final List<Option<OptimusDialogType>> _types =
    OptimusDialogType.values.map((e) => Option(describeEnum(e), e)).toList();

final _iterable = Iterable<int>.generate(50);
