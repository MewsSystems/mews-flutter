import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/breakpoint.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/theme/theme_data.dart';

typedef ResolveStyle = TextStyle Function(Breakpoint);
enum OptimusTypographyColor { primary, secondary }

class OptimusTypography extends StatelessWidget {
  const OptimusTypography({
    Key? key,
    required this.resolveStyle,
    this.color = OptimusTypographyColor.primary,
    required this.child,
  }) : super(key: key);

  final ResolveStyle resolveStyle;
  final Widget child;
  final OptimusTypographyColor color;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).screenBreakpoint;
    final theme = OptimusTheme.of(context);

    return DefaultTextStyle.merge(
      child: child,
      style: resolveStyle(screenSize).copyWith(color: _color(theme)),
    );
  }

  // TODO(VG): can be changed when final dark theme design is ready.
  // ignore: missing_return
  Color _color(OptimusThemeData theme) {
    switch (color) {
      case OptimusTypographyColor.primary:
        return theme.isDark
            ? theme.colors.invertedTextColor
            : theme.colors.defaultTextColor;
      case OptimusTypographyColor.secondary:
        return theme.colors.secondaryTextColor;
    }
  }
}
