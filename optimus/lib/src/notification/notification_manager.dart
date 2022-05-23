import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';

class OptimusNotificationManager {
  factory OptimusNotificationManager() => _instance;

  OptimusNotificationManager._();

  static final OptimusNotificationManager _instance =
      OptimusNotificationManager._();

  final List<_NotificationModel> _notifications = [];

  final GlobalKey<AnimatedListState> _listStateKey =
      GlobalKey<AnimatedListState>();

  late OverlayEntry _overlayEntry;

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
    if (_notifications.isEmpty) {
      _overlayEntry = _buildOverlayEntry(
        context: context,
        initialEntry: _NotificationModel(
          title: title,
          body: body,
          icon: icon,
          link: link,
          variant: variant,
          onLinkPressed: onLinkPressed,
        ),
      );
      Overlay.of(context)?.insert(_overlayEntry);
    } else {
      _notifications.insert(
        0,
        _NotificationModel(
          title: title,
          body: body,
          icon: icon,
          link: link,
          variant: variant,
          onLinkPressed: onLinkPressed,
        ),
      );
      _listStateKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 500));
    }
  }

  OverlayEntry _buildOverlayEntry({
    required BuildContext context,
    required _NotificationModel initialEntry,
  }) {
    late OverlayEntry overlayEntry;

    // ignore: join_return_with_assignment
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: spacing100,
        right: spacing200,
        child: SafeArea(
          child: Material(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 360),
              child: _NotificationList(
                listStateKey: _listStateKey,
                notifications: _notifications,
                overlayEntry: overlayEntry,
                initialEntry: initialEntry,
              ),
            ),
          ),
        ),
      ),
    );

    return overlayEntry;
  }
}

class _NotificationList extends StatefulWidget {
  const _NotificationList({
    Key? key,
    required GlobalKey<AnimatedListState> listStateKey,
    required List<_NotificationModel> notifications,
    required OverlayEntry overlayEntry,
    required _NotificationModel initialEntry,
  })  : _listStateKey = listStateKey,
        _notifications = notifications,
        _overlayEntry = overlayEntry,
        _initialEntry = initialEntry,
        super(key: key);

  final GlobalKey<AnimatedListState> _listStateKey;
  final List<_NotificationModel> _notifications;
  final OverlayEntry _overlayEntry;
  final _NotificationModel _initialEntry;

  @override
  State<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<_NotificationList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget._notifications.insert(0, widget._initialEntry);
      widget._listStateKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) => AnimatedList(
        key: widget._listStateKey,
        shrinkWrap: true,
        itemBuilder: (context, index, animation) {
          final model = widget._notifications[index];
          return SizeTransition(
            sizeFactor: animation,
            child: OptimusNotification(
              key: UniqueKey(),
              title: model.title,
              body: model.body,
              icon: model.icon,
              link: model.link,
              onLinkPressed: model.onLinkPressed,
              onDismissed: () {
                _removeNotification(index);
              },
              variant: model.variant,
            ),
          );
        },
      );

  void _removeNotification(int index) {
    final removedItem = widget._notifications[index];
    widget._notifications.removeAt(index);
    widget._listStateKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: OptimusNotification(
          title: removedItem.title,
          body: removedItem.body,
          icon: removedItem.icon,
          link: removedItem.link,
          onLinkPressed: () {},
          onDismissed: () {},
          variant: removedItem.variant,
        ),
      ),
    );
  }
}

class _NotificationModel {
  _NotificationModel({
    required this.title,
    this.body,
    this.icon,
    this.link,
    required this.variant,
    this.onLinkPressed,
    this.onDismissed,
  });
  final String title;
  final String? body;
  final IconData? icon;
  final String? link;
  final OptimusNotificationVariant variant;
  final VoidCallback? onLinkPressed;
  final VoidCallback? onDismissed;
}
