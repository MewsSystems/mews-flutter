import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/common/gesture_detector.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/form/multiselect/multiselect_field.dart';
import 'package:optimus/src/form/multiselect/select_chip.dart';

class DropdownSelect<T> extends StatefulWidget {
  const DropdownSelect({
    super.key,
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
    this.leadingImplicit,
    this.trailing,
    this.trailingImplicit,
    this.caption,
    this.helperMessage,
    this.error,
    this.size = OptimusWidgetSize.large,
    this.isReadOnly = false,
    this.showCursor,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.shouldCloseOnInputTap = false,
    this.showLoader = false,
    this.isClearEnabled = false,
    this.useRootOverlay = false,
    this.emptyResultPlaceholder,
    this.embeddedSearch,
    this.onDropdownShow,
    this.onDropdownHide,
    this.groupBy,
    this.groupBuilder,
    this.allowMultipleSelection = false,
    this.selectedValues,
    this.builder,
    this.isCompact = false,
  });

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
  final Widget? helperMessage;
  final String? error;
  final OptimusWidgetSize size;
  final Widget? leading;
  final Widget? leadingImplicit;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? trailing;
  final Widget? trailingImplicit;
  final bool showLoader;
  final bool isClearEnabled;
  final FocusNode? focusNode;
  final bool shouldCloseOnInputTap;
  final bool useRootOverlay;
  final OptimusDropdownEmbeddedSearch? embeddedSearch;
  final Widget? emptyResultPlaceholder;
  final VoidCallback? onDropdownShow;
  final VoidCallback? onDropdownHide;
  final Grouper<T>? groupBy;
  final GroupBuilder? groupBuilder;
  final bool isCompact;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool isReadOnly;

  final bool allowMultipleSelection;
  final List<T>? selectedValues;
  final ValueBuilder<T>? builder;

  @override
  State<DropdownSelect<T>> createState() => _DropdownSelectState<T>();
}

class _DropdownSelectState<T> extends State<DropdownSelect<T>>
    with WidgetsBindingObserver {
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
    WidgetsBinding.instance.addObserver(this);
    _effectiveFocusNode.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    if (widget.embeddedSearch == null && _effectiveFocusNode.hasFocus) {
      _showOverlay();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _removeOverlay();
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

    if (oldWidget.isEnabled != widget.isEnabled) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
      _effectiveFocusNode.unfocus();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _handleOnBackPressed(bool didPop, _) {
    if (didPop) return;
    if (_effectiveFocusNode.hasFocus) {
      _effectiveFocusNode.unfocus();
    }
    final overlay = _overlayEntry;
    if (overlay != null) _removeOverlay();
  }

  bool get _canPop => !_effectiveFocusNode.hasFocus && _overlayEntry == null;

  void _showOverlay() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry().also((it) {
      Overlay.of(context, rootOverlay: widget.useRootOverlay).insert(it);
      widget.onDropdownShow?.call();
    });
    setState(() {});
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    widget.onDropdownHide?.call();
    _effectiveFocusNode.unfocus();
    setState(() {});
  }

  VoidCallback? get _onTap =>
      widget.embeddedSearch != null ? _showOverlay : null;

  void _handleClearAllTap() {
    _effectiveController.clear();
    widget.onTextChanged?.call('');
  }

  void _handleClose() => _removeOverlay();

  void _handleChipTap() {
    if (_effectiveFocusNode.hasFocus) {
      _removeOverlay();
    } else {
      _effectiveFocusNode.requestFocus();
    }
  }

  List<Widget>? get _values {
    if (widget.builder == null) return null;

    if (widget.builder case final builder?) {
      final selectedValues = widget.selectedValues;
      if (widget.isCompact &&
          selectedValues != null &&
          selectedValues.length > 2) {
        return selectedValues
            .take(2)
            .map(
              (e) => MultiselectChip(
                onRemoved: () => widget.onChanged(e),
                onTap: _handleChipTap,
                isEnabled: widget.isEnabled,
                text: builder(e),
              ),
            )
            .toList()
          ..add(MultiselectChip(
              text: '+${selectedValues.length - 2}',
              onTap: _handleChipTap,
              isEnabled: widget.isEnabled));
      }

      return widget.selectedValues
          ?.map(
            (e) => MultiselectChip(
              onRemoved: () => widget.onChanged(e),
              onTap: _handleChipTap,
              isEnabled: widget.isEnabled,
              text: builder(e),
            ),
          )
          .toList();
    }
  }

  bool? get _isFocused =>
      widget.embeddedSearch != null ? _overlayEntry != null : null;

  bool get _isClearAllButtonVisible =>
      widget.isClearEnabled && _effectiveController.text.isNotEmpty;

  bool get _hasValues {
    if (widget.selectedValues case final values?) {
      return values.isNotEmpty;
    }

    return false;
  }

  bool get _hasTrailing =>
      _isClearAllButtonVisible ||
      widget.trailing != null ||
      widget.trailingImplicit != null ||
      widget.isUpdating;

  bool get _hasLeading =>
      widget.leading != null || widget.leadingImplicit != null;

  OverlayEntry _createOverlayEntry() => OverlayEntry(
        builder: (context) {
          void handleTapDown(TapDownDetails details) {
            bool didHit(RenderBox box) => box.hitTest(
                  BoxHitTestResult(),
                  position: box.globalToLocal(details.globalPosition),
                );

            final RenderObject? inputFieldRenderObject =
                _fieldBoxKey.currentContext?.findRenderObject();
            final RenderObject? dropdownRenderObject =
                context.findRenderObject();
            if (dropdownRenderObject is RenderBox &&
                didHit(dropdownRenderObject)) {
              // Touch on dropdown shouldn't close overlay
            } else if (inputFieldRenderObject is RenderBox &&
                didHit(inputFieldRenderObject)) {
              if (widget.shouldCloseOnInputTap) _removeOverlay();
            } else {
              _removeOverlay();
            }
          }

          return AllowMultipleRawGestureDetector(
            key: const Key('OptimusDropdownOverlay'),
            behavior: HitTestBehavior.translucent,
            onTapDown: handleTapDown,
            child: DropdownTapInterceptor(
              onTap: widget.allowMultipleSelection ? () {} : _handleClose,
              child: OptimusDropdown(
                items: widget.items,
                size: widget.size,
                anchorKey: _fieldBoxKey,
                onChanged: widget.onChanged,
                embeddedSearch: widget.embeddedSearch,
                emptyResultPlaceholder: widget.emptyResultPlaceholder,
                groupBy: widget.groupBy,
                groupBuilder: widget.groupBuilder,
              ),
            ),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    final clearAll = _isClearAllButtonVisible
        ? _ClearAllButton(onTap: _handleClearAllTap)
        : null;
    final trailing = _hasTrailing
        ? _Trailing(
            focusNode: _effectiveFocusNode,
            clearAllButton: clearAll,
            trailing: widget.trailing,
            trailingImplicit: widget.trailingImplicit,
            isUpdating: widget.isUpdating,
          )
        : null;
    final leading = _hasLeading
        ? _Leading(
            leading: widget.leading,
            leadingImplicit: widget.leadingImplicit,
            focusNode: _effectiveFocusNode,
          )
        : null;

    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: _handleOnBackPressed,
      child: widget.allowMultipleSelection && _hasValues
          ? MultiSelectInputField(
              values: _values ?? [],
              leading: leading,
              prefix: widget.prefix,
              isRequired: widget.isRequired,
              label: widget.label,
              focusNode: _effectiveFocusNode,
              isFocused: _isFocused,
              fieldBoxKey: _fieldBoxKey,
              suffix: widget.suffix,
              trailing: trailing,
              isEnabled: widget.isEnabled,
              caption: widget.caption,
              helperMessage: widget.helperMessage,
              error: widget.error,
              size: widget.size,
              showLoader: widget.showLoader,
            )
          : OptimusInputField(
              leading: leading,
              prefix: widget.prefix,
              controller: _effectiveController,
              onChanged: widget.onTextChanged,
              isRequired: widget.isRequired,
              label: widget.label,
              placeholder: widget.placeholder,
              placeholderStyle: widget.placeholderStyle,
              focusNode: _effectiveFocusNode,
              isFocused: _isFocused,
              onTap: _onTap,
              fieldBoxKey: _fieldBoxKey,
              suffix: widget.suffix,
              trailing: trailing,
              isEnabled: widget.isEnabled,
              caption: widget.caption,
              helperMessage: widget.helperMessage,
              error: widget.error,
              size: widget.size,
              isReadOnly: widget.isReadOnly,
              showCursor: widget.showCursor,
              showLoader: widget.showLoader,
            ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({this.leading, this.leadingImplicit, required this.focusNode});

  final Widget? leading;
  final Widget? leadingImplicit;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: (_) => focusNode.requestFocus(),
        child: OptimusStack(
          direction: Axis.horizontal,
          spacing: OptimusStackSpacing.spacing100,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingImplicit case final leadingImplicit?) leadingImplicit,
            if (leading case final leading?) leading,
          ],
        ),
      );
}

class _Trailing extends StatelessWidget {
  const _Trailing({
    required this.focusNode,
    this.clearAllButton,
    this.trailing,
    this.trailingImplicit,
    required this.isUpdating,
  });

  final FocusNode focusNode;
  final Widget? clearAllButton;
  final Widget? trailing;
  final Widget? trailingImplicit;
  final bool isUpdating;

  @override
  Widget build(BuildContext context) {
    final children = isUpdating
        ? [const OptimusSpinner(size: OptimusSpinnerSize.small)]
        : [
            if (trailing case final trailing?) trailing,
            if (trailingImplicit case final trailingImplicit?) trailingImplicit,
          ];

    return GestureDetector(
      onTapDown: (_) => focusNode.requestFocus(),
      child: OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (clearAllButton case final clearAllButton?) clearAllButton,
          ...children,
        ],
      ),
    );
  }
}

class _ClearAllButton extends StatelessWidget {
  const _ClearAllButton({required this.onTap});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => AllowMultipleRawGestureDetector(
        onTap: onTap,
        child: Icon(
          OptimusIcons.cross_close,
          size: context.tokens.sizing200,
          color: context.tokens.textStaticPrimary,
        ),
      );
}
