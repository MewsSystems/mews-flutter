import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// [OptimusNotificationsOverlay] is an overlay that wraps [child] inside a
/// stack and provides a method to show an in-app notification.
///
/// The position of notifications is determined by [OptimusNotificationPosition]
/// and by default is set to [OptimusNotificationPosition.topRight].
/// You can change the maximum visible count [maxVisible] when declaring the
/// overlay. Notifications that could not be shown because of the [maxVisible]
/// limit will be put into a queue and will be dispatched in the order they were
/// added.
class OptimusNotificationsOverlay extends StatefulWidget {
  const OptimusNotificationsOverlay({
    super.key,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
    this.position = OptimusNotificationPosition.topRight,
  });

  final OptimusNotificationPosition position;
  final Widget child;
  final int maxVisible;

  static OptimusNotificationManager? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_OptimusNotificationData>()
      ?.manager;

  @override
  State<StatefulWidget> createState() => _OptimusNotificationsOverlayState();
}

class _OptimusNotificationsOverlayState
    extends State<OptimusNotificationsOverlay>
    implements OptimusNotificationManager {
  final List<OptimusNotification> _notifications = [];
  final List<OptimusNotification> _queue = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void show(OptimusNotification notification) {
    if (_notifications.length < widget.maxVisible) {
      _addNotification(notification);
    } else {
      _queue.add(notification);
    }
  }

  @override
  void remove(OptimusNotification notification) {
    final index = _notifications.indexOf(notification);
    if (index != -1) {
      _notifications.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildRemovedNotification(animation, notification),
        duration: _leavingAnimationDuration,
      );
    }
  }

  void _addNotification(
    OptimusNotification notification, {
    int index = 0,
  }) {
    _notifications.insert(index, notification);
    _listKey.currentState?.insertItem(index, duration: _animationDuration);
    Future<void>.delayed(_autoDismissDuration, () {
      if (_notifications.contains(notification)) {
        remove(notification);
      }
    });
  }

  void _handleNotificationDismiss() {
    if (_queue.isNotEmpty && _notifications.length < widget.maxVisible) {
      _addNotification(_queue.removeAt(0));
    }
  }

  _AnimatedNotification _buildRemovedNotification(
    Animation<double> animation,
    OptimusNotification notification,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          _handleNotificationDismiss();
        }
      },
    );

    return _AnimatedNotification(
      animation: animation,
      notification: notification,
      isOutgoing: true,
      slideTween: widget.position.slideTween,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.of(context).screenBreakpoint.index <=
        Breakpoint.medium.index;

    return Builder(
      builder: (context) => _OptimusNotificationData(
        this,
        child: Stack(
          children: [
            widget.child,
            Positioned(
              left: widget.position.left(isCompact: isCompact),
              top: widget.position.top(isCompact: isCompact),
              right: widget.position.right(isCompact: isCompact),
              bottom: widget.position.bottom(isCompact: isCompact),
              child: SafeArea(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: _maxWidth),
                  child: AnimatedList(
                    key: _listKey,
                    shrinkWrap: true,
                    reverse: widget.position.reverse,
                    itemBuilder: (context, index, animation) =>
                        _AnimatedNotification(
                      animation: animation,
                      notification: _notifications[index],
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

abstract class OptimusNotificationManager {
  const OptimusNotificationManager();

  void show(OptimusNotification notification);
  void remove(OptimusNotification notification);
}

class _OptimusNotificationData extends InheritedWidget {
  const _OptimusNotificationData(
    this.manager, {
    required super.child,
  });

  final OptimusNotificationManager manager;

  @override
  bool updateShouldNotify(_OptimusNotificationData oldWidget) => false;
}

class _AnimatedNotification extends StatelessWidget {
  const _AnimatedNotification({
    required this.animation,
    required this.notification,
    required this.slideTween,
    this.isOutgoing = false,
  });

  final Animation<double> animation;
  final OptimusNotification notification;
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
                child: notification,
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

/// The position of the notifications.
enum OptimusNotificationPosition { topLeft, topRight, bottomRight, bottomLeft }

extension on OptimusNotificationPosition {
  double? left({required bool isCompact}) => switch (this) {
        OptimusNotificationPosition.bottomLeft ||
        OptimusNotificationPosition.topLeft =>
          isCompact ? spacing100 : spacing200,
        OptimusNotificationPosition.topRight ||
        OptimusNotificationPosition.bottomRight =>
          isCompact ? spacing100 : null,
      };

  double? top({required bool isCompact}) => switch (this) {
        OptimusNotificationPosition.topLeft ||
        OptimusNotificationPosition.topRight =>
          isCompact ? spacing100 : spacing200,
        OptimusNotificationPosition.bottomRight ||
        OptimusNotificationPosition.bottomLeft =>
          null,
      };

  double? right({required bool isCompact}) => switch (this) {
        OptimusNotificationPosition.bottomRight ||
        OptimusNotificationPosition.topRight =>
          isCompact ? spacing100 : spacing200,
        OptimusNotificationPosition.topLeft ||
        OptimusNotificationPosition.bottomLeft =>
          isCompact ? spacing100 : null,
      };

  double? bottom({required bool isCompact}) => switch (this) {
        OptimusNotificationPosition.topLeft ||
        OptimusNotificationPosition.topRight =>
          null,
        OptimusNotificationPosition.bottomRight ||
        OptimusNotificationPosition.bottomLeft =>
          isCompact ? spacing100 : spacing200,
      };

  Tween<Offset> get slideTween => switch (this) {
        OptimusNotificationPosition.topLeft ||
        OptimusNotificationPosition.bottomLeft =>
          Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero),
        OptimusNotificationPosition.topRight ||
        OptimusNotificationPosition.bottomRight =>
          Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero),
      };

  bool get reverse => switch (this) {
        OptimusNotificationPosition.topLeft ||
        OptimusNotificationPosition.topRight =>
          false,
        OptimusNotificationPosition.bottomLeft ||
        OptimusNotificationPosition.bottomRight =>
          true,
      };
}

const Duration _animationDuration = Duration(milliseconds: 300);
const Duration _leavingAnimationDuration = Duration(milliseconds: 200);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _defaultMaxVisibleCount = 3;
const double _maxWidth = 360;
