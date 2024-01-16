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
    final color = isEnabled
        ? context.tokens.textAlertDanger
        : context.tokens.textDisabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: context.tokens.spacing150),
          child: Icon(OptimusIcons.error_circle, size: 16, color: color),
        ),
        OptimusCaption(child: Text(error, style: TextStyle(color: color))),
      ],
    );
  }
}
