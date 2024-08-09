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
    this.variant = OptimusSelectionCardVariant.horizontal,
    this.borderRadius = OptimusSelectionCardBorderRadius.medium,
    this.isSelected = false,
    this.isEnabled = true,
  });

  final Widget title;
  final Widget? description;
  final Widget? trailing;
  final OptimusSelectionCardVariant variant;
  final OptimusSelectionCardBorderRadius borderRadius;
  final bool isSelected;
  final bool isEnabled;

  @override
  State<OptimusSelectionCard> createState() => _OptimusSelectionCardState();
}

class _OptimusSelectionCardState extends State<OptimusSelectionCard>
    with ThemeGetter {
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
            borderRadius:
                BorderRadius.all(widget.borderRadius.getBorderRadius(tokens)),
            border: Border.all(
              color: context.tokens
                  .borderInteractiveSecondaryDefault, // TODO(witwash): replace
              width: context.tokens.borderWidth150,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioCircle(
                state: RadioState.basic,
                isSelected: widget.isSelected,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OptimusTitleMedium(child: widget.title),
                  if (widget.description case final description?)
                    OptimusSubtitle(child: description),
                ],
              ),
              const Spacer(),
              if (widget.trailing case final trailing?) trailing,
            ],
          ),
        ),
      );
}

extension on OptimusSelectionCardBorderRadius {
  Radius getBorderRadius(OptimusTokens tokens) {
    switch (this) {
      case OptimusSelectionCardBorderRadius.small:
        return tokens.borderRadius100;
      case OptimusSelectionCardBorderRadius.medium:
        return tokens.borderRadius200;
    }
  }
}
