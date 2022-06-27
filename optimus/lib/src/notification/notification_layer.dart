import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// [OptimusNotificationsOverlay] is an overlay that wraps [child] inside a stack
/// and will provide a method to show an in-app notification. The
/// position of notifications is determined by parameters, similar to
/// [Positioned], i.e. [left, top, right, bottom]. There are two possibilities
/// for notification to slide in: [OptimusNotificationDirection.fromTop] and
/// [OptimusNotificationDirection.fromBottom]. You can change the maximum
/// visible count [maxVisible] when declaring the overlay. Notifications that
/// could not be shown because of the [maxVisible] limit will be put into a
/// queue and will be dispatched in the order they were added.
class OptimusNotificationsOverlay extends StatefulWidget {
  const OptimusNotificationsOverlay({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
    this.direction = OptimusNotificationDirection.fromTop,
  }) : super(key: key);

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final Widget child;
  final int maxVisible;
  final OptimusNotificationDirection direction;

  static OptimusNotificationManager? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_OptimusNotificationData>()
      ?.manager;

  @override
  State<StatefulWidget> createState() => _OptimusNotificationsOverlayState();
}

class _OptimusNotificationsOverlayState
    extends State<OptimusNotificationsOverlay>
    implements OptimusNotificationManager {
  final List<NotificationModel> _notifications = [];
  final List<NotificationModel> _queue = [];
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
    late NotificationModel notification;

    final onDismissPress = onDismissed == null
        ? null
        : () {
            _removeNotification(notification);
          };
    final onLinkPress = link == null
        ? null
        : () {
            link.onLinkPressed();
            _removeNotification(notification);
          };

    notification = NotificationModel(
      title: title,
      body: body,
      icon: icon,
      link: link?.linkText,
      onLinkPressed: onLinkPress,
      variant: variant,
      onNotificationDismissed: () {
        _handleNotificationDismiss(notification);
      },
      onDismissPressed: onDismissPress,
    );

    if (_notifications.length < widget.maxVisible) {
      _addNotification(
        notification: notification,
        index: _getNextIndex(),
      );
    } else {
      _queue.add(notification);
    }
  }

  void _addNotification({
    required NotificationModel notification,
    int index = 0,
  }) {
    _notifications.insert(
      index,
      notification,
    );
    _listKey.currentState?.insertItem(index, duration: _animationDuration);
    Future<void>.delayed(_autoDismissDuration, () {
      if (_notifications.contains(notification)) {
        _removeNotification(notification);
      }
    });
  }

  void _removeNotification(NotificationModel model) {
    final index = _notifications.indexOf(model);
    if (index != -1) {
      _notifications.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildRemovedNotification(animation, model, index),
        duration: _leavingAnimationDuration,
      );
    }
  }

  void _handleNotificationDismiss(NotificationModel notification) {
    if (_queue.isNotEmpty && _notifications.length < widget.maxVisible) {
      _addNotification(
        notification: _queue.removeAt(0),
        index: _getNextIndex(),
      );
    }
    notification.onDismissPressed?.call();
  }

  _AnimatedOptimusWidget _buildRemovedNotification(
    Animation<double> animation,
    NotificationModel notification,
    int index,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          _handleNotificationDismiss(notification);
        }
      },
    );

    return _AnimatedOptimusWidget(
      animation: animation,
      model: notification,
      isOutgoing: true,
      isLeading: _isLeading(index),
      direction: widget.direction,
    );
  }

  int _getNextIndex() =>
      widget.direction == OptimusNotificationDirection.fromTop
          ? 0
          : _notifications.length;

  bool _isLeading(int index) =>
      (index == 0 &&
          widget.direction == OptimusNotificationDirection.fromTop) ||
      (index == _notifications.length - 1 &&
          widget.direction == OptimusNotificationDirection.fromBottom);

  @override
  Widget build(BuildContext context) => Stack(
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
                itemBuilder: (context, index, animation) =>
                    _AnimatedOptimusWidget(
                  animation: animation,
                  model: _notifications[index],
                  isLeading: _isLeading(index),
                  direction: widget.direction,
                ),
              ),
            ),
          ),
        ],
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
    required this.isLeading,
    required this.direction,
    this.isOutgoing = false,
  }) : super(key: key);

  final Animation<double> animation;
  final NotificationModel model;
  final bool isLeading;
  final OptimusNotificationDirection direction;
  final bool isOutgoing;

  VoidCallback? get _onDismissed => !isOutgoing
      ? model.onDismissPressed
      : model.onDismissPressed == null
          ? null
          : () {};

  Tween<Offset> get _animationTween {
    switch (direction) {
      case OptimusNotificationDirection.fromTop:
        return Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero);
      case OptimusNotificationDirection.fromBottom:
        return Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
    }
  }

  Widget _buildNotificationWidget() => _NoClipSizeTransition(
        sizeFactor: animation,
        child: SlideTransition(
          position: animation.drive(
            _animationTween,
          ),
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
      );

  @override
  Widget build(BuildContext context) => isLeading
      ? _SafeAreaTransition(
          padding: animation,
          direction: direction,
          child: _buildNotificationWidget(),
        )
      : _buildNotificationWidget();
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

/// Transition for a leading notification, so it will animate through the safe
/// zone and will end up inside it. This transition is directing the padding
/// from the opposite side as well, to make the whole animation smother.
class _SafeAreaTransition extends AnimatedWidget {
  const _SafeAreaTransition({
    Key? key,
    required Animation<double> padding,
    required this.direction,
    this.child,
  }) : super(key: key, listenable: padding);

  final Widget? child;
  final OptimusNotificationDirection direction;

  Animation<double> get padding => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final paddingFromSafeArea =
        direction == OptimusNotificationDirection.fromTop
            ? MediaQuery.of(context).padding.top
            : MediaQuery.of(context).padding.bottom;
    final paddingToNext = paddingFromSafeArea / 5 * (1 - padding.value);

    return Padding(
      padding: EdgeInsets.only(
        top: direction == OptimusNotificationDirection.fromTop
            ? paddingFromSafeArea
            : paddingToNext,
        bottom: direction == OptimusNotificationDirection.fromTop
            ? paddingToNext
            : paddingFromSafeArea,
      ),
      child: child,
    );
  }
}

/// The direction of the notification incoming animation.
enum OptimusNotificationDirection { fromTop, fromBottom }

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
class NotificationModel {
  NotificationModel({
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
