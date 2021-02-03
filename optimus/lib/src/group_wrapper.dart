import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/styles.dart';

class GroupWrapper extends StatelessWidget {
  const GroupWrapper({
    Key key,
    @required this.child,
    this.label,
    this.error,
  }) : super(key: key);

  final Widget child;
  final String label;
  final String error;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null && label.isNotEmpty)
            Text(
              label,
              style: preset100s.copyWith(color: OptimusColors.basic900t64),
            ),
          child,
          if (error != null && error.isNotEmpty)
            Text(
              error,
              style: preset100m.copyWith(color: OptimusColors.danger500),
            ),
        ],
      );
}
