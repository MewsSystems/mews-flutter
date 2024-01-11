import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/optimus_chat_input.dart';
import 'package:optimus/src/typography/presets.dart';

typedef FormatDate = String Function(DateTime value);
typedef FormatTime = String Function(DateTime value);

/// The chat components offer instant real-time communication between
/// two (or multiple) parties. It also serves as a log or transcript
/// of past conversations. Individual chat components assemble into
/// a chat window layout.
class OptimusChat extends StatelessWidget {
  OptimusChat({
    super.key,
    required List<OptimusMessage> messages,
    required this.hasAvatars,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
    required this.onSendPressed,
    required this.isFromCurrentUser,
  }) {
    _messages = [...messages]..sort(_byTime);
  }

  late final List<OptimusMessage> _messages;
  final bool hasAvatars;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final ValueChanged<String> onSendPressed;
  final Predicate<OptimusMessage> isFromCurrentUser;

  double get _avatarWidth => hasAvatars ? spacing500 : 0;

  bool _previousMessageIsFromSameUser(int index) =>
      index - 1 >= 0 &&
      _messages[index - 1].author.id == _messages[index].author.id;

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
          _messages[index < _messages.length ? index + 1 : index].author.id !=
              _messages[index].author.id);

  bool _showDate(int index) {
    final previousMessageTime = _previousMessageTime(index);

    return previousMessageTime == null ||
        _currentMessageTime(index).difference(previousMessageTime).inDays >= 1;
  }

  bool _moreThanOneMinuteDifferenceBack(int index) {
    final previousMessageTime = _previousMessageTime(index);

    return previousMessageTime != null &&
        _currentMessageTime(index)
                .difference(previousMessageTime)
                .abs()
                .inMinutes >=
            1;
  }

  bool _moreThanOneMinuteDifferenceForward(int index) {
    final nextMessageTime = _nextMessageTime(index);

    return nextMessageTime != null &&
        _currentMessageTime(index)
                .difference(nextMessageTime)
                .abs()
                .inMinutes >=
            1;
  }

  DateTime _currentMessageTime(int index) => _messages[index].time;

  DateTime? _previousMessageTime(int index) =>
      index + 1 < _messages.length ? _messages[index + 1].time : null;

  DateTime? _nextMessageTime(int index) =>
      index - 1 > 0 ? _messages[index - 1].time : null;

  bool _lastMessageOfDay(int index) {
    final nextMessageTime = _nextMessageTime(index);

    return nextMessageTime == null ||
        nextMessageTime.difference(_currentMessageTime(index)).inDays > 1;
  }

  bool _latestMessage(int index) => index == 0;

  bool _oldestMessage(int index) => index + 1 == _messages.length;

  int _byTime(OptimusMessage m1, OptimusMessage m2) =>
      m2.time.compareTo(m1.time);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: spacing200,
          right: spacing200,
          bottom: spacing200,
        ),
        child: OptimusStack(
          spacing: OptimusStackSpacing.spacing200,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                reverse: true,
                itemBuilder: (_, index) => Column(
                  children: [
                    _Bubble(
                      hasAvatars: hasAvatars,
                      avatar: _Avatar(
                        avatarWidth: _avatarWidth,
                        isAvatarVisible: _showAvatar(index),
                        avatar: _messages[index].author.avatar,
                      ),
                      message: _messages[index],
                      isUserNameVisible: _showUserName(index),
                      isDateVisible: _showDate(index),
                      formatTime: formatDate,
                      formatDate: formatTime,
                      sending: sending,
                      sent: sent,
                      error: error,
                      alignment: _messages[index].alignment,
                    ),
                    if (_showStatus(index))
                      _StatusEnd(
                        avatarWidth: _avatarWidth,
                        error: error,
                        formatTime: formatTime,
                        message: _messages[index],
                        sending: sending,
                        sent: sent,
                        isFromCurrentUser: isFromCurrentUser(_messages[index]),
                        isLatestMessage: _latestMessage(index),
                        alignment: _messages[index].alignment,
                      ),
                  ],
                ),
              ),
            ),
            OptimusChatInput(onSendPressed: onSendPressed),
          ],
        ),
      );
}

class _StatusEnd extends StatelessWidget {
  const _StatusEnd({
    required this.avatarWidth,
    required this.message,
    required this.formatTime,
    required this.sending,
    required this.sent,
    required this.error,
    required this.isFromCurrentUser,
    required this.isLatestMessage,
    required this.alignment,
  });

  final double avatarWidth;
  final OptimusMessage message;
  final FormatTime formatTime;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final bool isFromCurrentUser;
  final bool isLatestMessage;
  final MessageAlignment alignment;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: spacing50),
          Row(
            mainAxisAlignment: alignment.mainAxisAlignment,
            children: [
              if (alignment.isStart) SizedBox(width: spacing100 + avatarWidth),
              _StatusText(
                message: message,
                formatTime: formatTime,
                sending: sending,
                sent: sent,
                error: error,
                isFromCurrentUser: isFromCurrentUser,
              ),
              if (alignment.isEnd)
                SizedBox(height: isLatestMessage ? 0 : spacing100),
            ],
          ),
          SizedBox(height: isLatestMessage ? 0 : spacing100),
        ],
      );
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    required this.avatarWidth,
    required this.isAvatarVisible,
    required this.avatar,
  });

  final double avatarWidth;
  final bool isAvatarVisible;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: avatarWidth,
        child: isAvatarVisible ? avatar : null,
      );
}

class _StatusText extends StatelessWidget {
  const _StatusText({
    required this.message,
    required this.formatTime,
    required this.sending,
    required this.sent,
    required this.error,
    required this.isFromCurrentUser,
  });

  final OptimusMessage message;
  final FormatTime formatTime;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) => OptimusStack(
        mainAxisAlignment: message.alignment.stackAlignment,
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing50,
        children: switch (message.state) {
          MessageState.sending => [
              _Status(child: Text(formatTime(message.time))),
              _Status(child: sending),
              const _StatusCircle(),
            ],
          MessageState.sent => [
              _Status(child: Text(formatTime(message.time))),
              if (isFromCurrentUser) ...[
                _Status(child: sent),
                const Opacity(
                  opacity: 0.6,
                  child: OptimusIcon(
                    iconData: OptimusIcons.done_circle,
                    iconSize: OptimusIconSize.small,
                  ),
                ),
              ],
            ],
          MessageState.error => [
              _Status(child: error),
              const OptimusIcon(
                iconData: OptimusIcons.disable,
                iconSize: OptimusIconSize.small,
                colorOption: OptimusIconColorOption.danger,
              ),
            ],
        },
      );
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.hasAvatars,
    required this.avatar,
    required this.message,
    required this.isUserNameVisible,
    required this.isDateVisible,
    required this.formatTime,
    required this.formatDate,
    required this.sending,
    required this.sent,
    required this.error,
    required this.alignment,
  });

  final bool hasAvatars;
  final Widget avatar;
  final OptimusMessage message;
  final bool isUserNameVisible;
  final bool isDateVisible;
  final FormatTime formatTime;
  final FormatDate formatDate;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final MessageAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (hasAvatars) avatar,
      Flexible(
        child: OptimusChatBubble(
          message: message,
          isUserNameVisible: isUserNameVisible,
          isDateVisible: isDateVisible,
          formatTime: formatTime,
          formatDate: formatDate,
          sending: sending,
          sent: sent,
          error: error,
        ),
      ),
    ];

    return OptimusStack(
      direction: Axis.horizontal,
      crossAxisAlignment: OptimusStackAlignment.end,
      mainAxisAlignment: alignment.stackAlignment,
      children: alignment.isStart ? children : children.reversed.toList(),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return DefaultTextStyle.merge(
      style: baseTextStyle.copyWith(
        color: theme.isDark
            ? theme.colors.neutral0t64
            : theme.colors.neutral1000t64,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      child: child,
    );
  }
}

class _StatusCircle extends StatelessWidget {
  const _StatusCircle();

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      width: 13,
      height: 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.tokens.borderRadius100),
        border: Border.all(
          width: context.tokens.borderWidth100,
          color: theme.isDark
              ? theme.colors.neutral0t64
              : theme.colors.neutral1000t64,
        ),
      ),
    );
  }
}

extension on MessageAlignment {
  OptimusStackAlignment get stackAlignment => switch (this) {
        MessageAlignment.left => OptimusStackAlignment.start,
        MessageAlignment.right => OptimusStackAlignment.end,
      };

  MainAxisAlignment get mainAxisAlignment => switch (this) {
        MessageAlignment.left => MainAxisAlignment.start,
        MessageAlignment.right => MainAxisAlignment.end
      };

  bool get isStart => this == MessageAlignment.left;
  bool get isEnd => this == MessageAlignment.right;
}
