import 'package:dfunc/dfunc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/checkbox/checkbox_tick.dart';
import 'package:optimus/src/dropdown/dropdown_size_data.dart';
import 'package:optimus/src/typography/typography.dart';

class BaseDropdownTile extends StatelessWidget {
  const BaseDropdownTile({
    super.key,
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.hasCheckbox = false,
  });

  final Widget title;
  final Widget? subtitle;
  final bool isSelected;
  final bool hasCheckbox;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final size = DropdownSizeData.of(context)?.size ?? OptimusWidgetSize.large;
    final tile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        OptimusTypography(
          resolveStyle: (_) => tokens.bodyMediumStrong,
          child: title,
        ),
        if (subtitle case final subtitle?)
          OptimusTypography(
            resolveStyle: (_) => tokens.bodySmall,
            color: OptimusTypographyColor.secondary,
            child: subtitle,
          ),
      ],
    );

    return Semantics(
      role:
          hasCheckbox ? SemanticsRole.menuItemCheckbox : SemanticsRole.menuItem,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing200,
          vertical: size.getVerticalPadding(tokens),
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? tokens.backgroundInteractiveSecondaryDefault : null,
          borderRadius: BorderRadius.all(tokens.borderRadius100),
        ),
        child:
            hasCheckbox
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IgnorePointer(
                      child: Padding(
                        padding: EdgeInsets.only(right: tokens.spacing200),
                        child: CheckboxTick(
                          isEnabled: true,
                          onChanged: ignore,
                          onTap: ignore,
                          isChecked: isSelected,
                        ),
                      ),
                    ),
                    Flexible(fit: FlexFit.loose, child: tile),
                  ],
                )
                : tile,
      ),
    );
  }
}

extension on OptimusWidgetSize {
  double getVerticalPadding(OptimusTokens tokens) => switch (this) {
    OptimusWidgetSize.small => tokens.spacing75,
    OptimusWidgetSize.medium => tokens.spacing100,
    OptimusWidgetSize.large ||
    OptimusWidgetSize.extraLarge => tokens.spacing150,
  };
}
