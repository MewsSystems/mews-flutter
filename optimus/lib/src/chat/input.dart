import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/constants.dart';

class OptimusChatInput extends StatefulWidget {
  const OptimusChatInput({Key? key, required this.onSendPressed})
      : super(key: key);

  final SendCallback onSendPressed;

  @override
  _OptimusChatInputState createState() => _OptimusChatInputState();
}

class _OptimusChatInputState extends State<OptimusChatInput> {
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
            widget.onSendPressed(_controller.text);
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

typedef SendCallback = void Function(String message);
