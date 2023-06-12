import 'package:flutter/material.dart';

// TODO(VG): change loading indicator according to design (when ready)
class OptimusProgressSpinner extends StatelessWidget {
  const OptimusProgressSpinner({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(right: 6),
        child: SizedBox(
          width: 14,
          height: 14,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
}
