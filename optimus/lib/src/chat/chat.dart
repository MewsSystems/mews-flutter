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
  }) : super(key: key);

  final List<Message> messages;
  final Function formatTime;
  final Widget sending;
  final Widget notSend;
  final Widget sent;
  final Widget tryAgain;
  final VoidCallback onTryAgainClicked;

  @override
  Widget build(BuildContext context) => OptimusStack(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ChatBubble(
                  userName: messages[index].userName,
                  message: Text(messages[index].message),
                  type: messages[index].type,
                  time: messages[index].time,
                  status: messages[index].status,
                  showAvatar: true,
                  showStatus: true,
                  showUserName: true,
                  formatTime: formatTime,
                  sending: sending,
                  sent: sent,
                  notSend: notSend,
                  tryAgain: tryAgain,
                  onTryAgainClicked: onTryAgainClicked,
                ),
            ),
          ),
          const ChatInput(),
        ],
      );
}
