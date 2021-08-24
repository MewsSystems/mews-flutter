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
    required this.hasAvatars,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
    required this.onSendPressed,
  }) : super(key: key) {
    _messages
      ..addAll(messages)
      ..sort(_byTime);
  }

  final List<OptimusMessage> _messages = [];
  final bool hasAvatars;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final SendCallback onSendPressed;

  @override
  Widget build(BuildContext context) => OptimusStack(
        spacing: OptimusStackSpacing.spacing50,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) => OptimusStack(
                direction: Axis.horizontal,
                crossAxisAlignment: OptimusStackAlignment.end,
                mainAxisAlignment: _bubbleAlignment(index),
                children: [
                  if (hasAvatars &&
                      _messages[index].alignment == MessageAlignment.left)
                    _buildAvatar(index),
                  Flexible(
                    child: OptimusChatBubble(
                      message: _messages[index],
                      isStatusVisible: _showStatus(index),
                      isUserNameVisible: _showUserName(index),
                      isDateVisible: _showDate(index),
                      formatTime: formatTime,
                      formatDate: formatDate,
                      sending: sending,
                      sent: sent,
                      error: error,
                    ),
                  ),
                  if (hasAvatars &&
                      _messages[index].alignment == MessageAlignment.right)
                    _buildAvatar(index),
                ],
              ),
            ),
          ),
          OptimusChatInput(onSendPressed: onSendPressed),
        ],
      );

  Widget _buildAvatar(int index) => Padding(
        padding: EdgeInsets.only(bottom: _showAvatar(index) ? 34 : 0),
        child: SizedBox(
          width: 40,
          child: _showAvatar(index) ? _messages[index].avatar : null,
        ),
      );

  OptimusStackAlignment _bubbleAlignment(int index) =>
      _messages[index].alignment == MessageAlignment.left
          ? OptimusStackAlignment.start
          : OptimusStackAlignment.end;

  bool _previousMessageIsFromSameUser(int index) =>
      index - 1 >= 0 &&
      _messages[index - 1].userName != _messages[index].userName;

  bool _showAvatar(int index) =>
      _lastMessageOfDay(index) ||
      _latestMessage(index) ||
      _previousMessageIsFromSameUser(index);

  bool _showStatus(int index) =>
      _lastMessageOfDay(index) ||
      (_previousMessageTime(index) != null &&
          _currentMessageTime(index)
                  .difference(_previousMessageTime(index)!)
                  .inMinutes >=
              1) ||
      _messages[index].state != MessageState.sent ||
      _latestMessage(index) ||
      _previousMessageIsFromSameUser(index);

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

  int _byTime(OptimusMessage m1, OptimusMessage m2) =>
      m2.time.compareTo(m1.time);
}

typedef FormatDate = String Function(DateTime);
typedef FormatTime = String Function(DateTime);
