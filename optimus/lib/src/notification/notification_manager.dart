import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusNotificationManager {
  factory OptimusNotificationManager() => _instance;

  OptimusNotificationManager._();
  static final OptimusNotificationManager _instance =
      OptimusNotificationManager._();

  final List<_NotificationModel> _visibleNotifications = [];
  final List<_NotificationModel> _queuedNotifications = [];

  final GlobalKey<AnimatedListState> _listStateKey =
      GlobalKey<AnimatedListState>();

  OverlayEntry? _overlayEntry;

  void showNotification({
    required BuildContext context,
    required String title,
    String? body,
    String? link,
    IconData? icon,
    VoidCallback? onLinkPressed,
    VoidCallback? onDismissed,
    OptimusNotificationVariant variant = OptimusNotificationVariant.info,
  }) {
    assert(
      link == null && onLinkPressed == null ||
          link != null && onLinkPressed != null,
      'Can\'t provide link and have null onLinkPressed and vice versa',
    );

    final _NotificationModel notification = _NotificationModel(
      title: title,
      body: body,
      icon: icon,
      link: link,
      variant: variant,
      onLinkPressed: onLinkPressed,
      onDismissed: onDismissed,
      onNotificationDismissed: () {
        _onNotificationDismissed(onDismissed);
      },
    );
    if (_visibleNotifications.isEmpty) {
      _addOverlay(context, notification);
    } else if (!_canShowRightNow) {
      _queuedNotifications.add(notification);
    } else {
      _addNotification(notification);
    }
  }

  void _addNotification(_NotificationModel notification) {
    _visibleNotifications.insert(
      0,
      notification,
    );
    _listStateKey.currentState?.insertItem(0, duration: _animationDuration);
  }

  void _addOverlay(BuildContext context, _NotificationModel notification) {
    final OverlayEntry overlayEntry =
        _buildOverlayEntry(initialEntry: notification);
    _overlayEntry = overlayEntry;
    Overlay.of(context)?.insert(overlayEntry);
  }

  OverlayEntry _buildOverlayEntry({
    required _NotificationModel initialEntry,
  }) =>
      OverlayEntry(
        builder: (context) => Positioned(
          left: _getLeftPadding(context),
          right: _getRightPadding(context),
          child: SafeArea(
            child: Material(
              child: Container(
                constraints: const BoxConstraints(maxWidth: _maxWidth),
                child: _NotificationList(
                  listStateKey: _listStateKey,
                  notifications: _visibleNotifications,
                  initialEntry: initialEntry,
                ),
              ),
            ),
          ),
        ),
      );

  void _onNotificationDismissed(VoidCallback? onDismissed) {
    if (_canShowQueued) {
      _addNotification(_queuedNotifications.removeAt(0));
    } else if (_canRemoveOverlay) {
      _removeOverlay();
    }
    onDismissed?.call();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  double? _getLeftPadding(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return null;
      case Breakpoint.small:
      case Breakpoint.extraSmall:
        return spacing100;
    }
  }

  double _getRightPadding(BuildContext context) {
    switch (MediaQuery.of(context).screenBreakpoint) {
      case Breakpoint.medium:
      case Breakpoint.large:
      case Breakpoint.extraLarge:
        return spacing200;
      case Breakpoint.small:
      case Breakpoint.extraSmall:
        return spacing100;
    }
  }

  bool get _canRemoveOverlay =>
      _queuedNotifications.isEmpty && _visibleNotifications.isEmpty;

  bool get _canShowQueued =>
      _queuedNotifications.isNotEmpty &&
      _visibleNotifications.length < _maxVisibleCount;

  bool get _canShowRightNow =>
      _queuedNotifications.isEmpty &&
      _visibleNotifications.length < _maxVisibleCount;
}

class _NotificationList extends StatefulWidget {
  const _NotificationList({
    Key? key,
    required GlobalKey<AnimatedListState> listStateKey,
    required List<_NotificationModel> notifications,
    required _NotificationModel initialEntry,
  })  : _listStateKey = listStateKey,
        _notifications = notifications,
        _initialEntry = initialEntry,
        super(key: key);
  final GlobalKey<AnimatedListState> _listStateKey;

  final List<_NotificationModel> _notifications;
  final _NotificationModel _initialEntry;

  @override
  State<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<_NotificationList> {
  /// Adding initial notification after the list is visible in the tree,
  /// otherwise first notification would be displayed without animation.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._notifications.insert(0, widget._initialEntry);
      widget._listStateKey.currentState
          ?.insertItem(0, duration: _animationDuration);
    });
  }

  Widget _buildNotification(int index, Animation<double> animation) {
    final model = widget._notifications[index];
    late Widget notification;

    final onDismissed = model.onDismissed != null
        ? () {
            _removeNotification(model);
          }
        : null;

    notification = SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1,
      child: OptimusNotification(
        key: UniqueKey(),
        title: model.title,
        body: model.body,
        icon: model.icon,
        link: model.link,
        onLinkPressed: model.onLinkPressed,
        onDismissed: onDismissed,
        variant: model.variant,
      ),
    );
    Future<void>.delayed(_autoDismissDuration, () {
      if (widget._notifications.contains(model)) {
        _removeNotification(model);
      }
    });

    return notification;
  }

  Widget _buildRemovedNotification(
    _NotificationModel removedItem,
    Animation<double> animation,
  ) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          removedItem.onNotificationDismissed.call();
        }
      },
    );

    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1,
      child: OptimusNotification(
        title: removedItem.title,
        body: removedItem.body,
        icon: removedItem.icon,
        link: removedItem.link,
        onLinkPressed: () {},
        onDismissed: removedItem.onDismissed == null ? null : () {},
        variant: removedItem.variant,
      ),
    );
  }

  void _removeNotification(_NotificationModel model) {
    final index = widget._notifications.indexOf(model);
    widget._notifications.removeAt(index);
    widget._listStateKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedNotification(model, animation),
      duration: _animationDuration,
    );
  }

  @override
  Widget build(BuildContext context) => AnimatedList(
        key: widget._listStateKey,
        shrinkWrap: true,
        itemBuilder: (context, index, animation) =>
            _buildNotification(index, animation),
      );
}

class _NotificationModel {
  _NotificationModel({
    required this.title,
    this.body,
    this.icon,
    this.link,
    required this.variant,
    this.onLinkPressed,
    required this.onNotificationDismissed,
    this.onDismissed,
  });
  final String title;
  final String? body;
  final IconData? icon;
  final String? link;
  final OptimusNotificationVariant variant;
  final VoidCallback? onLinkPressed;
  final VoidCallback onNotificationDismissed;
  final VoidCallback? onDismissed;
}

const Duration _animationDuration = Duration(milliseconds: 500);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _maxVisibleCount = 3;
const double _maxWidth = 360;
