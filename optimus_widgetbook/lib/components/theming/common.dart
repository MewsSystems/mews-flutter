import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class ColorBlock extends StatelessWidget {
  const ColorBlock(this.value, {super.key});

  final Color value;

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: value,
      border: Border.all(color: Colors.grey),
      borderRadius: const BorderRadius.all(Radius.circular(2)),
    ),
  );
}

class TextBlock extends StatelessWidget {
  const TextBlock(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: context.tokens.bodySmall);
}

class TokenDiff extends StatelessWidget {
  const TokenDiff({
    super.key,
    required this.label,
    required this.value,
    required this.originalValue,
  });

  final String label;
  final Widget value;
  final Widget originalValue;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        TextBlock(label),
        const SizedBox(width: 8.0),
        originalValue,
        const SizedBox(width: 8.0),
        Text('→', style: context.tokens.bodySmall),
        const SizedBox(width: 8.0),
        value,
      ],
    ),
  );
}
