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
    Key? key,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
    this.position = OptimusNotificationPosition.topRight,
  }) : super(key: key);

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
  final List<_NotificationModel> _notifications = [];
  final List<_NotificationModel> _queue = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void show(OptimusNotification notification) {
    final notificationModel = _NotificationModel(
      notification: notification,
      onDismiss: _handleNotificationDismiss,
    );

    if (_notifications.length < widget.maxVisible) {
      _addNotification(notification: notificationModel);
    } else {
      _queue.add(notificationModel);
    }
  }

  @override
  void remove(OptimusNotification notification) {
    final _NotificationModel? model = _findNotification(notification);
    if (model != null) {
      _removeNotification(model);
    }
  }

  _NotificationModel? _findNotification(OptimusNotification notification) {
    for (final _NotificationModel model in _notifications) {
      if (model.notification == notification) return model;
    }

    return null;
  }

  void _addNotification({
    required _NotificationModel notification,
    int index = 0,
  }) {
    _notifications.insert(index, notification);
    _listKey.currentState?.insertItem(index, duration: _animationDuration);
    Future<void>.delayed(_autoDismissDuration, () {
      if (_notifications.contains(notification)) {
        _removeNotification(notification);
      }
    });
  }

  void _removeNotification(_NotificationModel model) {
    final index = _notifications.indexOf(model);
    if (index != -1) {
      _notifications.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildRemovedNotification(animation, model),
        duration: _leavingAnimationDuration,
      );
    }
  }

  void _handleNotificationDismiss() {
    if (_queue.isNotEmpty && _notifications.length < widget.maxVisible) {
      _addNotification(
        notification: _queue.removeAt(0),
      );
    }
  }

  _AnimatedNotification _buildRemovedNotification(
    Animation<double> animation,
    _NotificationModel notification,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          notification.onDismiss.call();
        }
      },
    );

    return _AnimatedNotification(
      animation: animation,
      model: notification,
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
              left: widget.position.left(isCompact),
              top: widget.position.top(isCompact),
              right: widget.position.right(isCompact),
              bottom: widget.position.bottom(isCompact),
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
                      model: _notifications[index],
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
  void show(OptimusNotification notification);
  void remove(OptimusNotification notification);
}

class _OptimusNotificationData extends InheritedWidget {
  const _OptimusNotificationData(
    this.manager, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final OptimusNotificationManager manager;

  @override
  bool updateShouldNotify(_OptimusNotificationData oldWidget) => false;
}

class _AnimatedNotification extends StatelessWidget {
  const _AnimatedNotification({
    Key? key,
    required this.animation,
    required this.model,
    required this.slideTween,
    this.isOutgoing = false,
  }) : super(key: key);

  final Animation<double> animation;
  final _NotificationModel model;
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
                child: model.notification,
              ),
            ),
          ),
        ),
      );
}

/// Similar to [ScaleTransition], but without clipping.
class _NoClipSizeTransition extends AnimatedWidget {
  const _NoClipSizeTransition({
    Key? key,
    required Animation<double> sizeFactor,
    this.child,
  }) : super(key: key, listenable: sizeFactor);

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
  double? left(bool isCompact) {
    switch (this) {
      case OptimusNotificationPosition.bottomLeft:
      case OptimusNotificationPosition.topLeft:
        return isCompact ? spacing100 : spacing200;
      case OptimusNotificationPosition.topRight:
      case OptimusNotificationPosition.bottomRight:
        return isCompact ? spacing100 : null;
    }
  }

  double? top(bool isCompact) {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return isCompact ? spacing100 : spacing200;
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.bottomLeft:
        return null;
    }
  }

  double? right(bool isCompact) {
    switch (this) {
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.topRight:
        return isCompact ? spacing100 : spacing200;
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.bottomLeft:
        return isCompact ? spacing100 : null;
    }
  }

  double? bottom(bool isCompact) {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return null;
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.bottomLeft:
        return isCompact ? spacing100 : spacing200;
    }
  }

  Tween<Offset> get slideTween {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.bottomLeft:
        return Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero);
      case OptimusNotificationPosition.topRight:
      case OptimusNotificationPosition.bottomRight:
        return Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
    }
  }

  bool get reverse {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return false;
      case OptimusNotificationPosition.bottomLeft:
      case OptimusNotificationPosition.bottomRight:
        return true;
    }
  }
}

class _NotificationModel {
  _NotificationModel({
    required this.notification,
    required this.onDismiss,
  });
  final OptimusNotification notification;
  final VoidCallback onDismiss;
}

const Duration _animationDuration = Duration(milliseconds: 300);
const Duration _leavingAnimationDuration = Duration(milliseconds: 200);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _defaultMaxVisibleCount = 3;
const double _maxWidth = 360;
