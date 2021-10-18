import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusChatInput extends StatefulWidget {
  const OptimusChatInput({Key? key, required this.onSendPressed})
      : super(key: key);

  final SendCallback onSendPressed;

  @override
  _OptimusChatInputState createState() => _OptimusChatInputState();
}

class _OptimusChatInputState extends State<OptimusChatInput> {
  final _controller = TextEditingController();

  bool get _isSendEnabled => _controller.value.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
        controller: _controller,
        maxLines: 4,
        minLines: 1,
        suffix: OptimusEnabled(
          isEnabled: _isSendEnabled,
          child: GestureDetector(
            onTap: () {
              widget.onSendPressed(_controller.text);
              _controller.clear();
            },
            child: const OptimusIcon(
              iconData: OptimusIcons.send_message,
              colorOption: OptimusIconColorOption.basic,
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

typedef SendCallback = void Function(String message);
