import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/theme/theme.dart';

class OptimusFieldError extends StatelessWidget {
  const OptimusFieldError({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return OptimusCaption(
      child: Text(error, style: TextStyle(color: theme.colors.danger500)),
    );
  }
}
