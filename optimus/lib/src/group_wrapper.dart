import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

class GroupWrapper extends StatelessWidget {
  const GroupWrapper({
    Key key,
    @required this.child,
    this.label,
    this.error,
  }) : super(key: key);

  final Widget child;
  final String label;
  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label.isNotEmpty)
          OptimusLabelSmall(
            child: Text(
              label,
              style: TextStyle(color: _textColor(theme)),
            ),
          ),
        child,
        if (error != null && error.isNotEmpty)
          OptimusCaption(
            child: Text(
              error,
              style: TextStyle(color: theme.colors.danger500),
            ),
          ),
      ],
    );
  }

  Color _textColor(OptimusThemeData theme) => theme.isDark
      ? OptimusDarkColors.neutral0t64
      : OptimusLightColors.neutral1000t64;
}
