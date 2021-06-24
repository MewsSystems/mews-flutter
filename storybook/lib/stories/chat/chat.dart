import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chatStory = Story(
  section: 'Chat',
  name: 'Chat',
  builder: (_, k) => Chat(
    messages: messages,
    formatTime: (DateTime input) => '${input.hour}:${input.minute}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    notSend: const Text('Not send'),
    tryAgain: const Text('Try again'),
    onTryAgainClicked: () {},
  ),
);

final messages = <Message>[
  Message(
    userName: 'User 1',
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    type: MessageType.inbound,
    time: DateTime.now()..subtract(const Duration(seconds: 30)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'You',
    message: 'Donec eget elit et massa rhoncus ullamcorper a non ex. Nulla vulputate condimentum libero, non congue ligula auctor ac. Pellentesque vel dui a turpis ultricies accumsan non sed nulla. Aenean interdum tempus scelerisque.',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 28)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 1',
    message: 'Quisque arcu turpis',
    type: MessageType.inbound,
    time: DateTime.now()..subtract(const Duration(seconds: 27)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 1',
    message: 'euismod quis maximus sit amet',
    type: MessageType.inbound,
    time: DateTime.now()..subtract(const Duration(seconds: 27)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 1',
    message: 'convallis eleifend ante.',
    type: MessageType.inbound,
    time: DateTime.now()..subtract(const Duration(seconds: 26)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 3',
    message: '😁',
    type: MessageType.outboundOrganisation,
    time: DateTime.now()..subtract(const Duration(seconds: 25)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'You',
    message: 'Suspendisse diam ante, condimentum ut interdum sit amet, suscipit non massa.',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 20)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'You',
    message: 'Maecenas pellentesque',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 18)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'You',
    message: 'quam sed viverra ornare',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 18)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 1',
    message: 'tellus orci placerat purus',
    type: MessageType.inbound,
    time: DateTime.now()..subtract(const Duration(seconds: 17)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 3',
    message: 'ut consectetur orci metus sed nibh. Praesent in tellus facilisis, sagittis odio eget, maximus turpis',
    type: MessageType.outboundOrganisation,
    time: DateTime.now()..subtract(const Duration(seconds: 15)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'User 3',
    message: 'Aliquam porttitor quis eros pharetra blandit.',
    type: MessageType.outboundOrganisation,
    time: DateTime.now()..subtract(const Duration(seconds: 12)),
    status: MessageStatus.sent,
  ),
  Message(
    userName: 'You',
    message: '🤔',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 18)),
    status: MessageStatus.sending,
  ),
  Message(
    userName: 'You',
    message: '😫',
    type: MessageType.outbound,
    time: DateTime.now()..subtract(const Duration(seconds: 15)),
    status: MessageStatus.notSent,
  ),
];