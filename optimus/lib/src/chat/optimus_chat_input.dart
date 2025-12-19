import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

/// A chat input field that allows users to type and send messages.
/// It includes a text input area and a send button.
/// Send button is enabled only when there is text in the input field.
/// The input field supports multiple lines and has a maximum height of 4 lines.
class OptimusChatInput extends StatefulWidget {
  const OptimusChatInput({
    super.key,
    required this.onSendPressed,
    this.semanticLabel,
  });

  /// Callback function that is called when the send button is pressed.
  final ValueChanged<String> onSendPressed;

  /// Optional semantic label for the input field. It is recommended to
  /// provide a semantic label for accessibility purposes. We suggest
  /// using localized strings for the label.
  final String? semanticLabel;

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
    semanticsLabel: widget.semanticLabel,
    controller: _controller,
    maxLines: 4,
    minLines: 1,
    trailing: OptimusEnabled(
      isEnabled: _isSendEnabled,
      child: GestureDetector(
        onTap: _handleTap,
        child: const OptimusIcon(
          iconData: OptimusIcons.send_message,
          colorOption: .basic,
        ),
      ),
    ),
  );
}
