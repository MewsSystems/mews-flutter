import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

typedef ResolveStyle = TextStyle Function(Breakpoint breakpoint);

enum OptimusTypographyColor { primary, secondary }

class OptimusTypography extends StatelessWidget {
  const OptimusTypography({
    super.key,
    required this.resolveStyle,
    this.color = OptimusTypographyColor.primary,
    required this.child,
    this.maxLines,
    this.align,
  });

  final ResolveStyle resolveStyle;
  final Widget child;
  final OptimusTypographyColor color;
  final int? maxLines;
  final TextAlign? align;

  Color _color(OptimusTokens tokens) => switch (color) {
        OptimusTypographyColor.primary => tokens.textStaticPrimary,
        OptimusTypographyColor.secondary => tokens.textStaticSecondary,
      };

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context).screenBreakpoint;
    final tokens = context.tokens;

    return DefaultTextStyle.merge(
      child: child,
      textAlign: align,
      maxLines: maxLines,
      style: resolveStyle(screenSize).copyWith(color: _color(tokens)),
    );
  }
}
