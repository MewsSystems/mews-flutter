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
  void show({
    required Widget title,
    Widget? body,
    IconData? icon,
    VoidCallback? onDismissed,
    NotificationLink? link,
    OptimusNotificationVariant variant = OptimusNotificationVariant.info,
  }) {
    late final _NotificationModel notification;

    final onDismissPressed = onDismissed == null
        ? null
        : () {
            _removeNotification(notification);
          };
    final onLinkPressed = link == null
        ? null
        : () {
            link.onLinkPressed();
            _removeNotification(notification);
          };

    notification = _NotificationModel(
      title: title,
      body: body,
      icon: icon,
      link: link?.linkText,
      onLinkPressed: onLinkPressed,
      variant: variant,
      onNotificationDismissed: () {
        _handleNotificationDismiss(onDismissed: onDismissed);
      },
      onDismissPressed: onDismissPressed,
    );

    if (_notifications.length < widget.maxVisible) {
      _addNotification(notification: notification);
    } else {
      _queue.add(notification);
    }
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

  void _handleNotificationDismiss({VoidCallback? onDismissed}) {
    if (_queue.isNotEmpty && _notifications.length < widget.maxVisible) {
      _addNotification(
        notification: _queue.removeAt(0),
      );
    }
    onDismissed?.call();
  }

  _IncomingDirection get _direction => widget.position.incomingDirection;

  bool get _reverse => widget.position.stackingDirection.reverse;

  double? _left(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
        return widget.position.leftCompact;
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return widget.position.left;
    }
  }

  double? _right(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.extraSmall:
      case Breakpoint.small:
        return widget.position.rightCompact;
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return widget.position.right;
    }
  }

  _AnimatedNotification _buildRemovedNotification(
    Animation<double> animation,
    _NotificationModel notification,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          notification.onNotificationDismissed.call();
        }
      },
    );

    return _AnimatedNotification(
      animation: animation,
      model: notification,
      isOutgoing: true,
      direction: _direction,
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Stack(
          children: [
            _OptimusNotificationData(this, child: widget.child),
            Positioned(
              left: _left(context),
              top: widget.position.top,
              right: _right(context),
              bottom: widget.position.bottom,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: AnimatedList(
                  key: _listKey,
                  shrinkWrap: true,
                  reverse: _reverse,
                  itemBuilder: (context, index, animation) =>
                      _AnimatedNotification(
                    animation: animation,
                    model: _notifications[index],
                    direction: _direction,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

abstract class OptimusNotificationManager {
  void show({
    required Widget title,
    Widget? body,
    IconData? icon,
    VoidCallback? onDismissed,
    NotificationLink? link,
    OptimusNotificationVariant variant,
  });
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
    required this.direction,
    this.isOutgoing = false,
  }) : super(key: key);

  final Animation<double> animation;
  final _NotificationModel model;
  final _IncomingDirection direction;
  final bool isOutgoing;

  VoidCallback? get _onDismissed => !isOutgoing
      ? model.onDismissPressed
      : model.onDismissPressed == null
          ? null
          : () {};

  @override
  Widget build(BuildContext context) => FadeTransition(
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
            ).drive(direction.animation),
            child: Center(
              child: OptimusNotification(
                title: model.title,
                body: model.body,
                link: model.link,
                onLinkPressed: isOutgoing ? () {} : model.onLinkPressed,
                variant: model.variant,
                onDismissed: _onDismissed,
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

/// The direction of the notification incoming animation.
enum _IncomingDirection { fromLeft, fromRight }

/// The direction where should we place new notification.
enum _StackingDirection { top, bottom }

extension on OptimusNotificationPosition {
  double? get left {
    switch (this) {
      case OptimusNotificationPosition.bottomLeft:
      case OptimusNotificationPosition.topLeft:
        return spacing200;
      case OptimusNotificationPosition.topRight:
      case OptimusNotificationPosition.bottomRight:
        return null;
    }
  }

  double? get leftCompact {
    switch (this) {
      case OptimusNotificationPosition.bottomLeft:
      case OptimusNotificationPosition.topLeft:
        return spacing100;
      case OptimusNotificationPosition.topRight:
      case OptimusNotificationPosition.bottomRight:
        return spacing100;
    }
  }

  double? get top {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return spacing100;
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.bottomLeft:
        return null;
    }
  }

  double? get right {
    switch (this) {
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.topRight:
        return spacing200;
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.bottomLeft:
        return null;
    }
  }

  double? get rightCompact {
    switch (this) {
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.topRight:
        return spacing100;
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.bottomLeft:
        return spacing100;
    }
  }

  double? get bottom {
    switch (this) {
      case OptimusNotificationPosition.bottomRight:
      case OptimusNotificationPosition.bottomLeft:
        return spacing100;
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return null;
    }
  }

  _IncomingDirection get incomingDirection {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.bottomLeft:
        return _IncomingDirection.fromLeft;
      case OptimusNotificationPosition.topRight:
      case OptimusNotificationPosition.bottomRight:
        return _IncomingDirection.fromRight;
    }
  }

  _StackingDirection get stackingDirection {
    switch (this) {
      case OptimusNotificationPosition.topLeft:
      case OptimusNotificationPosition.topRight:
        return _StackingDirection.top;
      case OptimusNotificationPosition.bottomLeft:
      case OptimusNotificationPosition.bottomRight:
        return _StackingDirection.bottom;
    }
  }
}

extension on _IncomingDirection {
  Tween<Offset> get animation {
    switch (this) {
      case _IncomingDirection.fromLeft:
        return Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero);
      case _IncomingDirection.fromRight:
        return Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
    }
  }
}

extension on _StackingDirection {
  bool get reverse {
    switch (this) {
      case _StackingDirection.top:
        return false;
      case _StackingDirection.bottom:
        return true;
    }
  }
}

/// The notification link with custom call-to-action.
///
/// This link is defined by the text of the button and the function that needs
/// to be executed after a click.
class NotificationLink {
  NotificationLink({required this.linkText, required this.onLinkPressed});

  final Widget linkText;
  final VoidCallback onLinkPressed;
}

/// Data representation for a particular notification.
class _NotificationModel {
  _NotificationModel({
    required this.title,
    this.body,
    this.icon,
    this.link,
    required this.variant,
    this.onLinkPressed,
    required this.onNotificationDismissed,
    this.onDismissPressed,
  });
  final Widget title;
  final Widget? body;
  final IconData? icon;
  final Widget? link;
  final OptimusNotificationVariant variant;
  final VoidCallback? onLinkPressed;
  final VoidCallback onNotificationDismissed;
  final VoidCallback? onDismissPressed;
}

const Duration _animationDuration = Duration(milliseconds: 300);
const Duration _leavingAnimationDuration = Duration(milliseconds: 200);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _defaultMaxVisibleCount = 3;
const double _maxWidth = 360;
