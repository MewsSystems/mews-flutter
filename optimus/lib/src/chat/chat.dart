import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/input.dart';
import 'package:optimus/src/chat/message.dart';
import 'package:optimus/src/typography/presets.dart';

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
    required this.isFromCurrentUser,
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
  final bool Function(OptimusMessage) isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        left: spacing200,
        right: spacing200,
        bottom: spacing200,
      ),
      child: OptimusStack(
        spacing: OptimusStackSpacing.spacing200,
        children: [
          Expanded(
            child: _buildMessagesList(theme),
          ),
          OptimusChatInput(onSendPressed: onSendPressed),
        ],
      ),
    );
  }

  Widget _buildMessagesList(OptimusThemeData theme) => ListView.builder(
        itemCount: _messages.length,
        reverse: true,
        itemBuilder: (context, index) => OptimusStack(
          direction: Axis.vertical,
          children: [
            OptimusStack(
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
            if (_showStatus(index))
              _buildStatus(index, _messages[index], theme),
          ],
        ),
      );

  double get _avatarWidth => hasAvatars ? 40 : 0;

  Widget _buildAvatar(int index) => SizedBox(
        width: _avatarWidth,
        child: _showAvatar(index) ? _messages[index].avatar : null,
      );

  Padding _buildStatus(
    int index,
    OptimusMessage message,
    OptimusThemeData theme,
  ) =>
      Padding(
        padding: _statusPadding(index, message.alignment),
        child: _buildStatusText(index, message, theme),
      );

  EdgeInsets _statusPadding(
    int index,
    MessageAlignment alignment,
  ) =>
      EdgeInsets.only(
        top: spacing100,
        left:
            alignment == MessageAlignment.left ? spacing100 + _avatarWidth : 0,
        right:
            alignment == MessageAlignment.right ? spacing100 + _avatarWidth : 0,
        bottom: !_latestMessage(index) ? spacing100 : 0,
      );

  Widget _buildStatusTextStyle(OptimusThemeData theme, Widget child) =>
      DefaultTextStyle.merge(
        style: baseTextStyle.copyWith(
          color: theme.isDark
              ? theme.colors.neutral0t64
              : theme.colors.neutral1000t64,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        child: child,
      );

  Widget _buildStatusText(
    int index,
    OptimusMessage message,
    OptimusThemeData theme,
  ) {
    late final List<Widget> children;
    final color =
        theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

    switch (message.state) {
      case MessageState.sending:
        children = [
          _buildStatusTextStyle(theme, Text(formatTime(message.time))),
          _buildStatusTextStyle(theme, sending),
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                width: 1.2,
                color: color,
              ),
            ),
          ),
        ];
        break;
      case MessageState.sent:
        children = [
          _buildStatusTextStyle(theme, Text(formatTime(message.time))),
          if (message.alignment == MessageAlignment.right &&
              isFromCurrentUser(message))
            _buildStatusTextStyle(theme, sent),
          if (message.alignment == MessageAlignment.right &&
              isFromCurrentUser(message))
            const Opacity(
              opacity: 0.6,
              child: OptimusIcon(
                iconData: OptimusIcons.done_circle,
                iconSize: OptimusIconSize.small,
              ),
            )
        ];
        break;
      case MessageState.error:
        children = [
          _buildStatusTextStyle(theme, error),
          const OptimusIcon(
            iconData: OptimusIcons.disable,
            iconSize: OptimusIconSize.small,
            colorOption: OptimusColorOption.danger,
          ),
        ];
        break;
    }

    return OptimusStack(
      mainAxisAlignment: _bubbleAlignment(index),
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing50,
      children: children,
    );
  }

  OptimusStackAlignment _bubbleAlignment(int index) =>
      _messages[index].alignment == MessageAlignment.left
          ? OptimusStackAlignment.start
          : OptimusStackAlignment.end;

  bool _previousMessageIsFromSameUser(int index) =>
      index - 1 >= 0 &&
      _messages[index - 1].sender.id == _messages[index].sender.id;

  bool _showAvatar(int index) =>
      _lastMessageOfDay(index) ||
      _moreThanOneMinuteDifferenceForward(index) ||
      _latestMessage(index) ||
      !_previousMessageIsFromSameUser(index);

  bool _showStatus(int index) =>
      _lastMessageOfDay(index) ||
      _moreThanOneMinuteDifferenceForward(index) ||
      _messages[index].state != MessageState.sent ||
      _latestMessage(index) ||
      !_previousMessageIsFromSameUser(index);

  bool _showUserName(int index) =>
      !isFromCurrentUser(_messages[index]) &&
      (_moreThanOneMinuteDifferenceBack(index) ||
          _oldestMessage(index) ||
          _messages[index < _messages.length ? index + 1 : index].sender.id !=
              _messages[index].sender.id);

  bool _showDate(int index) =>
      _previousMessageTime(index) == null ||
      _currentMessageTime(index)
              .difference(_previousMessageTime(index)!)
              .inDays >=
          1;

  bool _moreThanOneMinuteDifferenceBack(int index) =>
      _previousMessageTime(index) != null &&
      _currentMessageTime(index)
              .difference(_previousMessageTime(index)!)
              .abs()
              .inMinutes >=
          1;

  bool _moreThanOneMinuteDifferenceForward(int index) =>
      _nextMessageTime(index) != null &&
      _currentMessageTime(index)
              .difference(_nextMessageTime(index)!)
              .abs()
              .inMinutes >=
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
