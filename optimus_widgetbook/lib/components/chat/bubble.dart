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
    owner: k.object.dropdown(
      label: 'Owner',
      initialOption: MessageOwner.user,
      options: MessageOwner.values,
      labelBuilder: enumLabelBuilder,
    ),
    deliveryStatus: MessageDeliveryStatus.sent,
    state: k.object.dropdown(
      label: 'State',
      initialOption: MessageState.basic,
      options: MessageState.values,
      labelBuilder: enumLabelBuilder,
    ),
  );

  return OptimusChatBubble(
    message: message,
    isUserNameVisible: k.boolean(label: 'Show user name', initialValue: true),
    formatTime: (DateTime input) =>
        '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
    formatDate: (DateTime input) =>
        '${input.day}. ${input.month}. ${input.year}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    error: const Text('Error, try sending again'),
  );
}
