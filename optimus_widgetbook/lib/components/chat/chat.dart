import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/chat/common.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: '', type: OptimusChat, path: '[Forms]/Chat')
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  return OptimusChat(
    messages: messages,
    isFromCurrentUser: (m) => m.author.id == 'you',
    hasAvatars: k.boolean(label: 'Enable avatar', initialValue: true),
    formatTime:
        (DateTime input) =>
            '${input.hour}:${input.minute.toString().padLeft(2, '0')}',
    formatDate:
        (DateTime input) => '${input.day}. ${input.month}. ${input.year}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    error: DefaultTextStyle.merge(
      style: const TextStyle(decoration: TextDecoration.underline),
      child: const Text('Error, try sending again'),
    ),
    onSendPressed: (message) {},
  );
}

final messages = <OptimusMessage>[
  OptimusMessage(
    author: _you,
    message: 'Old message',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(days: 365)),
  ),
  OptimusMessage(
    author: _you,
    message: 'Hey you!',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(days: 6, minutes: 2)),
  ),
  OptimusMessage(
    author: _you,
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(days: 6)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'Hello',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(days: 5, minutes: 15)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'consectetur adipiscing elit',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(days: 5)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'Suspendisse diam ante, condimentum ut interdum sit amets',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(days: 5)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(hours: 2)),
  ),
  OptimusMessage(
    author: _you,
    message:
        'Donec eget elit et massa rhoncus ullamcorper a non ex. Nulla vulputate condimentum libero, non congue ligula auctor ac. Pellentesque vel dui a turpis ultricies accumsan non sed nulla. Aenean interdum tempus scelerisque.',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 45)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'Quisque arcu turpis',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(minutes: 30)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'euismod quis maximus sit amet',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(minutes: 5, seconds: 27)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'convallis eleifend ante.',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(minutes: 5, seconds: 26)),
  ),
  OptimusMessage(
    author: _user3,
    message: '😁',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 5, seconds: 25)),
  ),
  OptimusMessage(
    author: _you,
    message:
        'Suspendisse diam ante, condimentum ut interdum sit amet, suscipit non massa.',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 5, seconds: 20)),
  ),
  OptimusMessage(
    author: _you,
    message: 'sdf sfsdfdsfsh fdf sdf',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 3, seconds: 19)),
  ),
  OptimusMessage(
    author: _you,
    message: 'Maecenas pellentesque',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 2, seconds: 55)),
  ),
  OptimusMessage(
    author: _you,
    message: 'quam sed viverra ornare',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 2, seconds: 35)),
  ),
  OptimusMessage(
    author: _user1,
    message: 'tellus orci placerat purus',
    owner: MessageOwner.assistant,
    time: stubDate.subtract(const Duration(minutes: 2, seconds: 28)),
  ),
  OptimusMessage(
    author: _user3,
    message:
        'ut consectetur orci metus sed nibh. Praesent in tellus facilisis, sagittis odio eget, maximus turpis',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 2, seconds: 27)),
  ),
  OptimusMessage(
    author: _user3,
    message: 'orci metus sed nibh. Praesent in tellus facilisis,',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 1, seconds: 25)),
  ),
  OptimusMessage(
    author: _user3,
    message: 'Aliquam porttitor quis eros pharetra blandit.',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(minutes: 1, seconds: 20)),
  ),
  OptimusMessage(
    author: _user3,
    message: 'Test',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(seconds: 15)),
  ),
  OptimusMessage(
    author: _you,
    message: '🤔',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(seconds: 14)),
    deliveryStatus: MessageDeliveryStatus.sending,
  ),
  OptimusMessage(
    author: _you,
    message: '😫',
    owner: MessageOwner.user,
    time: stubDate.subtract(const Duration(seconds: 12)),
    deliveryStatus: MessageDeliveryStatus.error,
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
