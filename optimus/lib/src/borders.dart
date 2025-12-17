import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

@Deprecated('Use higher level components instead.')
class TileBorders extends StatelessWidget {
  @Deprecated('Use higher level components instead.')
  const TileBorders({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Stack(
      clipBehavior: .none,
      children: <Widget>[
        Positioned(
          bottom: -1,
          left: -1,
          right: -1,
          top: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: .all(color: theme.tokens.borderStaticSecondary),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
