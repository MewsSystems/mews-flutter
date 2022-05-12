import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/dropdown.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';

class OptimusSearch<T> extends StatefulWidget {
  const OptimusSearch({
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
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool shouldCloseOnInputTap;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  @override
  State<OptimusSearch<T>> createState() => _OptimusSearchState<T>();
}

class _OptimusSearchState<T> extends State<OptimusSearch<T>> {
  final _fieldBoxKey = GlobalKey();

  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_onFocusChanged);

    WidgetsBinding.instance.addPostFrameCallback(_afterLayoutBuild);
  }

  void _onFocusChanged() {
    if (_effectiveFocusNode.hasFocus) {
      WidgetsBinding.instance.addPostFrameCallback(_afterLayoutWithShow);
    } else {
      setState(_removeOverlay);
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusSearch<T> oldWidget) {
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
    }

    return true;
  }

  void _createOverlay() => _overlayEntry = _createOverlayEntry();

  void _showOverlay() {
    final overlayEntry = _overlayEntry;
    if (overlayEntry != null) {
      Overlay.of(context, rootOverlay: true)?.insert(overlayEntry);
    }
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _effectiveFocusNode.unfocus();
  }

  void _afterLayoutBuild(dynamic _) {
    if (!mounted) return;
    _createOverlay();
  }

  void _afterLayoutWithShow(dynamic _) {
    if (!mounted) return;
    _createOverlay();
    _showOverlay();
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
            key: const Key('OptimusSearchOverlay'),
            behavior: HitTestBehavior.translucent,
            onTapDown: onTapDown,
            child: DropdownTapInterceptor(
              onTap: _removeOverlay,
              child: OptimusDropdown(
                items: widget.items,
                anchorKey: _fieldBoxKey,
                onChanged: widget.onChanged,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _handleOnBackPressed,
        child: OptimusInputField(
          prefix: widget.prefix,
          controller: widget.controller,
          onChanged: widget.onTextChanged,
          isRequired: widget.isRequired,
          label: widget.label,
          placeholder: widget.placeholder,
          placeholderStyle: widget.placeholderStyle,
          focusNode: _effectiveFocusNode,
          fieldBoxKey: _fieldBoxKey,
          suffix: widget.isUpdating
              ? const OptimusProgressSpinner()
              : widget.suffix ?? const _Icon(),
          isEnabled: widget.isEnabled,
          caption: widget.caption,
          secondaryCaption: widget.secondaryCaption,
          error: widget.error,
          size: widget.size,
          readOnly: widget.readOnly,
          showCursor: widget.showCursor,
        ),
      );
}

class _Icon extends StatelessWidget {
  const _Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Icon(
      OptimusIcons.search,
      size: 24,
      color: theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000t64,
    );
  }
}
