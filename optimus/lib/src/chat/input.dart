import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/constants.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key, required this.onSendClicked}) : super(key: key);

  final OnSend onSendClicked;

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => setState(() {}));

    return OptimusInputField(
      controller: _controller,
      maxLines: 4,
      minLines: 1,
      suffix: Opacity(
        opacity: _controller.value.text.isNotEmpty
            ? OpacityValue.enabled
            : OpacityValue.disabled,
        child: GestureDetector(
          onTap: () {
            widget.onSendClicked(_controller.text);
            _controller.clear();
          },
          child: const OptimusIcon(
            iconData: OptimusIcons.send_message,
            colorOption: OptimusColorOption.basic,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef OnSend = Function(String message);