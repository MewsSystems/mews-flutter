import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

const Duration _kExpand = Duration(milliseconds: 200);

/// A single-line [ListTile] with a trailing button that expands or collapses
/// the tile to reveal or hide the [children].
///
/// Based on flutter/lib/src/material/expansion_tile.dart
class OptimusExpansionTile extends StatefulWidget {
  /// Creates a single-line [OptimusListTile] with a trailing button that expands or
  /// collapses the tile to reveal or hide the [children]. The
  /// [isInitiallyExpanded] property must be non-null.
  const OptimusExpansionTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.isInitiallyExpanded = false,
    this.hasBorders = true,
    this.actionsWidth = 0,
    this.slidableActions = const <Widget>[],
    this.contentPadding,
  });

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
  final bool isInitiallyExpanded;

  /// Borders of the inner [OptimusSlidable] widget
  final bool hasBorders;

  /// Width of the inner slidable actions in [OptimusSlidable] widget
  final double actionsWidth;

  /// List of actions on list tile left swipe.
  final List<Widget> slidableActions;

  /// The padding of the tile's inner content.
  final EdgeInsets? contentPadding;

  @override
  State<OptimusExpansionTile> createState() => _OptimusExpansionTileState();
}

class _OptimusExpansionTileState extends State<OptimusExpansionTile>
    with SingleTickerProviderStateMixin, ThemeGetter {
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

    final stateValue = PageStorage.of(context).readState(context);
    _isExpanded = stateValue is bool ? stateValue : widget.isInitiallyExpanded;
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
      PageStorage.of(context).writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  void didChangeDependencies() {
    _borderColorTween.end = tokens.borderStaticSecondary;
    _backgroundColorTween.end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool isClosed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        final listTile = OptimusListTile(
          onTap: _handleTap,
          prefix: widget.leading,
          title: widget.title,
          contentPadding: widget.contentPadding,
          subtitle: widget.subtitle,
          suffix: widget.trailing ??
              RotationTransition(
                turns: _iconTurns,
                child: const Icon(Icons.expand_more),
              ),
        );

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.slidableActions.isEmpty)
              listTile
            else
              OptimusSlidable(
                actions: widget.slidableActions,
                hasBorders: widget.hasBorders,
                actionsWidth: widget.actionsWidth,
                isEnabled: widget.slidableActions.isNotEmpty,
                child: listTile,
              ),
            ClipRect(
              child: Align(heightFactor: _heightFactor.value, child: child),
            ),
          ],
        );
      },
      child: isClosed ? null : Column(children: widget.children),
    );
  }
}
