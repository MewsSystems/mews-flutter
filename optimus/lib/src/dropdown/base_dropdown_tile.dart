import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/checkbox/checkbox_tick.dart';
import 'package:optimus/src/typography/presets.dart';
import 'package:optimus/src/typography/typography.dart';

class BaseDropdownTile extends StatelessWidget {
  const BaseDropdownTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isSelected,
  });

  final Widget title;
  final Widget? subtitle;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    final tile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        OptimusTypography(
          resolveStyle: (_) => preset300s,
          child: title,
        ),
        if (subtitle case final subtitle?)
          OptimusTypography(
            resolveStyle: (_) => preset200s,
            color: OptimusTypographyColor.secondary,
            child: subtitle,
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: spacing200,
        vertical: spacing150,
      ),
      child: isSelected != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: spacing100),
                  child: CheckboxTick(
                    isEnabled: true,
                    onChanged: (_) {},
                    onTap: () {},
                    isChecked: isSelected,
                  ),
                ),
                Flexible(fit: FlexFit.loose, child: tile),
              ],
            )
          : tile,
    );
  }
}
