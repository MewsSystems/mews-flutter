import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/input.dart';

class Chat extends StatelessWidget {
  const Chat({
    Key? key,
    required this.messages,
    required this.formatTime,
    required this.sending,
    required this.sent,
    required this.notSend,
    required this.tryAgain,
    required this.onTryAgainClicked,
    required this.onSendClicked,
  }) : super(key: key);

  final List<Message> messages;
  final Function formatTime;
  final Widget sending;
  final Widget notSend;
  final Widget sent;
  final Widget tryAgain;
  final TrySendAgain onTryAgainClicked;
  final OnSend onSendClicked;

  @override
  Widget build(BuildContext context) => OptimusStack(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) => ChatBubble(
                index: index,
                message: _messages[index],
                showAvatar: _showAvatar(index),
                showStatus: _showStatus(index),
                showUserName: _showUserName(index),
                formatTime: formatTime,
                sending: sending,
                sent: sent,
                notSend: notSend,
                tryAgain: tryAgain,
                onTryAgainClicked: onTryAgainClicked,
              ),
            ),
          ),
          ChatInput(onSendClicked: onSendClicked),
        ],
      );

  List<Message> get _messages => messages.reversed.toList();

  bool _showAvatar(int index) =>
      index == 0 ||
      _messages[index == 0 ? 0 : index - 1].userName !=
          _messages[index].userName;

  bool _showStatus(int index) =>
      _messages[index].status != MessageStatus.sent ||
      _messages[index == 0 ? 0 : index - 1].userName !=
          _messages[index].userName;

  bool _showUserName(int index) =>
      index + 1 == messages.length ||
      _messages[index < messages.length ? index + 1 : index].userName !=
          _messages[index].userName;
}
