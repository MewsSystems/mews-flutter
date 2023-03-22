import 'dart:async';

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
      _removeOverlay();
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
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
    }

    return true;
  }

  void _createOverlay() => _overlayEntry = _createOverlayEntry();

  void _showOverlay() {
    final overlayEntry = _overlayEntry;
    if (overlayEntry != null) {
      Overlay.of(context, rootOverlay: widget.rootOverlay).insert(overlayEntry);
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

  Widget? get _trailing => widget.isUpdating
      ? const OptimusProgressSpinner()
      : widget.trailingImplicit != null
          ? _TrailingStack(
              trailing: widget.trailing,
              trailingImplicit: GestureDetector(
                onTapDown: (_) => _effectiveFocusNode.requestFocus(),
                child: widget.trailingImplicit,
              ),
            )
          : widget.trailing;

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
          leading: widget.leading,
          prefix: widget.prefix,
          controller: widget.controller,
          onChanged: widget.onTextChanged,
          isRequired: widget.isRequired,
          label: widget.label,
          placeholder: widget.placeholder,
          placeholderStyle: widget.placeholderStyle,
          focusNode: _effectiveFocusNode,
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
          isClearEnabled: widget.isClearEnabled,
        ),
      );
}

class _TrailingStack extends StatelessWidget {
  const _TrailingStack({
    Key? key,
    required this.trailing,
    required this.trailingImplicit,
  }) : super(key: key);

  final Widget? trailing;
  final Widget trailingImplicit;

  @override
  Widget build(BuildContext context) {
    final trailingWidget = trailing;

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailingWidget != null) trailingWidget,
        trailingImplicit,
      ],
    );
  }
}
