import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/chat/chat.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chatBubbleStory = Story(
    section: 'Chat',
    name: 'Chat Bubble',
    builder: (_, k) {
      final message = OptimusMessage(
        userName: k.text(label: 'User name', initial: 'Doggo'),
        message: k.text(
          label: 'Message',
          initial:
              'Prow scuttle parrel provost Sail ho shrouds spirits boom mizzenmast yardarm.',
        ),
        time: DateTime.now().subtract(const Duration(seconds: 30)),
        alignment: k.options(
          label: 'Alignment',
          initial: MessageAlignment.left,
          options: _type,
        ),
        state: k.options(
          label: 'Status',
          initial: const MessageState.sent(),
          options: _status,
        ),
        avatar: k.options(
          label: 'Avatar',
          initial: avatar2,
          options: _avatar,
        ),
        color: k.options(
          label: 'Color',
          initial: MessageColor.dark,
          options: _color,
        ),
      );

      return Center(
        child: OptimusChatBubble(
          message: message,
          isAvatarVisible: k.boolean(label: 'Show avatar', initial: true),
          isUserNameVisible: k.boolean(label: 'Show user name', initial: true),
          isStatusVisible: k.boolean(label: 'Show status', initial: true),
          isDateVisible: k.boolean(label: 'Show date', initial: true),
          formatTime: (DateTime input) =>
              '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
          formatDate: (DateTime input) =>
              '${input.day}. ${input.month}. ${input.year}',
          notSend: const Text('Not Sent'),
          sent: const Text('Sent'),
          sending: const Text('Sending...'),
          tryAgain: const Text('Try Again'),
          onTryAgainClicked: (message) async => const MessageState.sent(),
        ),
      );
    });

const avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

final List<Option<MessageState>> _status = [
  const Option('Sent', MessageState.sent()),
  const Option('Sending', MessageState.sending()),
  Option('Error', MessageState.error(onTryAgain: () {})),
];

final List<Option<MessageAlignment>> _type =
    MessageAlignment.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<MessageColor>> _color =
    MessageColor.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<Widget>> _avatar = [
  const Option('No image', avatar2),
  const Option('With image', avatar1),
];
