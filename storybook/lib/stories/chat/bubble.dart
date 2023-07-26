import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/chat/chat.dart';
import 'package:storybook/utils.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chatBubbleStory = Story(
  name: 'Forms/Chat/Chat Bubble',
  builder: (context) {
    final k = context.knobs;
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
        options: MessageAlignment.values.toOptions(),
      ),
      state: MessageState.sent,
      color: k.options(
        label: 'Color',
        initial: MessageColor.dark,
        options: MessageColor.values.toOptions(),
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
  },
);
