import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// [OptimusAlertOverlay] is an overlay that wraps [child] inside a
/// stack and provides a method to show an in-app alerts.
///
/// The position of alerts is determined by [OptimusAlertPosition]
/// and by default is set to [OptimusAlertPosition.topRight].
/// You can change the maximum visible count [maxVisible] when declaring the
/// overlay. Alerts that could not be shown because of the [maxVisible]
/// limit will be put into a queue and will be dispatched in the order they were
/// added.
class OptimusAlertOverlay extends StatefulWidget {
  const OptimusAlertOverlay({
    super.key,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
    this.position = OptimusAlertPosition.topRight,
  });

  final OptimusAlertPosition position;
  final Widget child;
  final int maxVisible;

  static OptimusAlertManager? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_OptimusAlertData>()?.manager;

  @override
  State<StatefulWidget> createState() => _OptimusAlertOverlayState();
}

class _OptimusAlertOverlayState extends State<OptimusAlertOverlay>
    with ThemeGetter
    implements OptimusAlertManager {
  final List<OptimusAlert> _alerts = [];
  final List<OptimusAlert> _queue = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void show(OptimusAlert alert) {
    if (_alerts.length < widget.maxVisible) {
      _addAlert(alert);
    } else {
      _queue.add(alert);
    }
  }

  @override
  void remove(OptimusAlert alert) {
    final index = _alerts.indexOf(alert);
    if (index != -1) {
      _alerts.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildRemovedAlert(animation, alert),
        duration: _leavingAnimationDuration,
      );
    }
  }

  void _addAlert(OptimusAlert alert, {int index = 0}) {
    _alerts.insert(index, alert);
    _listKey.currentState?.insertItem(index, duration: _animationDuration);
    Future<void>.delayed(_autoDismissDuration, () {
      if (_alerts.contains(alert)) {
        remove(alert);
      }
    });
  }

  void _handleAlertDismiss() {
    if (_queue.isNotEmpty && _alerts.length < widget.maxVisible) {
      _addAlert(_queue.removeAt(0));
    }
  }

  _AnimatedAlert _buildRemovedAlert(
    Animation<double> animation,
    OptimusAlert alert,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          _handleAlertDismiss();
        }
      },
    );

    return _AnimatedAlert(
      animation: animation,
      alert: alert,
      isOutgoing: true,
      slideTween: widget.position.slideTween,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).screenBreakpoint.index <=
        Breakpoint.medium.index;

    return Builder(
      builder: (context) => _OptimusAlertData(
        this,
        child: Stack(
          children: [
            widget.child,
            Positioned(
              left: widget.position.left(tokens: tokens, isCompact: isCompact),
              top: widget.position.top(tokens: tokens, isCompact: isCompact),
              right:
                  widget.position.right(tokens: tokens, isCompact: isCompact),
              bottom:
                  widget.position.bottom(tokens: tokens, isCompact: isCompact),
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _maxWidth),
                  child: AnimatedList(
                    key: _listKey,
                    shrinkWrap: true,
                    reverse: widget.position.isReversed,
                    itemBuilder: (context, index, animation) => _AnimatedAlert(
                      animation: animation,
                      alert: _alerts[index],
                      slideTween: widget.position.slideTween,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class OptimusAlertManager {
  const OptimusAlertManager();

  void show(OptimusAlert alert);

  void remove(OptimusAlert alert);
}

class _OptimusAlertData extends InheritedWidget {
  const _OptimusAlertData(
    this.manager, {
    required super.child,
  });

  final OptimusAlertManager manager;

  @override
  bool updateShouldNotify(_OptimusAlertData oldWidget) => false;
}

class _AnimatedAlert extends StatelessWidget {
  const _AnimatedAlert({
    required this.animation,
    required this.alert,
    required this.slideTween,
    this.isOutgoing = false,
  });

  final Animation<double> animation;
  final OptimusAlert alert;
  final Tween<Offset> slideTween;
  final bool isOutgoing;

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: isOutgoing,
        child: FadeTransition(
          opacity: animation,
          child: _NoClipSizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
            ),
            child: SlideTransition(
              position: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOutCubic,
              ).drive(slideTween),
              child: Center(
                child: alert,
              ),
            ),
          ),
        ),
      );
}

/// Similar to [ScaleTransition], but without clipping.
class _NoClipSizeTransition extends AnimatedWidget {
  const _NoClipSizeTransition({
    required Animation<double> sizeFactor,
    this.child,
  }) : super(listenable: sizeFactor);

  final Widget? child;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) => Align(
        alignment: AlignmentDirectional.centerStart,
        heightFactor: math.max(sizeFactor.value, 0.0),
        child: child,
      );
}

/// Position of the alert.
enum OptimusAlertPosition { topLeft, topRight, bottomRight, bottomLeft }

extension on OptimusAlertPosition {
  double? left({required OptimusTokens tokens, required bool isCompact}) =>
      switch (this) {
        OptimusAlertPosition.bottomLeft ||
        OptimusAlertPosition.topLeft =>
          isCompact ? tokens.spacing100 : tokens.spacing200,
        OptimusAlertPosition.topRight ||
        OptimusAlertPosition.bottomRight =>
          isCompact ? tokens.spacing100 : null,
      };

  double? top({required OptimusTokens tokens, required bool isCompact}) =>
      switch (this) {
        OptimusAlertPosition.topLeft ||
        OptimusAlertPosition.topRight =>
          isCompact ? tokens.spacing100 : tokens.spacing200,
        OptimusAlertPosition.bottomRight ||
        OptimusAlertPosition.bottomLeft =>
          null,
      };

  double? right({required OptimusTokens tokens, required bool isCompact}) =>
      switch (this) {
        OptimusAlertPosition.bottomRight ||
        OptimusAlertPosition.topRight =>
          isCompact ? tokens.spacing100 : tokens.spacing200,
        OptimusAlertPosition.topLeft ||
        OptimusAlertPosition.bottomLeft =>
          isCompact ? tokens.spacing100 : null,
      };

  double? bottom({required OptimusTokens tokens, required bool isCompact}) =>
      switch (this) {
        OptimusAlertPosition.topLeft || OptimusAlertPosition.topRight => null,
        OptimusAlertPosition.bottomRight ||
        OptimusAlertPosition.bottomLeft =>
          isCompact ? tokens.spacing100 : tokens.spacing200,
      };

  Tween<Offset> get slideTween => switch (this) {
        OptimusAlertPosition.topLeft ||
        OptimusAlertPosition.bottomLeft =>
          Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero),
        OptimusAlertPosition.topRight ||
        OptimusAlertPosition.bottomRight =>
          Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero),
      };

  bool get isReversed => switch (this) {
        OptimusAlertPosition.topLeft || OptimusAlertPosition.topRight => false,
        OptimusAlertPosition.bottomLeft ||
        OptimusAlertPosition.bottomRight =>
          true,
      };
}

const Duration _animationDuration = Duration(milliseconds: 300);
const Duration _leavingAnimationDuration = Duration(milliseconds: 200);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _defaultMaxVisibleCount = 3;
const double _maxWidth = 360;
