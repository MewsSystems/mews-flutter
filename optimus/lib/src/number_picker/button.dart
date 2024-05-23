import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class NumberPickerButton extends StatelessWidget {
  const NumberPickerButton({
    super.key,
    required this.iconData,
    this.onPressed,
  });

  final IconData iconData;
  final VoidCallback? onPressed;

  bool get _isEnabled => onPressed != null;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return OptimusEnabled(
      isEnabled: _isEnabled,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          iconData,
          color: _isEnabled ? tokens.textStaticPrimary : tokens.textDisabled,
          size: tokens.sizing300,
        ),
      ),
    );
  }
}
