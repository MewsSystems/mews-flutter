import 'package:flutter/widgets.dart';
import 'package:optimus/src/constants.dart';

class OptimusEnabled extends StatelessWidget {
  const OptimusEnabled({
    super.key,
    required this.isEnabled,
    required this.child,
  });

  final bool isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) => Opacity(
    opacity: isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
    child: IgnorePointer(ignoring: !isEnabled, child: child),
  );
}
