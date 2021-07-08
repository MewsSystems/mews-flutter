import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/dropdown.dart';
import 'package:optimus/src/progress_spinner.dart';
import 'package:optimus/src/search/dropdown_tap_interceptor.dart';
import 'package:optimus/src/search/dropdown_tile.dart';

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

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  @override
  _OptimusSearchState createState() => _OptimusSearchState<T>();
}

class _OptimusSearchState<T> extends State<OptimusSearch<T>> {
  final _fieldBoxKey = GlobalKey();

  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);

    WidgetsBinding.instance?.addPostFrameCallback(_afterLayoutBuild);
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      WidgetsBinding.instance?.addPostFrameCallback(_afterLayoutWithShow);
    } else {
      setState(_removeOverlay);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(OptimusSearch<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry?.markNeedsBuild();
    });
  }

  bool get _isSearchable =>
      widget.controller != null || widget.onTextChanged != null;

  void _onItemSelected() {
    _removeOverlay();
    _focusNode.unfocus();
  }

  Future<bool> _handleOnBackPressed() async {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
      return false;
    }
    return true;
  }

  void _createOverlay() => _overlayEntry = _createOverlayEntry();

  void _showOverlay() {
    if (_overlayEntry != null) {
      Overlay.of(context, rootOverlay: true)?.insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _afterLayoutBuild(Duration d) {
    if (!mounted) return;
    _createOverlay();
  }

  void _afterLayoutWithShow(Duration d) {
    if (!mounted) return;
    _createOverlay();
    _showOverlay();
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (details) {
            bool hitTest(RenderBox box) => box.hitTest(
                  BoxHitTestResult(),
                  position: box.globalToLocal(details.globalPosition),
                );

            final RenderBox inputFieldBox =
                _fieldBoxKey.currentContext?.findRenderObject() as RenderBox;
            final dropdownBox = context.findRenderObject() as RenderBox;

            final shouldCountInputFieldHit =
                hitTest(inputFieldBox) && _isSearchable;

            if (!shouldCountInputFieldHit && !hitTest(dropdownBox)) {
              _removeOverlay();
              _focusNode.unfocus();
            }
          },
          child: DropdownTapInterceptor(
            onTap: _onItemSelected,
            child: OptimusDropdown(
              items: widget.items,
              anchorKey: _fieldBoxKey,
              onChanged: widget.onChanged,
            ),
          ),
        ),
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
          focusNode: _focusNode,
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
