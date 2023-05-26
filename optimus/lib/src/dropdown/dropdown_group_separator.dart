
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/presets.dart';

class OptimusDropdownGroupSeparator extends StatelessWidget {
  const OptimusDropdownGroupSeparator({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: spacing25,
          horizontal: spacing200,
        ),
        child: DefaultTextStyle.merge(
          style: preset300r.copyWith(
            color: OptimusTheme.of(context).colors.neutral50,
          ),
          child: child,
        ),
      );
}
