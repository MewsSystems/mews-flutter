import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/input.dart';

class Chat extends StatelessWidget {
  const Chat({
    Key? key,
    required this.messages,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.notSend,
    required this.tryAgain,
    required this.onTryAgainClicked,
    required this.onSendClicked,
  }) : super(key: key);

  final List<Message> messages;
  final Function formatTime;
  final Function formatDate;
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
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) => ChatBubble(
                index: index,
                message: _messages[index],
                showAvatar: _showAvatar(index),
                showStatus: _showStatus(index),
                showUserName: _showUserName(index),
                showDate: _showDate(index),
                formatTime: formatTime,
                formatDate: formatDate,
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
      _lastMessageOfDay(index) ||
      _latestMessage(index) ||
      _messages[index - 1].userName != _messages[index].userName;

  bool _showStatus(int index) =>
      _lastMessageOfDay(index) ||
      _messages[index].status != MessageStatus.sent ||
      _messages[index - 1].userName != _messages[index].userName;

  bool _showUserName(int index) =>
      _oldestMessage(index) ||
      _messages[index < messages.length ? index + 1 : index].userName !=
          _messages[index].userName;

  bool _showDate(int index) =>
      _previousMessageTime(index) == null ||
      _currentMessageTime(index)
              .difference(_previousMessageTime(index)!)
              .inDays >=
          1;

  DateTime _currentMessageTime(int index) => _messages[index].time;

  DateTime? _previousMessageTime(int index) =>
      index + 1 < _messages.length ? _messages[index + 1].time : null;

  DateTime? _nextMessageTime(int index) =>
      index - 1 > 0 ? _messages[index - 1].time : null;

  bool _lastMessageOfDay(int index) =>
      index - 1 > 0 &&
      _nextMessageTime(index)!.difference(_currentMessageTime(index)).inDays >
          1;

  bool _latestMessage(int index) => index == 0;

  bool _oldestMessage(int index) => index + 1 == messages.length;
}
