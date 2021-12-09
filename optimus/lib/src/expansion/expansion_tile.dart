import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// Based on flutter/lib/src/material/expansion_tile.dart
class OptimusExpansionTile extends StatefulWidget {
  /// Creates a single-line [ListTile] with a trailing button that expands or
  /// collapses the tile to reveal or hide the [children]. The
  /// [initiallyExpanded] property must be non-null.
  const OptimusExpansionTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.hasBorders = true,
    this.actionsWidth = 0,
    this.slidableActions = const <Widget>[],
  }) : super(key: key);

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  final Widget? leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// A widget to display instead of a rotating arrow icon.
  final Widget? trailing;

  /// Specifies if the list tile is initially expanded (true)
  /// or collapsed (false, the default).
  final bool initiallyExpanded;

  /// Borders of the inner [OptimusSlidable] widget
  final bool hasBorders;

  /// Width of the inner slidable actions in [OptimusSlidable] widget
  final double actionsWidth;

  /// List of actions on list tile left swipe.
  final List<Widget> slidableActions;

  @override
  _OptimusExpansionTileState createState() => _OptimusExpansionTileState();
}

class _OptimusExpansionTileState extends State<OptimusExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = (PageStorage.of(context)?.readState(context) ??
        widget.initiallyExpanded) as bool;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final theme = OptimusTheme.of(context);
    final textColor =
        theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTileTheme.merge(
          iconColor: textColor,
          textColor: textColor,
          child: widget.slidableActions.isEmpty
              ? _buildListTile()
              : _buildSlidable(widget.slidableActions, _buildListTile()),
        ),
        ClipRect(
          child: Align(heightFactor: _heightFactor.value, child: child),
        ),
      ],
    );
  }

  Widget _buildListTile() {
    final tile = ListTile(
      onTap: _handleTap,
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: widget.trailing ??
          RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.expand_more),
          ),
    );

    return tile;
  }

  Widget _buildSlidable(List<Widget> actions, Widget child) => OptimusSlidable(
        actions: actions,
        hasBorders: widget.hasBorders,
        actionsWidth: widget.actionsWidth,
        isEnabled: widget.slidableActions.isNotEmpty,
        child: child,
      );

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _borderColorTween.end = theme.dividerColor;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : Column(children: widget.children),
    );
  }
}
