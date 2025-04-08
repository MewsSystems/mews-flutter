import 'package:flutter/widgets.dart';

class OptimusSkeleton extends StatelessWidget {
  const OptimusSkeleton({
    super.key,
    required this.child,
    required this.isLoading,
  });

  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => const Placeholder();
}
