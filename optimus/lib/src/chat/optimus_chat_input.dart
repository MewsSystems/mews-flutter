import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusChatInput extends StatefulWidget {
  const OptimusChatInput({super.key, required this.onSendPressed});

  final ValueChanged<String> onSendPressed;

  @override
  State<OptimusChatInput> createState() => _OptimusChatInputState();
}

class _OptimusChatInputState extends State<OptimusChatInput> {
  final _controller = TextEditingController();

  bool get _isSendEnabled => _controller.value.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleControllerChanged);
  }

  void _handleControllerChanged() => setState(() {});

  void _handleTap() {
    widget.onSendPressed(_controller.text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_handleControllerChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => OptimusInputField(
        controller: _controller,
        maxLines: 4,
        minLines: 1,
        trailing: OptimusEnabled(
          isEnabled: _isSendEnabled,
          child: GestureDetector(
            onTap: _handleTap,
            child: const OptimusIcon(
              iconData: OptimusIcons.send_message,
              colorOption: OptimusIconColorOption.basic,
            ),
          ),
        ),
      );
}
