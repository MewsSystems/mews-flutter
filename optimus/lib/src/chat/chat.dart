import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/input.dart';
import 'package:optimus/src/chat/message.dart';

/// The chat components offer instant real-time communication between
/// two (or multiple) parties. It also serves as a log or transcript
/// of past conversations. Individual chat components assemble into
/// a chat window layout.
class OptimusChat extends StatelessWidget {
  OptimusChat({
    Key? key,
    required List<OptimusMessage> messages,
    required this.formatTime,
    required this.formatDate,
    required this.tryAgain,
    required this.onTryAgainPressed,
    required this.onSendPressed,
  }) : super(key: key) {
    _messages.addAll(messages.reversed);
  }

  final List<OptimusMessage> _messages = [];
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget tryAgain;
  final TryAgainCallback onTryAgainPressed;
  final SendCallback onSendPressed;

  @override
  Widget build(BuildContext context) => OptimusStack(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) => OptimusChatBubble(
                message: _messages[index],
                isAvatarVisible: _showAvatar(index),
                isStatusVisible: _showStatus(index),
                isUserNameVisible: _showUserName(index),
                isDateVisible: _showDate(index),
                formatTime: formatTime,
                formatDate: formatDate,
                tryAgain: tryAgain,
                onTryAgainPressed: onTryAgainPressed,
              ),
            ),
          ),
          OptimusChatInput(onSendPressed: onSendPressed),
        ],
      );

  bool _showAvatar(int index) =>
      _lastMessageOfDay(index) ||
      _latestMessage(index) ||
      _messages[index - 1].userName != _messages[index].userName;

  bool _showStatus(int index) =>
      _lastMessageOfDay(index) ||
      (_previousMessageTime(index) != null &&
          _currentMessageTime(index)
                  .difference(_previousMessageTime(index)!)
                  .inMinutes >=
              1) ||
      _messages[index].state != const MessageState.sent(text: 'Sent') ||
      _messages[index - 1].userName != _messages[index].userName;

  bool _showUserName(int index) =>
      _oldestMessage(index) ||
      _messages[index < _messages.length ? index + 1 : index].userName !=
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

  bool _oldestMessage(int index) => index + 1 == _messages.length;
}

typedef FormatDate = String Function(DateTime);
typedef FormatTime = String Function(DateTime);
