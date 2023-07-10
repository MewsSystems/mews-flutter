import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/colors/data_colors.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/presets.dart';

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

  @override
  Widget build(BuildContext context) =>
      _Tag(text: text, colorOption: colorOption);
}

/// Tags are used to highlight an item’s status or make it easier to recognize
/// certain items in data-dense content.
///
/// Be wary of using multiple tags on one item, as it could cause visual noise.
/// Interactive tags are for user control over specific elements. They can be
/// used for removing items from multiselect controls or other add-purpose
/// components.
class OptimusInteractiveTag extends StatelessWidget {
  const OptimusInteractiveTag({
    super.key,
    required this.text,
    this.onRemoved,
  });

  /// The text to display in the tag.
  final String text;

  /// Callback that will be triggered when user clicks on cross icon. It's
  /// the responsibility of the caller to actually remove the tag.
  final VoidCallback? onRemoved;

  bool get _isEnabled => onRemoved != null;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: _isEnabled ? OpacityValue.enabled : OpacityValue.disabled,
        child: IgnorePointer(
          ignoring: !_isEnabled,
          child: _Tag(text: text, onRemoved: onRemoved ?? () {}),
        ),
      );
}

class _Tag extends StatefulWidget {
  const _Tag({
    required this.text,
    this.colorOption = OptimusColorOption.basic,
    this.onRemoved,
  });

  final String text;
  final OptimusColorOption colorOption;
  final VoidCallback? onRemoved;

  @override
  _TagState createState() => _TagState();
}

class _TagState extends State<_Tag> with ThemeGetter {
  Widget get _icon => GestureDetector(
        onTap: () => widget.onRemoved?.call(),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            OptimusIcons.cross_close,
            color: theme.colors.neutral500,
            size: 12,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: widget.onRemoved != null ? theme.colors.neutral50 : _tagColor,
          border: Border.all(color: _borderColor),
          borderRadius: const BorderRadius.all(borderRadius100),
        ),
        padding: _tagPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.onRemoved != null
                    ? widget.text
                    : widget.text.toUpperCase(),
                style: widget.onRemoved != null
                    ? preset200s.copyWith(
                        height: 1.1,
                        // TODO(VG): can be changed when final dark theme design
                        //  is ready.
                        color: theme.colors.neutral1000,
                      )
                    // Doesn't match any typography component
                    : baseTextStyle.copyWith(
                        color: _textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.onRemoved != null) _icon,
          ],
        ),
      );

  EdgeInsets get _tagPadding => widget.onRemoved != null
      ? const EdgeInsets.only(top: 1.5, bottom: 1.5, left: 8)
      : const EdgeInsets.symmetric(vertical: 2, horizontal: 8);

  Color get _tagColor => switch (widget.colorOption) {
        OptimusColorOption.basic =>
          // TODO(VG): can be changed when final dark theme design is ready.
          theme.isDark ? theme.colors.neutral300 : theme.colors.neutral50,
        OptimusColorOption.plain =>
          theme.isDark ? theme.colors.neutral200 : theme.colors.neutral25,
        OptimusColorOption.primary =>
          theme.isDark ? theme.colors.primary500t32 : theme.colors.primary50,
        OptimusColorOption.success =>
          theme.isDark ? theme.colors.success500t32 : theme.colors.success50,
        OptimusColorOption.info =>
          theme.isDark ? theme.colors.info500t32 : theme.colors.info50,
        OptimusColorOption.warning =>
          theme.isDark ? theme.colors.warning500t32 : theme.colors.warning50,
        OptimusColorOption.danger =>
          theme.isDark ? theme.colors.danger500t32 : theme.colors.danger50,
      };

  Color get _borderColor => switch (widget.colorOption) {
        OptimusColorOption.basic =>
          theme.isDark ? theme.colors.neutral100 : theme.colors.neutral700,
        // TODO(VG): can be changed when final dark theme design is ready.
        OptimusColorOption.plain =>
          theme.isDark ? theme.colors.neutral50 : theme.colors.neutral200,
        OptimusColorOption.primary =>
          theme.isDark ? theme.colors.primary500 : theme.colors.primary200,
        OptimusColorOption.success =>
          theme.isDark ? theme.colors.success500 : theme.colors.success300,
        OptimusColorOption.info =>
          theme.isDark ? theme.colors.info500 : theme.colors.info300,
        OptimusColorOption.warning =>
          theme.isDark ? theme.colors.warning500 : theme.colors.warning300,
        OptimusColorOption.danger =>
          theme.isDark ? theme.colors.danger500 : theme.colors.danger200,
      };

  Color get _textColor {
    // TODO(VG): can be changed when final dark theme design is ready.
    if (theme.isDark) return theme.colors.neutral50;

    return switch (widget.colorOption) {
      OptimusColorOption.primary => theme.colors.primary900,
      OptimusColorOption.success => theme.colors.success900,
      OptimusColorOption.info => theme.colors.info900,
      OptimusColorOption.danger => theme.colors.danger900,
      OptimusColorOption.basic ||
      OptimusColorOption.plain ||
      OptimusColorOption.warning =>
        theme.colors.neutral1000,
    };
  }
}

enum OptimusCategoricalColorOption {
  denim,
  lavender,
  lime,
  mustard,
  ruby,
  tangerine
}

extension on OptimusCategoricalColorOption {
  Color borderColor(OptimusThemeData theme) => switch (this) {
        OptimusCategoricalColorOption.denim => theme.isDark
            ? OptimusDataColors.denim500
            : OptimusDataColors.denim200,
        OptimusCategoricalColorOption.lavender => theme.isDark
            ? OptimusDataColors.lavender500
            : OptimusDataColors.lavender200,
        OptimusCategoricalColorOption.lime =>
          theme.isDark ? OptimusDataColors.lime500 : OptimusDataColors.lime200,
        OptimusCategoricalColorOption.mustard => theme.isDark
            ? OptimusDataColors.mustard500
            : OptimusDataColors.mustard200,
        OptimusCategoricalColorOption.ruby =>
          theme.isDark ? OptimusDataColors.ruby500 : OptimusDataColors.ruby200,
        OptimusCategoricalColorOption.tangerine => theme.isDark
            ? OptimusDataColors.tangerine500
            : OptimusDataColors.tangerine200,
      };

  Color tagColor(OptimusThemeData theme) => switch (this) {
        OptimusCategoricalColorOption.denim => theme.isDark
            ? OptimusDataColors.denim500t32
            : OptimusDataColors.denim50,
        OptimusCategoricalColorOption.lavender => theme.isDark
            ? OptimusDataColors.lavender500t32
            : OptimusDataColors.lavender50,
        OptimusCategoricalColorOption.lime => theme.isDark
            ? OptimusDataColors.lime500t32
            : OptimusDataColors.lime50,
        OptimusCategoricalColorOption.mustard => theme.isDark
            ? OptimusDataColors.mustard500t32
            : OptimusDataColors.mustard50,
        OptimusCategoricalColorOption.ruby => theme.isDark
            ? OptimusDataColors.ruby500t32
            : OptimusDataColors.ruby50,
        OptimusCategoricalColorOption.tangerine => theme.isDark
            ? OptimusDataColors.tangerine500t32
            : OptimusDataColors.tangerine50,
      };

  Color textColor(OptimusThemeData theme) {
    if (theme.isDark) return theme.colors.neutral50;

    return switch (this) {
      OptimusCategoricalColorOption.denim => OptimusDataColors.denim900,
      OptimusCategoricalColorOption.lavender => OptimusDataColors.lavender900,
      OptimusCategoricalColorOption.lime => OptimusDataColors.lime900,
      OptimusCategoricalColorOption.ruby => OptimusDataColors.ruby900,
      OptimusCategoricalColorOption.mustard ||
      OptimusCategoricalColorOption.tangerine =>
        theme.colors.neutral1000,
    };
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
class OptimusCategoricalTag extends StatelessWidget {
  const OptimusCategoricalTag({
    super.key,
    required this.text,
    required this.colorOption,
  });

  final String text;
  final OptimusCategoricalColorOption colorOption;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colorOption.tagColor(theme),
        border: Border.all(color: colorOption.borderColor(theme)),
        borderRadius: const BorderRadius.all(borderRadius100),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Text(
        text.toUpperCase(),
        style: baseTextStyle.copyWith(
          color: colorOption.textColor(theme),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
