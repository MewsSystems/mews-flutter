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

  bool _isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() => setState(() {}));

    return OptimusInputField(
      controller: _controller,
      maxLines: 4,
      minLines: 1,
      suffix: OptimusEnabled(
        isEnabled: _isSendEnabled,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isTappedDown = true),
          onTapUp: (_) => setState(() => _isTappedDown = false),
          onTapCancel: () => setState(() => _isTappedDown = false),
          onTap: _isSendEnabled
              ? () {
                  widget.onSendPressed(_controller.text);
                  _controller.clear();
                }
              : null,
          child: Transform.scale(
            scale: _isTappedDown ? 0.7 : 1,
            child: const OptimusIcon(
              iconData: OptimusIcons.send_message,
              colorOption: OptimusColorOption.basic,
            ),
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
