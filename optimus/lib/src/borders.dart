import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

@Deprecated('Use higher level components instead.')
class TileBorders extends StatelessWidget {
  const TileBorders({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              bottom: -1,
              left: -1,
              right: -1,
              top: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                ),
              ),
            ),
            child,
          ],
        ),
      ],
    );
  }
}
