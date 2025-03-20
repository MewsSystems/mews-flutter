import 'package:flutter/widgets.dart';
import 'package:optimus/src/common/gesture_wrapper.dart';
import 'package:optimus/src/common/value_builder.dart';
import 'package:optimus/src/dropdown/dropdown_tile.dart';
import 'package:optimus/src/form/drawer/common.dart';
import 'package:optimus/src/form/input_field.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/widget_size.dart';

class DrawerBottomSheet<T> extends StatefulWidget {
  const DrawerBottomSheet({
    super.key,
    this.label,
    required this.builder,
    required this.onChanged,
    this.placeholder = '',
    this.onClosed,
    this.controller,
    required this.listBuilder,
    this.isSearchable = false,
    this.shouldCloseOnSelection = true,
    this.searchInputSize = OptimusWidgetSize.large,
  });

  final String? label;
  final ValueBuilder<T> builder;
  final ValueSetter<T> onChanged;
  final String placeholder;
  final VoidCallback? onClosed;
  final TextEditingController? controller;
  final OptimusDrawerListBuilder<T> listBuilder;
  final bool isSearchable;
  final bool shouldCloseOnSelection;
  final OptimusWidgetSize searchInputSize;

  @override
  State<DrawerBottomSheet<T>> createState() => _DrawerBottomSheetState<T>();
}

class _DrawerBottomSheetState<T> extends State<DrawerBottomSheet<T>> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _effectiveController.addListener(_handleChange);
  }

  void _handleChange() => setState(() {});

  @override
  void dispose() {
    _effectiveController.removeListener(_handleChange);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DrawerBottomSheet<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSearchable != widget.isSearchable) {
      _effectiveController.clear();
    }
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleChange);
      widget.controller?.addListener(_handleChange);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final items = widget.listBuilder(
      widget.isSearchable ? _effectiveController.text : '',
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.backgroundStaticFloating,
        borderRadius: BorderRadius.vertical(top: tokens.borderRadius300),
      ),
      child: Column(
        children: [
          const _DrawerHeader(),
          if (widget.label case final label?) _DrawerLabel(label: label),
          if (widget.isSearchable)
            OptimusInputField(
              size: widget.searchInputSize,
              placeholder: widget.placeholder,
              controller: _effectiveController,
            ),
          SizedBox(height: tokens.spacing200),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: tokens.spacing25,
                horizontal: tokens.spacing150,
              ),
              itemCount: items.length,
              itemBuilder:
                  (context, index) => _DrawerItem(
                    item: items[index],
                    onTap: () {
                      widget.onChanged(items[index].value);
                      setState(() {});
                      if (widget.shouldCloseOnSelection) {
                        Navigator.of(context).pop();
                        widget.onClosed?.call();
                      }
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem<T> extends StatefulWidget {
  const _DrawerItem({
    required this.item,
    this.isEnabled = true,
    required this.onTap,
  });

  final OptimusDropdownTile<T> item;
  final bool isEnabled;
  final VoidCallback onTap;

  @override
  State<_DrawerItem<T>> createState() => _DrawerItemState<T>();
}

class _DrawerItemState<T> extends State<_DrawerItem<T>> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing50),
      child: GestureWrapper(
        onHoverChanged: (isHovered) => setState(() => _isHovered = isHovered),
        onPressedChanged: (isPressed) => setState(() => _isPressed = isPressed),
        onTap: widget.onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(tokens.borderRadius100),
            color:
                _isPressed
                    ? tokens.backgroundInteractiveNeutralSubtleActive
                    : _isHovered
                    ? tokens.backgroundInteractiveNeutralSubtleHover
                    : null,
          ),
          child: widget.item,
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: context.tokens.spacing150,
      bottom: context.tokens.spacing400,
    ),
    child: SizedBox(
      height: context.tokens.spacing50,
      child: Row(
        children: [
          const Spacer(),
          Container(
            width:
                context.tokens.sizing100 * 12, // TODO(witwash): missing tokens
            decoration: BoxDecoration(
              color: context.tokens.borderStaticPrimary,
              borderRadius: BorderRadius.all(context.tokens.borderRadius50),
            ),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}

class _DrawerLabel extends StatelessWidget {
  const _DrawerLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: context.tokens.titleMediumStrong.copyWith(
      color: context.tokens.textStaticPrimary,
    ),
  );
}
