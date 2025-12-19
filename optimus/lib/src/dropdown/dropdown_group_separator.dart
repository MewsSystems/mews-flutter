import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusDropdownGroupSeparator extends StatelessWidget {
  const OptimusDropdownGroupSeparator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: .symmetric(
        vertical: tokens.spacing25,
        horizontal: tokens.spacing200,
      ),
      child: DefaultTextStyle.merge(
        style: tokens.bodyLarge.copyWith(color: tokens.textStaticTertiary),
        child: child,
      ),
    );
  }
}
