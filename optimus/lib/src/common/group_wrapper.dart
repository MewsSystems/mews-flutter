import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/field_error.dart';
import 'package:optimus/src/common/field_label.dart';

class GroupWrapper extends StatelessWidget {
  const GroupWrapper({
    Key? key,
    required this.child,
    this.label,
    this.error,
    this.isRequired = false,
  }) : super(key: key);

  final Widget child;
  final String? label;
  final String? error;
  final bool isRequired;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null && label!.isNotEmpty)
            OptimusFieldLabel(
              label: label!,
              isRequired: isRequired,
            ),
          child,
          if (error != null && error!.isNotEmpty)
            OptimusFieldError(error: error!),
        ],
      );
}
