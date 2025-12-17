import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/chat/optimus_chat_input.dart';
import 'package:optimus/src/common/semantics.dart';

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

  bool _isPreviousMessageFromSameUser(int index) =>
      index - 1 >= 0 &&
      _messages[index - 1].author.id == _messages[index].author.id;

  bool _isAvatarVisible(int index) =>
      _isLastMessageOfDay(index) ||
      _isMoreThanOneMinuteDifferenceForward(index) ||
      _isLatestMessage(index) ||
      !_isPreviousMessageFromSameUser(index);

  bool _showStatus(int index) =>
      _isLastMessageOfDay(index) ||
      _isMoreThanOneMinuteDifferenceForward(index) ||
      _messages[index].deliveryStatus != .sent ||
      _isLatestMessage(index) ||
      !_isPreviousMessageFromSameUser(index);

  bool _showUserName(int index) =>
      !isFromCurrentUser(_messages[index]) &&
      (_isMoreThanOneMinuteDifferenceBack(index) ||
          _isOldestMessage(index) ||
          _messages[index < _messages.length ? index + 1 : index].author.id !=
              _messages[index].author.id);

  bool _showDate(int index) {
    final previousMessageTime = _previousMessageTime(index);

    return previousMessageTime == null ||
        _currentMessageTime(index).difference(previousMessageTime).inDays >= 1;
  }

  bool _isMoreThanOneMinuteDifferenceBack(int index) {
    final previousMessageTime = _previousMessageTime(index);

    return previousMessageTime != null &&
        _currentMessageTime(
              index,
            ).difference(previousMessageTime).abs().inMinutes >=
            1;
  }

  bool _isMoreThanOneMinuteDifferenceForward(int index) {
    final nextMessageTime = _nextMessageTime(index);

    return nextMessageTime != null &&
        _currentMessageTime(
              index,
            ).difference(nextMessageTime).abs().inMinutes >=
            1;
  }

  DateTime _currentMessageTime(int index) => _messages[index].time;

  DateTime? _previousMessageTime(int index) =>
      index + 1 < _messages.length ? _messages[index + 1].time : null;

  DateTime? _nextMessageTime(int index) =>
      index - 1 > 0 ? _messages[index - 1].time : null;

  bool _isLastMessageOfDay(int index) {
    final nextMessageTime = _nextMessageTime(index);

    return nextMessageTime == null ||
        nextMessageTime.difference(_currentMessageTime(index)).inDays > 1;
  }

  bool _isLatestMessage(int index) => index == 0;

  bool _isOldestMessage(int index) => index + 1 == _messages.length;

  int _byTime(OptimusMessage m1, OptimusMessage m2) =>
      m2.time.compareTo(m1.time);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final avatarWidth = hasAvatars ? tokens.spacing500 : tokens.spacing0;

    return Padding(
      padding: .only(
        left: tokens.spacing200,
        right: tokens.spacing200,
        bottom: tokens.spacing200,
      ),
      child: OptimusStack(
        spacing: .spacing200,
        children: [
          // ignore: avoid-flexible-outside-flex, it is wrapped in Flex later
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (_, index) => Column(
                children: [
                  _Bubble(
                    hasAvatars: hasAvatars,
                    avatar: _Avatar(
                      avatarWidth: avatarWidth,
                      isAvatarVisible: _isAvatarVisible(index),
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
                    owner: _messages[index].owner,
                  ),
                  if (_showStatus(index))
                    _StatusEnd(
                      avatarWidth: avatarWidth,
                      error: error,
                      formatTime: formatTime,
                      message: _messages[index],
                      sending: sending,
                      sent: sent,
                      isFromCurrentUser: isFromCurrentUser(_messages[index]),
                      isLatestMessage: _isLatestMessage(index),
                      owner: _messages[index].owner,
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
    required this.owner,
  });

  final double avatarWidth;
  final OptimusMessage message;
  final FormatTime formatTime;
  final Widget sending;
  final Widget sent;
  final Widget error;
  final bool isFromCurrentUser;
  final bool isLatestMessage;
  final MessageOwner owner;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      children: [
        SizedBox(height: tokens.spacing50).excludeSemantics(),
        Row(
          mainAxisAlignment: owner.mainAxisAlignment,
          children: [
            if (owner.isAssistant)
              SizedBox(
                width: tokens.spacing100 + avatarWidth,
              ).excludeSemantics(),
            _StatusText(
              message: message,
              formatTime: formatTime,
              sending: sending,
              sent: sent,
              error: error,
              isFromCurrentUser: isFromCurrentUser,
            ),
            if (owner.isUser)
              SizedBox(
                height: isLatestMessage ? tokens.spacing0 : tokens.spacing100,
              ).excludeSemantics(),
          ],
        ),
        SizedBox(
          height: isLatestMessage ? tokens.spacing0 : tokens.spacing100,
        ).excludeSemantics(),
      ],
    );
  }
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
  Widget build(BuildContext context) =>
      SizedBox(width: avatarWidth, child: isAvatarVisible ? avatar : null);
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
    mainAxisAlignment: message.owner.stackAlignment,
    direction: .horizontal,
    spacing: .spacing50,
    children: switch (message.deliveryStatus) {
      .sending => [
        _Status(child: Text(formatTime(message.time))),
        _Status(child: sending),
        const _StatusCircle(),
      ],
      .sent => [
        _Status(child: Text(formatTime(message.time))),
        if (isFromCurrentUser) ...[
          _Status(child: sent),
          const Opacity(
            opacity: 0.6,
            child: OptimusIcon(
              iconData: OptimusIcons.done_circle,
              iconSize: .small,
            ),
          ),
        ],
      ],
      .error => [
        _Status(child: error),
        const OptimusIcon(
          iconData: OptimusIcons.disable,
          iconSize: .small,
          colorOption: .danger,
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
    required this.owner,
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
  final MessageOwner owner;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final children = [
      if (hasAvatars) avatar,
      Flexible(
        child: OptimusChatBubble(
          message: message,
          isUserNameVisible: isUserNameVisible,
          formatTime: formatTime,
          formatDate: formatDate,
          sending: sending,
          sent: sent,
          error: error,
        ),
      ),
    ];

    return Column(
      children: [
        if (isDateVisible) ...[
          SizedBox(height: tokens.spacing200).excludeSemantics(),
          OptimusDivider(
            usePadding: false,
            child: OptimusCaption(child: Text(formatDate(message.time))),
          ),
          SizedBox(height: tokens.spacing200).excludeSemantics(),
        ],
        OptimusStack(
          direction: .horizontal,
          crossAxisAlignment: isUserNameVisible ? .start : .end,
          mainAxisAlignment: owner.stackAlignment,
          children: owner.isAssistant ? children : children.reversed.toList(),
        ),
      ],
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      style: tokens.bodySmall.copyWith(
        color: tokens.textStaticTertiary,
        fontWeight: .w600,
      ),
      child: child,
    );
  }
}

class _StatusCircle extends StatelessWidget {
  const _StatusCircle();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      width: tokens.spacing200,
      height: tokens.spacing200,
      decoration: BoxDecoration(
        borderRadius: .all(tokens.borderRadius100),
        border: .all(
          width: tokens.borderWidth100,
          color: tokens.textStaticTertiary,
        ),
      ),
    );
  }
}

extension on MessageOwner {
  OptimusStackAlignment get stackAlignment => switch (this) {
    .assistant => .start,
    .user => .end,
  };

  MainAxisAlignment get mainAxisAlignment => switch (this) {
    .assistant => .start,
    .user => .end,
  };

  bool get isAssistant => this == .assistant;
  bool get isUser => this == .user;
}
