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
    final theme = OptimusTheme.of(context);

    return OptimusEnabled(
      isEnabled: _isEnabled,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          iconData,
          color: theme.isDark // TODO(witwash): replace with tokens
              ? theme.colors.neutral0
              : theme.colors.neutral1000t64,
          size: context.tokens.sizing300,
        ),
      ),
    );
  }
}
