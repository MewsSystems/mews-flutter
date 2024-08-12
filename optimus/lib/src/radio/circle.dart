import 'package:flutter/widgets.dart';
import 'package:optimus/src/radio/state.dart';
import 'package:optimus/src/theme/theme.dart';

class RadioCircle extends StatelessWidget {
  const RadioCircle({
    super.key,
    required this.state,
    required this.isSelected,
  });

  final RadioState state;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = tokens.sizing200;

    return Padding(
      // TODO(witwash): remove padding and move it up
      padding: EdgeInsets.only(
        top: tokens.spacing100,
        bottom: tokens.spacing100,
        right: tokens.spacing200,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: isSelected ? _selectedBorder : tokens.borderWidth150,
            color: state.borderColor(tokens, isSelected: isSelected),
          ),
          color: state.circleFillColor(tokens),
        ),
      ),
    );
  }
}

const double _selectedBorder = 6.0;
