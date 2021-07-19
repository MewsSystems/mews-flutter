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
          initial: sentMessageStatus,
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
          tryAgain: const Text('Try Again'),
          onTryAgainPressed: (message) async => sentMessageStatus,
        ),
      );
    });

const sentMessageStatus = MessageState.sent(text: 'Sent');

final List<Option<MessageState>> _status = [
  const Option('Sent', sentMessageStatus),
  const Option('Sending', MessageState.sending(text: 'Sending...')),
  Option('Error', MessageState.error(text: 'Error', onTryAgain: () {})),
];

final List<Option<MessageAlignment>> _type =
    MessageAlignment.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<MessageColor>> _color =
    MessageColor.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<Widget>> _avatar = [
  const Option('No image', avatar2),
  const Option('With image', avatar1),
];
