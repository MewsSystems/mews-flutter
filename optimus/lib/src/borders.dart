import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/theme/theme.dart';

@Deprecated('Use higher level components instead.')
class TileBorders extends StatelessWidget {
  const TileBorders({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              bottom: -1,
              left: -1,
              right: -1,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.isDark
                        ? theme.colors.neutral400
                        : theme.colors.neutral50,
                  ),
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
