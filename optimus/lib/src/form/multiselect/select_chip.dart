import 'package:flutter/widgets.dart';
import 'package:optimus/src/chip.dart';

class MultiselectChip extends StatelessWidget {
  const MultiselectChip({
    super.key,
    this.isEnabled = true,
    required this.text,
    this.onRemoved,
    this.onTap,
  });

  final bool isEnabled;
  final String text;
  final VoidCallback? onRemoved;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => OptimusChip(
        onRemoved: onRemoved,
        onTap: onTap,
        isEnabled: isEnabled,
        child: Text(
          text,
          style: const TextStyle(decoration: TextDecoration.underline),
        ),
      );
}
