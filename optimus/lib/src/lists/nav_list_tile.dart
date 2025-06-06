import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/lists/base_list_tile.dart';

/// Lists are vertically organized groups of data. Optimized for reading
/// comprehension, a list consists of a single continuous column of rows, with
/// each row representing a list item (in some cases on bigger viewports it
/// could use a multi-column layout). [OptimusNavListTile] is meant to be
/// used an a tile, which contains some interactable element, e.g. tile which
/// leads to the new screen.
///
/// A list should be easily scannable, and any element of a list can be used to
/// anchor and align list item content. Scannability is improved when elements
/// (such as supporting visuals and headlines) are placed in consistent
/// locations across list items. It's not recommended to mix tiles with icon,
/// avatar or without any leading widget in the same list.
class OptimusNavListTile extends StatefulWidget {
  const OptimusNavListTile({
    super.key,
    required this.label,
    this.leading,
    this.rightDetail,
    this.isToggleVisible = false,
    this.isToggled = false,
    this.isChevronVisible = false,
    this.useHorizontalPadding = false,
    this.onTap,
    this.isEnabled = true,
    this.onTogglePressed,
    this.semanticLabel,
  });

  /// The label of the list tile.
  final Widget label;

  /// The leading widget of the list tile.
  final Widget? leading;

  /// The callback that is called when the list tile is tapped.
  final VoidCallback? onTap;

  /// Whether to use horizontal padding.
  final bool useHorizontalPadding;

  /// Whether the toggle is visible.
  final bool isToggleVisible;

  /// Whether the chevron is visible.
  final bool isChevronVisible;

  /// The right detail widget of the list tile.
  final Widget? rightDetail;

  /// Whether the toggle is toggled.
  final bool isToggled;

  /// The callback that is called when the toggle is pressed.
  final ValueChanged<bool>? onTogglePressed;

  /// Whether the tile is enabled.
  final bool isEnabled;

  final String? semanticLabel;

  @override
  State<OptimusNavListTile> createState() => _OptimusNavListTileState();
}

class _OptimusNavListTileState extends State<OptimusNavListTile>
    with ThemeGetter {
  final WidgetStatesController _controller = WidgetStatesController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusNavListTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      _controller.update(WidgetState.disabled, !widget.isEnabled);
    }
  }

  WidgetStateColor get _backgroundColor => WidgetStateColor.fromMap({
    WidgetState.disabled: Colors.transparent,
    WidgetState.pressed: tokens.backgroundInteractiveNeutralSubtleActive,
    WidgetState.hovered: tokens.backgroundInteractiveNeutralSubtleHover,
    WidgetState.any: tokens.backgroundInteractiveNeutralSubtleDefault,
  });

  void _handleHoverChanged(bool isHovered) {
    setState(() => _controller.update(WidgetState.hovered, isHovered));
  }

  void _handlePressedChanged(bool isPressed) {
    setState(() => _controller.update(WidgetState.pressed, isPressed));
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final foregroundColor =
        widget.isEnabled ? tokens.textStaticPrimary : tokens.textDisabled;
    final iconTheme = IconThemeData(color: foregroundColor);
    final contentPadding = EdgeInsets.only(right: tokens.spacing200);

    return IgnorePointer(
      ignoring: !widget.isEnabled,
      child: Semantics(
        label: widget.semanticLabel,
        role: SemanticsRole.listItem,
        child: GestureWrapper(
          onHoverChanged: _handleHoverChanged,
          onPressedChanged: _handlePressedChanged,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _backgroundColor.resolve(_controller.value),
            ),
            child: BaseListTile(
              onTap: widget.onTap,
              content: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:
                      widget.useHorizontalPadding
                          ? tokens.spacing200
                          : tokens.spacing0,
                ),
                child: Row(
                  children: [
                    //leading
                    if (widget.leading case final leading?)
                      Padding(
                        padding: contentPadding,
                        child: DefaultTextStyle.merge(
                          style: TextStyle(color: foregroundColor),
                          child: IconTheme.merge(
                            data: iconTheme,
                            child: leading,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: contentPadding,
                        child: DefaultTextStyle.merge(
                          child: widget.label,
                          style: tokens.bodyLarge.copyWith(
                            color:
                                widget.isEnabled
                                    ? tokens.textStaticPrimary
                                    : tokens.textDisabled,
                          ),
                        ),
                      ),
                    ),
                    if (widget.rightDetail case final rightDetail?)
                      Padding(
                        padding: contentPadding,
                        child: IconTheme.merge(
                          data: iconTheme,
                          child: rightDetail,
                        ),
                      ),
                    if (widget.isToggleVisible)
                      Padding(
                        padding: contentPadding,
                        child: OptimusToggle(
                          onChanged:
                              widget.isEnabled ? widget.onTogglePressed : null,
                          isChecked: widget.isToggled,
                        ),
                      ),
                    if (widget.isChevronVisible)
                      Icon(
                        OptimusIcons.chevron_right,
                        color: foregroundColor,
                        size: tokens.sizing300,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
