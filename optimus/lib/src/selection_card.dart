import 'package:flutter/widgets.dart';

enum OptimusSelectionCardVariant { vertical, horizontal }

enum OptimusSelectionCardBorderRadius { small, medium }

class OptimusSelectionCard extends StatelessWidget {
  const OptimusSelectionCard({
    super.key,
    required this.title,
    this.description,
    this.trailing,
    this.isSelected = false,
    this.isEnabled = true,
  });

  final String title;
  final String? description;
  final Widget? trailing;
  final bool isSelected;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Container();
}
