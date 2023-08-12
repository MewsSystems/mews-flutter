import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

class OptimusFieldError extends StatelessWidget {
  const OptimusFieldError({
    super.key,
    required this.error,
  });

  final String error;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: spacing150),
            child: Icon(
              OptimusIcons.error_circle,
              size: 16,
              color: context.tokens.textAlertDanger,
            ),
          ),
          OptimusCaption(
            child: Text(
              error,
              style: TextStyle(
                color: context.tokens.textAlertDanger,
              ),
            ),
          ),
        ],
      );
}
