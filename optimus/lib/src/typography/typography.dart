import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/breakpoint.dart';

typedef ResolveStyle = TextStyle Function(Breakpoint);
enum OptimusTypographyColor { primary, secondary }

class OptimusTypography extends StatelessWidget {
  const OptimusTypography({
    Key key,
    @required this.resolveStyle,
    this.color = OptimusTypographyColor.primary,
    this.child,
  }) : super(key: key);

  final ResolveStyle resolveStyle;
  final Widget child;
  final OptimusTypographyColor color;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).screenBreakpoint;

    return DefaultTextStyle.merge(
      child: child,
      style: resolveStyle(screenSize).copyWith(color: _color),
    );
  }

  // ignore: missing_return
  Color get _color {
    switch (color) {
      case OptimusTypographyColor.primary:
        return OptimusColors.neutral900;
      case OptimusTypographyColor.secondary:
        return OptimusColors.neutral1000t64;
    }
  }
}
