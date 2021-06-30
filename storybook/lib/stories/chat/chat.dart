import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chatStory = Story(
  section: 'Chat',
  name: 'Chat',
  builder: (_, k) => Chat(
    messages: messages,
    formatTime: (DateTime input) => '${input.hour}:${input.minute}',
    formatDate: (DateTime input) =>
        '${input.day}. ${input.month}. ${input.year}',
    sending: const Text('Sending...'),
    sent: const Text('Sent'),
    notSend: const Text('Not send'),
    tryAgain: const Text('Try again'),
    onTryAgainClicked: (index, message) async => MessageStatus.sent,
    onSendClicked: (message) {},
  ),
);

const avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

const avatar2Url =
    'https://images.unsplash.com/photo-1543466835-00a7907e9de1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80';

const organisationAvatarUrl =
    'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80';

const avatar1 = OptimusAvatar(
  title: 'User 1',
  imageUrl: avatarUrl,
);

const avatar2 = OptimusAvatar(
  title: 'You',
);

const avatar3 = OptimusAvatar(
  title: 'User 3',
  imageUrl: avatar2Url,
);

final organisationAvatar = Stack(children: [
  avatar3,
  Positioned(
    bottom: 0,
    right: 0,
    child: Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: NetworkImage(organisationAvatarUrl),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
]);

final messages = <Message>[
  Message(
    userName: 'You',
    message: 'Old message',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 7)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: 'Hey you!',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 5)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(days: 5)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'User 1',
    message: 'Hello',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 1',
    message: 'consectetur adipiscing elit',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 1',
    message: 'Suspendisse diam ante, condimentum ut interdum sit amets',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(days: 5)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 1',
    message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(hours: 2)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'You',
    message:
        'Donec eget elit et massa rhoncus ullamcorper a non ex. Nulla vulputate condimentum libero, non congue ligula auctor ac. Pellentesque vel dui a turpis ultricies accumsan non sed nulla. Aenean interdum tempus scelerisque.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(minutes: 45)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'User 1',
    message: 'Quisque arcu turpis',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(minutes: 30)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 1',
    message: 'euismod quis maximus sit amet',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(seconds: 27)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 1',
    message: 'convallis eleifend ante.',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(seconds: 26)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 3',
    message: '😁',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(seconds: 25)),
    status: MessageStatus.sent,
    avatar: organisationAvatar,
  ),
  Message(
    userName: 'You',
    message:
        'Suspendisse diam ante, condimentum ut interdum sit amet, suscipit non massa.',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 20)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: 'sdf sfsdfdsfsh fdf sdf',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 19)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: 'Maecenas pellentesque',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 18)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: 'quam sed viverra ornare',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 18)),
    status: MessageStatus.sent,
    avatar: avatar2,
  ),
  Message(
    userName: 'User 1',
    message: 'tellus orci placerat purus',
    alignment: MessageAlignment.left,
    color: MessageColor.neutral,
    time: DateTime.now().subtract(const Duration(seconds: 17)),
    status: MessageStatus.sent,
    avatar: avatar1,
  ),
  Message(
    userName: 'User 3',
    message:
        'ut consectetur orci metus sed nibh. Praesent in tellus facilisis, sagittis odio eget, maximus turpis',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(seconds: 17)),
    status: MessageStatus.sent,
    avatar: organisationAvatar,
  ),
  Message(
    userName: 'User 3',
    message: 'Aliquam porttitor quis eros pharetra blandit.',
    alignment: MessageAlignment.right,
    color: MessageColor.light,
    time: DateTime.now().subtract(const Duration(seconds: 15)),
    status: MessageStatus.sent,
    avatar: organisationAvatar,
  ),
  Message(
    userName: 'You',
    message: '🤔',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 16)),
    status: MessageStatus.sending,
    avatar: avatar2,
  ),
  Message(
    userName: 'You',
    message: '😫',
    alignment: MessageAlignment.right,
    color: MessageColor.dark,
    time: DateTime.now().subtract(const Duration(seconds: 12)),
    status: MessageStatus.notSent,
    avatar: avatar2,
  ),
];
