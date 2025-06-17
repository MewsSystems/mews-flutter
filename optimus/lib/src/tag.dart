import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/text_scaling.dart';

/// Tags are used to highlight an item’s status or make it easier to recognize
/// certain items in data-dense content.
/// For system-specific feedback with semantic significance use OptimusTag.
/// For data-dense content, where representation isn't carrying semantic
/// significance use OptimusCategoricalTag.
///
/// Be wary of using multiple tags on one item, as it could cause visual noise.
/// Non-interactive tags are used to highlight an item’s status or make it
/// easier to recognize certain items in data-dense content. You can use tags
/// in tables, forms, and cards.
class OptimusTag extends StatelessWidget {
  const OptimusTag({
    super.key,
    required this.text,
    this.colorOption = OptimusColorOption.basic,
    this.leadingIcon,
    this.trailingIcon,
    this.isOutlined = false,
  });

  /// The text to display in the tag.
  final String text;

  /// Controls color of the tag. Use-cases:
  /// - [OptimusColorOption.basic] – highlight general status or state of item;
  /// - [OptimusColorOption.plain] - highlight general status or state of item;
  /// - [OptimusColorOption.primary] – highlight primary item, in progress, or
  ///   current item;
  /// - [OptimusColorOption.success] – highlight success state of item;
  /// - [OptimusColorOption.info] - highlighting informational/helpful item;
  /// - [OptimusColorOption.warning] – highlight item that requires attention.
  /// - [OptimusColorOption.danger] – highlight problematic or error item;
  final OptimusColorOption colorOption;

  /// Whether the tag should use the outlined style.
  final bool isOutlined;

  /// Optional leading icon of the tag.
  final IconData? leadingIcon;

  /// Optional trailing icon of the tag.
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return _Tag(
      text: text,
      backgroundColor: colorOption.backgroundColor(tokens),
      foregroundColor: colorOption.foregroundColor(tokens),
      borderColor: colorOption.borderColor(tokens),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      isOutlined: isOutlined,
    );
  }
}

/// Color options are designed so they won't carry any semantic meaning. Could
/// be used in any case when displaying categorical data.
///
/// [OptimusCategoricalColorOption.denim] - Denim Blue
/// [OptimusCategoricalColorOption.lavender] - Lavender Purple
/// [OptimusCategoricalColorOption.lime] - Lime Green
/// [OptimusCategoricalColorOption.mustard] - Mustard Yellow
/// [OptimusCategoricalColorOption.ruby] - Ruby Red
/// [OptimusCategoricalColorOption.tangerine] - Tangerine Orange
enum OptimusCategoricalColorOption {
  denim,
  lavender,
  lime,
  mustard,
  ruby,
  tangerine,
}

/// Tags that are meant to help arrange information into distinct categories.
/// Color option does not carry any semantic meaning. Color could be swapped
/// without causing any effect on the tag's meaning.
class OptimusCategoricalTag extends StatelessWidget {
  const OptimusCategoricalTag({
    super.key,
    required this.text,
    required this.colorOption,
    this.leadingIcon,
    this.trailingIcon,
    this.isOutlined = false,
  });

  /// Text of the tag.
  final String text;

  /// Categorical color option.
  final OptimusCategoricalColorOption colorOption;

  /// Optional leading icon.
  final IconData? leadingIcon;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Whether to use outlined tag style.
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return _Tag(
      text: text,
      backgroundColor: colorOption.backgroundColor(tokens),
      foregroundColor: colorOption.foregroundColor(tokens),
      borderColor: colorOption.borderColor(tokens),
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      isOutlined: isOutlined,
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    this.leadingIcon,
    this.trailingIcon,
    this.isOutlined = false,
  });

  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      decoration: BoxDecoration(
        color: isOutlined ? tokens.backgroundStaticFlat : backgroundColor,
        border:
            isOutlined
                ? Border.all(
                  color: borderColor,
                  width: tokens.borderWidth150,
                  style: BorderStyle.solid,
                )
                : null,
        borderRadius: BorderRadius.all(tokens.borderRadius50),
      ),
      padding: EdgeInsets.symmetric(horizontal: tokens.spacing100),
      height: tokens.sizing300.toScaled(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leadingIcon != null)
            Padding(
              padding: EdgeInsets.only(right: tokens.spacing50),
              child: Icon(
                leadingIcon,
                color: foregroundColor,
                size: tokens.sizing200.toScaled(context),
              ),
            ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: tokens.sizing1300.toScaled(context),
            ),
            child: Text(
              text,
              style: tokens.bodyMedium.copyWith(color: foregroundColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (trailingIcon != null)
            Padding(
              padding: EdgeInsets.only(left: tokens.spacing50),
              child: Icon(
                trailingIcon,
                color: foregroundColor,
                size: tokens.sizing200.toScaled(context),
              ),
            ),
        ],
      ),
    );
  }
}

extension on OptimusColorOption {
  Color backgroundColor(OptimusTokens tokens) => switch (this) {
    OptimusColorOption.basic => tokens.legacyTagBackgroundBasicBold,
    OptimusColorOption.plain => tokens.backgroundAlertBasicSecondary,
    OptimusColorOption.primary => tokens.legacyTagBackgroundPrimary,
    OptimusColorOption.success => tokens.backgroundAlertSuccessSecondary,
    OptimusColorOption.info => tokens.backgroundAlertInfoSecondary,
    OptimusColorOption.warning => tokens.backgroundAlertWarningSecondary,
    OptimusColorOption.danger => tokens.backgroundAlertDangerSecondary,
  };

  Color borderColor(OptimusTokens tokens) => switch (this) {
    OptimusColorOption.basic => tokens.legacyTagBorderBasicBold,
    OptimusColorOption.plain => tokens.borderAlertBasic,
    OptimusColorOption.primary => tokens.legacyTagBorderPrimary,
    OptimusColorOption.success => tokens.borderAlertSuccess,
    OptimusColorOption.info => tokens.borderAlertInfo,
    OptimusColorOption.warning => tokens.borderAlertWarning,
    OptimusColorOption.danger => tokens.borderAlertDanger,
  };

  Color foregroundColor(OptimusTokens tokens) => switch (this) {
    OptimusColorOption.primary => tokens.legacyTagTextPrimary,
    OptimusColorOption.success => tokens.textAlertSuccess,
    OptimusColorOption.info => tokens.textAlertInfo,
    OptimusColorOption.danger => tokens.textAlertDanger,
    OptimusColorOption.basic => tokens.legacyTagTextBasicBold,
    OptimusColorOption.plain => tokens.textAlertBasic,
    OptimusColorOption.warning => tokens.textAlertWarning,
  };
}

extension on OptimusCategoricalColorOption {
  Color borderColor(OptimusTokens tokens) => switch (this) {
    OptimusCategoricalColorOption.denim => tokens.legacyTagBorderDenim,
    OptimusCategoricalColorOption.lavender => tokens.legacyTagBorderLavender,
    OptimusCategoricalColorOption.lime => tokens.legacyTagBorderLime,
    OptimusCategoricalColorOption.mustard => tokens.legacyTagBorderMustard,
    OptimusCategoricalColorOption.ruby => tokens.legacyTagBorderRuby,
    OptimusCategoricalColorOption.tangerine => tokens.legacyTagBorderTangerine,
  };

  Color backgroundColor(OptimusTokens tokens) => switch (this) {
    OptimusCategoricalColorOption.denim => tokens.legacyTagBackgroundDenim,
    OptimusCategoricalColorOption.lavender =>
      tokens.legacyTagBackgroundLavender,
    OptimusCategoricalColorOption.lime => tokens.legacyTagBackgroundLime,
    OptimusCategoricalColorOption.mustard => tokens.legacyTagBackgroundMustard,
    OptimusCategoricalColorOption.ruby => tokens.legacyTagBackgroundRuby,
    OptimusCategoricalColorOption.tangerine =>
      tokens.legacyTagBackgroundTangerine,
  };

  Color foregroundColor(OptimusTokens tokens) => switch (this) {
    OptimusCategoricalColorOption.denim => tokens.legacyTagTextDenim,
    OptimusCategoricalColorOption.lavender => tokens.legacyTagTextLavender,
    OptimusCategoricalColorOption.lime => tokens.legacyTagTextLime,
    OptimusCategoricalColorOption.ruby => tokens.legacyTagTextRuby,
    OptimusCategoricalColorOption.mustard => tokens.legacyTagTextMustard,
    OptimusCategoricalColorOption.tangerine => tokens.legacyTagTextTangerine,
  };
}
