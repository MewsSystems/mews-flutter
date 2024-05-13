import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldError extends StatelessWidget {
  const OptimusFieldError({
    super.key,
    required this.error,
    this.isEnabled = true,
  });

  final String error;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final color = isEnabled ? tokens.textAlertDanger : tokens.textDisabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: tokens.spacing150),
          child: Icon(
            OptimusIcons.error_circle,
            size: tokens.sizing200,
            color: color,
          ),
        ),
        Flexible(
          child: OptimusCaption(
            child: Text(
              error,
              style: TextStyle(color: color),
            ),
          ),
        ),
      ],
    );
  }
}
