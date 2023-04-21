import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';

class DropdownSelect<T> extends StatefulWidget {
  const DropdownSelect({
    Key? key,
    this.label,
    this.placeholder = '',
    this.placeholderStyle,
    this.controller,
    this.onTextChanged,
    required this.items,
    this.isUpdating = false,
    this.isEnabled = true,
    this.isRequired = false,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.trailingImplicit,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    this.readOnly = false,
    this.showCursor,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.shouldCloseOnInputTap = false,
    this.showLoader = false,
    this.isClearEnabled = false,
    this.rootOverlay = false,
    this.emptyResultPlaceholder,
    this.embeddedSearch,
    this.onDropdownShow,
    this.onDropdownHide,
  }) : super(key: key);

  final String? label;
  final String placeholder;
  final TextStyle? placeholderStyle;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isUpdating;
  final bool isEnabled;
  final bool isRequired;
  final ValueSetter<T> onChanged;
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final Widget? leading;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? trailing;
  final Widget? trailingImplicit;
  final bool showLoader;
  final bool isClearEnabled;
  final FocusNode? focusNode;
  final bool shouldCloseOnInputTap;
  final bool rootOverlay;
  final OptimusDropdownEmbeddedSearch? embeddedSearch;
  final Widget? emptyResultPlaceholder;
  final VoidCallback? onDropdownShow;
  final VoidCallback? onDropdownHide;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  @override
  State<DropdownSelect<T>> createState() => _DropdownSelectState<T>();
}

class _DropdownSelectState<T> extends State<DropdownSelect<T>> {
  final _fieldBoxKey = GlobalKey();

  FocusNode? _focusNode;
  TextEditingController? _controller;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (_effectiveFocusNode.hasFocus) {
      _showOverlay();
    } else {
      if (widget.embeddedSearch == null) _removeOverlay();
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DropdownSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.focusNode != widget.focusNode) {
      _effectiveFocusNode
        ..removeListener(_onFocusChanged)
        ..addListener(_onFocusChanged);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry?.markNeedsBuild();
    });
  }

  Future<bool> _handleOnBackPressed() async {
    if (_effectiveFocusNode.hasFocus) {
      _effectiveFocusNode.unfocus();

      return false;
    } else if (widget.embeddedSearch != null) {
      final overlay = _overlayEntry;
      if (overlay != null) {
        _removeOverlay();

        return false;
      }
    }

    return true;
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry().also((it) {
      Overlay.of(context, rootOverlay: widget.rootOverlay).insert(it);
      widget.onDropdownShow?.call();
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    widget.onDropdownHide?.call();
    setState(() {});
  }

  void _onClearAllTap() {
    _effectiveController.clear();
    widget.onTextChanged?.call('');
  }

  bool? get _isFocused =>
      widget.embeddedSearch != null ? _overlayEntry != null : null;

  bool get _isClearAllButtonVisible =>
      widget.isClearEnabled && _effectiveController.text.isNotEmpty;

  Widget? get _clearAllButton =>
      _isClearAllButtonVisible ? _ClearAllButton(onTap: _onClearAllTap) : null;

  List<Widget> _buildTrailingWidgets() {
    final trailing = widget.trailing;
    final trailingImplicit = widget.trailingImplicit;
    if (widget.isUpdating) {
      return [const OptimusProgressSpinner()];
    } else {
      return [
        if (trailing != null) trailing,
        if (trailingImplicit != null) trailingImplicit,
      ];
    }
  }

  Widget? get _trailing {
    final clearAll = _clearAllButton;
    final trailingWidgets = _buildTrailingWidgets();
    if (clearAll == null && trailingWidgets.isEmpty) return null;

    return GestureDetector(
      onTapDown: (_) => _effectiveFocusNode.requestFocus(),
      child: OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (clearAll != null) clearAll,
          ...trailingWidgets,
        ],
      ),
    );
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) {
          void onTapDown(TapDownDetails details) {
            bool hitTest(RenderBox box) => box.hitTest(
                  BoxHitTestResult(),
                  position: box.globalToLocal(details.globalPosition),
                );

            final RenderObject? inputFieldRenderObject =
                _fieldBoxKey.currentContext?.findRenderObject();
            final RenderObject? dropdownRenderObject =
                context.findRenderObject();
            if (dropdownRenderObject is RenderBox &&
                hitTest(dropdownRenderObject)) {
              // Touch on dropdown shouldn't close overlay
            } else if (inputFieldRenderObject is RenderBox &&
                hitTest(inputFieldRenderObject)) {
              if (widget.shouldCloseOnInputTap) _removeOverlay();
            } else {
              _removeOverlay();
            }
          }

          return GestureDetector(
            key: const Key('OptimusDropdownOverlay'),
            behavior: HitTestBehavior.translucent,
            onTapDown: onTapDown,
            child: DropdownTapInterceptor(
              onTap: _removeOverlay,
              child: OptimusDropdown(
                items: widget.items,
                anchorKey: _fieldBoxKey,
                onChanged: widget.onChanged,
                embeddedSearch: widget.embeddedSearch,
                emptyResultPlaceholder: widget.emptyResultPlaceholder,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _handleOnBackPressed,
        child: OptimusInputField(
          leading: widget.leading,
          prefix: widget.prefix,
          controller: _effectiveController,
          onChanged: widget.onTextChanged,
          isRequired: widget.isRequired,
          label: widget.label,
          placeholder: widget.placeholder,
          placeholderStyle: widget.placeholderStyle,
          focusNode: _effectiveFocusNode,
          isFocused: _isFocused,
          fieldBoxKey: _fieldBoxKey,
          suffix: widget.suffix,
          trailing: _trailing,
          isEnabled: widget.isEnabled,
          caption: widget.caption,
          secondaryCaption: widget.secondaryCaption,
          error: widget.error,
          size: widget.size,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
          showLoader: widget.showLoader,
        ),
      );
}

class _ClearAllButton extends StatelessWidget {
  const _ClearAllButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return _CustomRawGestureDetector(
      onTap: onTap,
      child: Icon(
        OptimusIcons.clear_selection,
        size: 24,
        color: theme.colors.neutral100,
      ),
    );
  }
}

class _CustomRawGestureDetector extends RawGestureDetector {
  _CustomRawGestureDetector({
    Key? key,
    GestureTapCallback? onTap,
    Widget? child,
  }) : super(
          key: key,
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            _AllowMultipleGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    _AllowMultipleGestureRecognizer>(
              _AllowMultipleGestureRecognizer.new,
              (_AllowMultipleGestureRecognizer instance) =>
                  instance.onTap = onTap,
            ),
          },
          child: child,
        );
}

class _AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
