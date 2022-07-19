import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// [OptimusNotificationsOverlay] is an overlay that wraps [child] inside a
/// stack and provides a method to show an in-app notification.
///
/// The position of notifications is determined by parameters, similar to
/// [Positioned], i.e. [left, top, right, bottom]. There are two possibilities
/// for notification to slide in: [OptimusIncomingDirection.fromLeft] and
/// [OptimusIncomingDirection.fromRight]. You can change the order for stacking
/// of new notifications by changing the initial [stackingDirection] to
/// [OptimusStackingDirection.top] or [OptimusStackingDirection.bottom]. New
/// notifications will be added to the top of the list by default.
/// You can change the maximum visible count [maxVisible] when declaring the
/// overlay. Notifications that could not be shown because of the [maxVisible]
/// limit will be put into a queue and will be dispatched in the order they were
/// added.
class OptimusNotificationsOverlay extends StatefulWidget {
  const OptimusNotificationsOverlay({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
    this.inDirection = OptimusIncomingDirection.fromRight,
    this.stackingDirection = OptimusStackingDirection.top,
  }) : super(key: key);

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final Widget child;
  final int maxVisible;
  final OptimusIncomingDirection inDirection;
  final OptimusStackingDirection stackingDirection;

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

  _AnimatedOptimusWidget _buildRemovedNotification(
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

    return _AnimatedOptimusWidget(
      animation: animation,
      model: notification,
      isOutgoing: true,
      direction: widget.inDirection,
    );
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Stack(
          children: [
            _OptimusNotificationData(this, child: widget.child),
            Positioned(
              left: widget.left,
              top: widget.top,
              right: widget.right,
              bottom: widget.bottom,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: AnimatedList(
                  key: _listKey,
                  shrinkWrap: true,
                  reverse: widget.stackingDirection.reverse,
                  itemBuilder: (context, index, animation) =>
                      _AnimatedOptimusWidget(
                    animation: animation,
                    model: _notifications[index],
                    direction: widget.inDirection,
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

class _AnimatedOptimusWidget extends StatelessWidget {
  const _AnimatedOptimusWidget({
    Key? key,
    required this.animation,
    required this.model,
    required this.direction,
    this.isOutgoing = false,
  }) : super(key: key);

  final Animation<double> animation;
  final _NotificationModel model;
  final OptimusIncomingDirection direction;
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

/// The direction of the notification incoming animation.
enum OptimusIncomingDirection { fromLeft, fromRight }

/// The direction where should we place new notification.
enum OptimusStackingDirection { top, bottom }

extension on OptimusIncomingDirection {
  Tween<Offset> get animation {
    switch (this) {
      case OptimusIncomingDirection.fromLeft:
        return Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero);
      case OptimusIncomingDirection.fromRight:
        return Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero);
    }
  }
}

extension on OptimusStackingDirection {
  bool get reverse {
    switch (this) {
      case OptimusStackingDirection.top:
        return false;
      case OptimusStackingDirection.bottom:
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
