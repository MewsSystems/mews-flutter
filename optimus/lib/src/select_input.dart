import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/dropdown/dropdown_select.dart';
import 'package:optimus/src/typography/presets.dart';

typedef ValueBuilder<T> = String Function(T value);

/// Select allows users to enter or select one or multiple options from
/// the list of available options.
///
/// The list opens as a dropdown menu, and it is available in many variations.
/// This select component is most commonly found in form patterns.
class OptimusSelectInput<T> extends StatefulWidget {
  const OptimusSelectInput({
    super.key,
    this.label,
    this.placeholder = '',
    this.value,
    required this.items,
    required this.builder,
    this.isEnabled = true,
    this.isRequired = false,
    this.leading,
    this.prefix,
    this.trailing,
    this.suffix,
    this.caption,
    this.secondaryCaption,
    this.error,
    this.size = OptimusWidgetSize.large,
    required this.onChanged,
    this.controller,
    this.onTextChanged,
    this.focusNode,
    this.readOnly,
    this.showLoader = false,
    this.emptyResultPlaceholder,
    this.embeddedSearch,
    this.groupBy,
    this.groupBuilder,
    this.multiselect = false,
    this.selectedValues,
  });

  /// Describes the purpose of the select field.
  ///
  /// The input should always include this description (with exceptions).
  final String? label;
  final String placeholder;
  final T? value;
  final List<OptimusDropdownTile<T>> items;
  final bool isEnabled;
  final bool isRequired;
  final Widget? leading;
  final Widget? prefix;
  final Widget? trailing;
  final Widget? suffix;
  final bool showLoader;
  final FocusNode? focusNode;

  /// Serves as a helper text for informative or descriptive purposes.
  final Widget? caption;
  final Widget? secondaryCaption;
  final String? error;
  final OptimusWidgetSize size;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final TextEditingController? controller;
  final ValueSetter<String>? onTextChanged;
  final bool? readOnly;

  /// An embedded search field that can be used to filter the list of items.
  /// Will be displayed as a part of the dropdown menu. If the [controller] or
  /// [onTextChanged] is provided, the embedded search will not be used. Instead
  /// the search will be a part of the input field.
  final OptimusDropdownEmbeddedSearch? embeddedSearch;

  /// A widget that is displayed when the list of items is empty. If not
  /// provided the dropdown will not be displayed.
  final Widget? emptyResultPlaceholder;

  /// {@template optimus.select.groupBy}
  /// A function that would retrieve value for the grouping.
  /// {@endtemplate}
  final Grouper<T>? groupBy;

  /// {@template optimus.select.groupBuilder}
  /// A builder that would create a group header. If not provided the
  /// [OptimusDropdownGroupSeparator] widget will be used.
  /// {@endtemplate}
  final GroupBuilder? groupBuilder;

  /// If enabled, you can select multiple items at the same time.
  /// State of the selected items is managed outside this widget and has to be
  /// set in [selectedValues].
  final bool multiselect;

  /// List of selected values. Would be omitted if the multiselect is disabled.
  final List<T>? selectedValues;

  @override
  State<OptimusSelectInput<T>> createState() => _OptimusSelectInput<T>();
}

class _OptimusSelectInput<T> extends State<OptimusSelectInput<T>>
    with ThemeGetter, SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.fastOutSlowIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  late final AnimationController _animationController;
  late final Animation<double> _iconTurns;

  TextEditingController? _controller;
  FocusNode? _focusNode;

  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  void _handleFocusChange() {
    if (!_isUsingEmbeddedSearch) {
      if (_effectiveFocusNode.hasFocus) {
        _animationController.forward();
      } else {
        setState(() => _effectiveController.text = '');
        _animationController.reverse();
      }
    }
  }

  void _handleTextUpdate() =>
      widget.onTextChanged?.call(_effectiveController.text);

  @override
  void didUpdateWidget(OptimusSelectInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _effectiveController
        ..removeListener(_handleTextUpdate)
        ..addListener(_handleTextUpdate);
    }
  }

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
    _effectiveController.addListener(_handleTextUpdate);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _focusNode?.dispose();
    _effectiveController.removeListener(_handleTextUpdate);
    _controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool get _isUsingInlineSearch =>
      widget.controller != null || widget.onTextChanged != null;

  bool get _isUsingEmbeddedSearch =>
      widget.embeddedSearch != null && !_isUsingInlineSearch;

  TextStyle get _textStyle => switch (widget.size) {
        OptimusWidgetSize.small => preset200s.copyWith(color: _textColor),
        OptimusWidgetSize.medium ||
        OptimusWidgetSize.large =>
          preset300s.copyWith(color: _textColor),
      };

  Color get _textColor =>
      _value == null ? _placeholderColor : _defaultTextColor;

  Color get _placeholderColor =>
      theme.isDark ? theme.colors.neutral0t64 : theme.colors.neutral1000t64;

  Color get _defaultTextColor =>
      theme.isDark ? theme.colors.neutral0 : theme.colors.neutral1000;

  T? get _value => widget.multiselect ? null : widget.value;

  @override
  Widget build(BuildContext context) => DropdownSelect<T>(
        label: widget.label,
        placeholder: _value?.let(widget.builder) ?? widget.placeholder,
        items: widget.items,
        isEnabled: widget.isEnabled,
        isRequired: widget.isRequired,
        caption: widget.caption,
        helperMessage: widget.secondaryCaption,
        error: widget.error,
        size: widget.size,
        onChanged: widget.onChanged,
        prefix: widget.prefix,
        leading: widget.leading,
        suffix: widget.suffix,
        trailing: widget.trailing,
        trailingImplicit:
            RotationTransition(turns: _iconTurns, child: const _Chevron()),
        focusNode: _effectiveFocusNode,
        placeholderStyle: _textStyle,
        controller: _effectiveController,
        readOnly: widget.readOnly ?? !_isUsingInlineSearch,
        showCursor: _isUsingInlineSearch,
        showLoader: widget.showLoader,
        shouldCloseOnInputTap: !widget.multiselect || !_isUsingInlineSearch,
        emptyResultPlaceholder: widget.emptyResultPlaceholder,
        embeddedSearch: _isUsingEmbeddedSearch ? widget.embeddedSearch : null,
        onDropdownShow:
            _isUsingEmbeddedSearch ? _animationController.forward : null,
        onDropdownHide:
            _isUsingEmbeddedSearch ? _animationController.reverse : null,
        groupBy: widget.groupBy,
        groupBuilder: widget.groupBuilder,
        multiselect: widget.multiselect,
        selectedValues: widget.selectedValues,
        builder: widget.builder,
      );
}

class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);
    final color =
        theme.isDark ? theme.colors.neutral0 : theme.colors.neutral400;

    return Icon(OptimusIcons.chevron_down, size: 24, color: color);
  }
}
