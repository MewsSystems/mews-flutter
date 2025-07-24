import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/chat/common.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: '', type: OptimusChatBubble, path: '[Forms]/Chat')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;
  final message = OptimusMessage(
    author: OptimusMessageAuthor(
      id: 'id',
      username: k.string(label: 'User name', initialValue: 'Doggo'),
      avatar: avatar2,
    ),
    message: k.string(
      label: 'Message',
      initialValue:
          'Prow scuttle parrel provost Sail ho shrouds spirits boom mizzenmast yardarm.',
    ),
    time: stubDate,
    alignment: k.list(
      label: 'Alignment',
      initialOption: MessageAlignment.left,
      options: MessageAlignment.values,
      labelBuilder: enumLabelBuilder,
    ),
    state: MessageState.sent,
    color: k.list(
      label: 'Color',
      initialOption: MessageColor.user,
      options: MessageColor.values,
      labelBuilder: enumLabelBuilder,
    ),
  );

  return OptimusChatBubble(
    message: message,
    isUserNameVisible: k.boolean(label: 'Show user name', initialValue: true),
    formatTime:
        (DateTime input) =>
            '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
    formatDate:
        (DateTime input) => '${input.day}. ${input.month}. ${input.year}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    error: const Text('Error, try sending again'),
  );
}
