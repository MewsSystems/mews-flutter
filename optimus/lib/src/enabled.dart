import 'package:flutter/widgets.dart';
import 'package:optimus/src/constants.dart';

class Enabled extends StatelessWidget {
  const Enabled({
    Key? key,
    required this.isEnabled,
    required this.child,
  }) : super(key: key);

  final bool isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
        child: IgnorePointer(
          ignoring: !isEnabled,
          child: child,
        ),
      );
}
