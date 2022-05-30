import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

/// The OptimusNotificationManager serves for handling OptimusNotifications.
///
/// By default maximum visible notifications is set to [_defaultMaxVisibleCount].
/// You can change that by changing [customMaxVisibleCount].
class OptimusNotificationManager {
  factory OptimusNotificationManager() => _instance;

  OptimusNotificationManager._();
  static final OptimusNotificationManager _instance =
      OptimusNotificationManager._();

  final List<_NotificationModel> _visibleNotifications = [];
  final List<_NotificationModel> _queuedNotifications = [];

  int? _customMaxVisibleCount;

  final GlobalKey<AnimatedListState> _listStateKey =
      GlobalKey<AnimatedListState>();

  OverlayEntry? _overlayEntry;

  /// Notifications are served in the order they were created (First in, First out).
  /// Each notification has self dismiss timer set to [_autoDismissDuration] and
  /// is limited to a maximum width of [_maxWidth].
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
    assert(title.isNotEmpty, 'Can\'t create notification with empty title');
    final _NotificationModel notification = _createNotificationModel(
      title: title,
      body: body,
      link: link,
      icon: icon,
      onLinkPressed: onLinkPressed,
      onDismissed: onDismissed,
      variant: variant,
    );
    _processNotification(context, notification);
  }

  _NotificationModel _createNotificationModel({
    required String title,
    String? body,
    String? link,
    IconData? icon,
    VoidCallback? onLinkPressed,
    VoidCallback? onDismissed,
    required OptimusNotificationVariant variant,
  }) {
    late _NotificationModel notification;
    final onDismissPressed = onDismissed == null
        ? null
        : () {
            _removeNotification(notification);
          };
    final onLinkPress = onLinkPressed == null
        ? null
        : () {
            onLinkPressed.call();
            _removeNotification(notification);
          };

    return notification = _NotificationModel(
      title: title,
      body: body,
      icon: icon,
      link: link,
      variant: variant,
      onLinkPressed: onLinkPress,
      onDismissPressed: onDismissPressed,
      onNotificationDismissed: () {
        _onNotificationDismissed(onDismissed);
      },
    );
  }

  void _processNotification(
    BuildContext context,
    _NotificationModel notification,
  ) {
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
    Future<void>.delayed(_autoDismissDuration, () {
      if (_visibleNotifications.contains(notification)) {
        _removeNotification(notification);
      }
    });
  }

  void _removeNotification(_NotificationModel model) {
    final index = _visibleNotifications.indexOf(model);
    _visibleNotifications.removeAt(index);
    _listStateKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedNotification(model, animation),
      duration: _animationDuration,
    );
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
                  onVisible: () {
                    _addNotification(initialEntry);
                  },
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
    Future.delayed(_animationDuration, () {
      if (_canRemoveOverlay) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
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
        onDismissed: removedItem.onDismissPressed == null ? null : () {},
        variant: removedItem.variant,
      ),
    );
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

  set customMaxVisibleCount(int value) {
    assert(value > 0, 'Can\'t have negative value of maximum displayed');
    _customMaxVisibleCount = value;
  }

  int get _maxVisibleCount => _customMaxVisibleCount ?? _defaultMaxVisibleCount;

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
    required VoidCallback onVisible,
  })  : _listStateKey = listStateKey,
        _notifications = notifications,
        _onVisible = onVisible,
        super(key: key);
  final GlobalKey<AnimatedListState> _listStateKey;

  final List<_NotificationModel> _notifications;
  final VoidCallback _onVisible;

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
      widget._onVisible.call();
    });
  }

  Widget _buildNotification(int index, Animation<double> animation) {
    final model = widget._notifications[index];

    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 1,
      child: OptimusNotification(
        key: UniqueKey(),
        title: model.title,
        body: model.body,
        icon: model.icon,
        link: model.link,
        onLinkPressed: model.onLinkPressed,
        onDismissed: model.onDismissPressed,
        variant: model.variant,
      ),
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
    this.onDismissPressed,
  });
  final String title;
  final String? body;
  final IconData? icon;
  final String? link;
  final OptimusNotificationVariant variant;
  final VoidCallback? onLinkPressed;
  final VoidCallback onNotificationDismissed;
  final VoidCallback? onDismissPressed;
}

const Duration _animationDuration = Duration(milliseconds: 500);
const Duration _autoDismissDuration = Duration(seconds: 8);
const int _defaultMaxVisibleCount = 1;
const double _maxWidth = 360;
