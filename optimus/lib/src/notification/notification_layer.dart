import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusNotificationLayer extends StatefulWidget {
  const OptimusNotificationLayer({
    Key? key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    required this.child,
    this.maxVisible = _defaultMaxVisibleCount,
  }) : super(key: key);

  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final Widget child;
  final int maxVisible;

  static OptimusNotificationManager? of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_OptimusNotificationData>()
      ?.manager;

  @override
  State<StatefulWidget> createState() => _OptimusNotificationLayerState();
}

class _OptimusNotificationLayerState extends State<OptimusNotificationLayer>
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
      _addNotification(notification: notification);
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
      _addNotification(notification: _queue.removeAt(0));
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
      isLeading: index == 0,
    );
  }

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
                itemBuilder: (context, index, animation) {
                  final notification = _notifications[index];

                  return _AnimatedOptimusWidget(
                    animation: animation,
                    model: notification,
                    isLeading: index == 0,
                  );
                },
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
    this.isOutgoing = false,
  }) : super(key: key);

  final Animation<double> animation;
  final NotificationModel model;
  final bool isLeading;
  final bool isOutgoing;

  VoidCallback? get _onDismissed => !isOutgoing
      ? model.onDismissPressed
      : model.onDismissPressed == null
          ? null
          : () {};

  Widget _buildNotificationWidget() => NoClipSizeTransition(
        sizeFactor: animation,
        child: SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ),
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
      ? PaddedFromBottom(
          padding: animation,
          child: _buildNotificationWidget(),
        )
      : _buildNotificationWidget();
}

/// Similar to [ScaleTransition], but without clipping.
class NoClipSizeTransition extends AnimatedWidget {
  const NoClipSizeTransition({
    Key? key,
    this.axis = Axis.vertical,
    required Animation<double> sizeFactor,
    this.axisAlignment = 0.0,
    this.child,
  }) : super(key: key, listenable: sizeFactor);

  final Axis axis;
  final double axisAlignment;
  final Widget? child;

  Animation<double> get sizeFactor => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional alignment;
    if (axis == Axis.vertical) {
      alignment = AlignmentDirectional(-1.0, axisAlignment);
    } else {
      alignment = AlignmentDirectional(axisAlignment, -1.0);
    }

    return Align(
      alignment: alignment,
      heightFactor:
          axis == Axis.vertical ? math.max(sizeFactor.value, 0.0) : null,
      widthFactor:
          axis == Axis.horizontal ? math.max(sizeFactor.value, 0.0) : null,
      child: child,
    );
  }
}

class PaddedFromBottom extends AnimatedWidget {
  const PaddedFromBottom({
    Key? key,
    required Animation<double> padding,
    this.child,
  }) : super(key: key, listenable: padding);

  final Widget? child;

  Animation<double> get padding => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final notchPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        notchPadding,
        0,
        notchPadding / 5 * (1 - padding.value),
      ),
      child: child,
    );
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
