import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/chat/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: '',
  type: OptimusChat,
  path: '[Forms]/Chat',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusChat(
    messages: messages,
    isFromCurrentUser: (m) => m.author.id == 'you',
    hasAvatars: k.boolean(label: 'Enable avatar', initialValue: true),
    formatTime: (DateTime input) =>
        '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
    formatDate: (DateTime input) =>
        '${input.day}. ${input.month}. ${input.year}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    error: DefaultTextStyle.merge(
      style: const TextStyle(
        decoration: TextDecoration.underline,
      ),
      child: const Text('Error, try sending again'),
    ),
    onSendPressed: (message) {},
  );
}

final messages = <OptimusMessage>[
  OptimusMessage(
    author: _you,
    message: 'Old message',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 365)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: 'Hey you!',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 6, minutes: 2)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 6)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'Hello',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5, minutes: 15)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'consectetur adipiscing elit',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'Suspendisse diam ante, condimentum ut interdum sit amets',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(hours: 2)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message:
        'Donec eget elit et massa rhoncus ullamcorper a non ex. Nulla vulputate condimentum libero, non congue ligula auctor ac. Pellentesque vel dui a turpis ultricies accumsan non sed nulla. Aenean interdum tempus scelerisque.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 45)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'Quisque arcu turpis',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(minutes: 30)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'euismod quis maximus sit amet',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(minutes: 5, seconds: 27)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'convallis eleifend ante.',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(minutes: 5, seconds: 26)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user3,
    message: '😁',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(minutes: 5, seconds: 25)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message:
        'Suspendisse diam ante, condimentum ut interdum sit amet, suscipit non massa.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 5, seconds: 20)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: 'sdf sfsdfdsfsh fdf sdf',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 3, seconds: 19)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: 'Maecenas pellentesque',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 2, seconds: 55)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: 'quam sed viverra ornare',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 2, seconds: 35)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user1,
    message: 'tellus orci placerat purus',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(minutes: 2, seconds: 28)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user3,
    message:
        'ut consectetur orci metus sed nibh. Praesent in tellus facilisis, sagittis odio eget, maximus turpis',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(minutes: 2, seconds: 27)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user3,
    message: 'orci metus sed nibh. Praesent in tellus facilisis,',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(minutes: 1, seconds: 25)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user3,
    message: 'Aliquam porttitor quis eros pharetra blandit.',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(minutes: 1, seconds: 20)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _user3,
    message: 'Test',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(seconds: 15)),
    state: MessageState.sent,
  ),
  OptimusMessage(
    author: _you,
    message: '🤔',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 14)),
    state: MessageState.sending,
  ),
  OptimusMessage(
    author: _you,
    message: '😫',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 12)),
    state: MessageState.error,
  ),
];

const _you = OptimusMessageAuthor(id: 'you', username: 'You', avatar: avatar2);
const _user1 = OptimusMessageAuthor(
  id: 'user1',
  username: 'User 1',
  avatar: avatar1,
);
final _user3 = OptimusMessageAuthor(
  id: 'user3',
  username: 'User 3',
  avatar: organizationAvatar,
);
