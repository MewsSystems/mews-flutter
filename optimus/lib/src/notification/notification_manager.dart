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

  /// Notifications are served in the order they were created (First in, First
  /// out). Each notification has self dismiss timer set to
  /// [_autoDismissDuration] and is limited to a maximum width of [_maxWidth].
  void showNotification({
    required BuildContext context,
    required String title,
    String? body,
    IconData? icon,
    VoidCallback? onDismissed,
    NotificationLink? link,
    OptimusNotificationVariant variant = OptimusNotificationVariant.info,
  }) {
    assert(title.isNotEmpty, 'Can\'t create notification with empty title');
    final _NotificationModel notification = _createNotificationModel(
      title: title,
      body: body,
      link: link,
      icon: icon,
      onDismissed: onDismissed,
      variant: variant,
    );
    _processNotification(context, notification);
  }

  _NotificationModel _createNotificationModel({
    required String title,
    String? body,
    IconData? icon,
    VoidCallback? onDismissed,
    NotificationLink? link,
    required OptimusNotificationVariant variant,
  }) {
    late _NotificationModel notification;
    final onDismissPressed = onDismissed == null
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

    return notification = _NotificationModel(
      title: title,
      body: body,
      icon: icon,
      link: link?.linkText,
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
      (context, animation) => _buildRemovedNotification(
        removedItem: model,
        animation: animation,
        isLeading: index == 0,
      ),
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
          child: Material(
            type: MaterialType.transparency,
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

  Widget _buildRemovedNotification({
    required _NotificationModel removedItem,
    required Animation<double> animation,
    required bool isLeading,
  }) {
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.dismissed) {
          removedItem.onNotificationDismissed.call();
        }
      },
    );

    return _AnimatedOptimusNotification(
      model: removedItem,
      animation: animation,
      isLeading: isLeading,
      isOutgoing: true,
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

/// The notification link with custom call-to-action.
///
/// This link is defined by the text of the button and the function that needs
/// to be executed after a click.
class NotificationLink {
  NotificationLink({required this.linkText, required this.onLinkPressed});

  final String linkText;
  final VoidCallback onLinkPressed;
}

class _NotificationList extends StatefulWidget {
  const _NotificationList({
    Key? key,
    required this.listStateKey,
    required this.notifications,
    required this.onVisible,
  }) : super(key: key);
  final GlobalKey<AnimatedListState> listStateKey;

  final List<_NotificationModel> notifications;
  final VoidCallback onVisible;

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
      widget.onVisible.call();
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedList(
        key: widget.listStateKey,
        shrinkWrap: true,
        itemBuilder: (context, index, animation) =>
            _AnimatedOptimusNotification(
          model: widget.notifications[index],
          animation: animation,
          isLeading: index == 0,
        ),
      );
}

class _AnimatedOptimusNotification extends StatelessWidget {
  const _AnimatedOptimusNotification({
    Key? key,
    required this.model,
    required this.animation,
    required this.isLeading,
    this.isOutgoing = false,
  }) : super(key: key);

  final _NotificationModel model;
  final Animation<double> animation;
  final bool isLeading;
  final bool isOutgoing;

  VoidCallback? get _onDismissed {
    if (!isOutgoing) {
      return model.onDismissPressed;
    }

    return model.onDismissPressed == null ? null : () {};
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: 1,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(
              spacing100,
              isLeading ? MediaQuery.of(context).padding.top : spacing100,
              spacing100,
              spacing200,
            ),
            child: OptimusNotification(
              key: UniqueKey(),
              title: model.title,
              body: model.body,
              icon: model.icon,
              link: model.link,
              onLinkPressed: isOutgoing ? () {} : model.onLinkPressed,
              onDismissed: _onDismissed,
              variant: model.variant,
            ),
          ),
        ),
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
