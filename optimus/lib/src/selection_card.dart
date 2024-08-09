import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/radio/circle.dart';
import 'package:optimus/src/radio/state.dart';

enum OptimusSelectionCardVariant { vertical, horizontal }

enum OptimusSelectionCardBorderRadius { small, medium }

class OptimusSelectionCard extends StatefulWidget {
  const OptimusSelectionCard({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.isSelected = false,
    this.isEnabled = true,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final bool isSelected;
  final bool isEnabled;

  @override
  State<OptimusSelectionCard> createState() => _OptimusSelectionCardState();
}

class _OptimusSelectionCardState extends State<OptimusSelectionCard> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) => GestureWrapper(
        onHoverChanged: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        },
        onPressedChanged: (isPressed) {
          setState(() {
            _isPressed = isPressed;
          });
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.tokens
                  .borderInteractiveSecondaryDefault, // TODO(witwash): replace
              width: context.tokens.borderWidth150,
            ),
          ),
          child: Row(
            children: [
              RadioCircle(
                state: RadioState.basic,
                isSelected: widget.isSelected,
              ),
              OptimusTitleMedium(child: widget.title),
            ],
          ),
        ),
      );
}
