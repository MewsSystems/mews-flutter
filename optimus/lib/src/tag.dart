import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/border_radius.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/constants.dart';
import 'package:optimus/src/typography/styles.dart';

enum TagVersion {
  /// Use the bold version to highlight important items onscreen.
  bold,

  /// Use the subtle version, if you want express an item’s status in heavy, data-dense scenarios
  /// (like in long tables with lot of tags)
  subtle,
}

/// Tags are used to highlight an item’s status or make it easier to recognize certain items in data-dense content.
/// Be wary of using multiple tags on one item, as it could cause visual noise.
///
/// Non-interactive tags are used to highlight an item’s status or make it easier to recognize certain items
/// in data-dense content. You can use tags in tables, forms, and cards.
class OptimusTag extends StatelessWidget {
  const OptimusTag({
    Key key,
    @required this.text,
    this.colorOption = OptimusColorOption.basic,
    this.version = TagVersion.bold,
  }) : super(key: key);

  /// The text to display in the tag.
  final String text;

  /// Controls color of the tag. Use-cases:
  /// - [OptimusColorOption.basic] – highlight general status or state of item;
  /// - [OptimusColorOption.primary] – highlight primary item, in progress, or current item;
  /// - [OptimusColorOption.success] – highlight success state of item;
  /// - [OptimusColorOption.danger] – highlight problematic or error item;
  /// - [OptimusColorOption.warning] – highlight item that requires attention.
  final OptimusColorOption colorOption;

  /// The version of the tag.
  final TagVersion version;

  @override
  Widget build(BuildContext context) => _Tag(text: text, colorOption: colorOption, version: version);
}

/// Tags are used to highlight an item’s status or make it easier to recognize certain items in data-dense content.
/// Be wary of using multiple tags on one item, as it could cause visual noise.
///
/// Interactive tags are for user control over specific elements. They can be used for removing items from
/// multiselect controls or other add-purpose components.
class OptimusInteractiveTag extends StatelessWidget {
  const OptimusInteractiveTag({
    Key key,
    @required this.text,
    this.onRemoved,
  }) : super(key: key);

  /// The text to display in the tag.
  final String text;

  /// Callback that will be triggered when user clicks on cross icon. It's the responsibility of the caller
  /// to actually remove the tag.
  final VoidCallback onRemoved;

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

class _Tag extends StatelessWidget {
  const _Tag({
    Key key,
    @required this.text,
    this.colorOption = OptimusColorOption.basic,
    this.version = TagVersion.bold,
    this.onRemoved,
  }) : super(key: key);

  final String text;
  final OptimusColorOption colorOption;
  final TagVersion version;
  final VoidCallback onRemoved;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: onRemoved != null ? OptimusColors.basic50 : _tagColor,
          borderRadius: const BorderRadius.all(borderRadius25),
        ),
        padding: _tagPadding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              onRemoved != null ? text : text.toUpperCase(),
              style: onRemoved != null
                  ? preset200m.copyWith(height: 1.1)
                  // Doesn't match any typography component
                  : baseTextStyle.copyWith(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
            ),
            if (onRemoved != null) _buildIcon(onRemoved: onRemoved),
          ],
        ),
      );

  EdgeInsets get _tagPadding => onRemoved != null
      ? const EdgeInsets.only(top: 1.5, bottom: 1.5, left: 8)
      : const EdgeInsets.symmetric(vertical: 1, horizontal: 8);

  // ignore: missing_return
  Color get _tagColor {
    switch (version) {
      case TagVersion.bold:
        return _tagBoldColor;
      case TagVersion.subtle:
        return _tagSubtleColor;
    }
  }

  // ignore: missing_return
  Color get _tagBoldColor {
    switch (colorOption) {
      case OptimusColorOption.basic:
        return OptimusColors.basic500;
      case OptimusColorOption.primary:
        return OptimusColors.primary500;
      case OptimusColorOption.success:
        return OptimusColors.success500;
      case OptimusColorOption.warning:
        return OptimusColors.warning500;
      case OptimusColorOption.danger:
        return OptimusColors.danger500;
    }
  }

  // ignore: missing_return
  Color get _tagSubtleColor {
    switch (colorOption) {
      case OptimusColorOption.basic:
        return OptimusColors.basic50;
      case OptimusColorOption.primary:
        return OptimusColors.primary50;
      case OptimusColorOption.success:
        return OptimusColors.success50;
      case OptimusColorOption.warning:
        return OptimusColors.warning50;
      case OptimusColorOption.danger:
        return OptimusColors.danger50;
    }
  }

  // ignore: missing_return
  Color get _textColor {
    switch (version) {
      case TagVersion.bold:
        return _textBoldColor;
      case TagVersion.subtle:
        return _textSubtleColor;
    }
  }

  Color get _textBoldColor {
    switch (colorOption) {
      case OptimusColorOption.warning:
        return OptimusColors.basic900;
      default:
        return OptimusColors.basic0;
    }
  }

  // ignore: missing_return
  Color get _textSubtleColor {
    switch (colorOption) {
      case OptimusColorOption.primary:
        return OptimusColors.primary900;
      case OptimusColorOption.success:
        return OptimusColors.success900;
      case OptimusColorOption.danger:
        return OptimusColors.danger900;
      case OptimusColorOption.basic:
      case OptimusColorOption.warning:
        return OptimusColors.basic900;
    }
  }
}

Widget _buildIcon({VoidCallback onRemoved}) => GestureDetector(
      onTap: () => onRemoved?.call(),
      child: const Padding(
        padding: EdgeInsets.all(6),
        child: Icon(OptimusIcons.cross_close, color: OptimusColors.basic500, size: 12),
      ),
    );
