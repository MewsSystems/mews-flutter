import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final chatBubbleStory = Story(
  section: 'Chat',
  name: 'Chat Bubble',
  builder: (_, k) => Center(
    child: ChatBubble(
      userName: k.text(label: 'User name', initial: 'Doggo'),
      message: Text(k.text(
        label: 'Message',
        initial:
            'Prow scuttle parrel provost Sail ho shrouds spirits boom mizzenmast yardarm.',
      )),
      type: k.options(
        label: 'Type',
        initial: MessageType.inbound,
        options: _type,
      ),
      time: DateTime.now()..subtract(const Duration(seconds: 30)),
      status: k.options(
        label: 'Status',
        initial: MessageStatus.sent,
        options: _status,
      ),
      showAvatar: k.boolean(label: 'Show avatar', initial: true),
      avatarUrl: k.options(
        label: 'Avatar url',
        initial: avatarUrl,
        options: _avatarUrls,
      ),
      organisationAvatarUrl: k.options(
        label: 'Organisation avatar url',
        initial: organisationAvatarUrl,
        options: _organisationAvatarUrls,
      ),
      showUserName: k.boolean(label: 'Show user name', initial: true),
      showStatus: k.boolean(label: 'Show status', initial: true),
      formatTime: (DateTime input) => '${input.hour}:${input.minute}',
      notSend: const Text('Not Sent'),
      sent: const Text('Sent'),
      sending: const Text('Sending...'),
      tryAgain: const Text('Try Again'),
      onTryAgainClicked: () {},
    ),
  ),
);

const avatarUrl =
    'https://images.unsplash.com/photo-1560525821-d5615ef80c69?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=512&q=80';

const organisationAvatarUrl =
    'https://images.unsplash.com/photo-1599305445671-ac291c95aaa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=256&q=80';

final List<Option<MessageStatus>> _status =
    MessageStatus.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<MessageType>> _type =
    MessageType.values.map((e) => Option(describeEnum(e), e)).toList();

final List<Option<String?>> _avatarUrls = {'Empty': null, 'Present': avatarUrl}
    .entries
    .map((e) => Option(e.key, e.value))
    .toList();

final List<Option<String?>> _organisationAvatarUrls = {
  'Empty': null,
  'Present': organisationAvatarUrl
}.entries.map((e) => Option(e.key, e.value)).toList();
