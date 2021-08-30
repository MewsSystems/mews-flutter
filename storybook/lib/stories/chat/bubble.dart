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
        author: OptimusMessageAuthor(
          id: 'id',
          username: k.text(label: 'User name', initial: 'Doggo'),
          avatar: avatar2,
        ),
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
        state: MessageState.sent,
        color: k.options(
          label: 'Color',
          initial: MessageColor.dark,
          options: _color,
        ),
      );

      return Center(
        child: OptimusChatBubble(
          message: message,
          isUserNameVisible: k.boolean(label: 'Show user name', initial: true),
          isDateVisible: k.boolean(label: 'Show date', initial: true),
          formatTime: (DateTime input) =>
              '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
          formatDate: (DateTime input) =>
              '${input.day}. ${input.month}. ${input.year}',
          sending: const Text('Sending...'),
          sent: const Text('Sent'),
          error: const Text('Error, try sending again'),
        ),
      );
    });

final List<Option<MessageAlignment>> _type =
    MessageAlignment.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<MessageColor>> _color =
    MessageColor.values.map((e) => Option(describeEnum(e), e)).toList();
