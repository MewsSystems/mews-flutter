import 'dart:math';

import 'package:flutter/material.dart';
import 'package:optimus/src/common/anchored_overlay.dart';
import 'package:optimus/src/dropdown/common.dart';
import 'package:optimus/src/dropdown/dropdown_item.dart';
import 'package:optimus/src/dropdown/dropdown_tap_interceptor.dart';
import 'package:optimus/src/dropdown/dropdown_tile.dart';
import 'package:optimus/src/theme/theme.dart';

class DropdownListView<T> extends StatelessWidget {
  const DropdownListView({
    super.key,
    required this.onChanged,
    required this.items,
    required this.isReversed,
    required this.maxHeight,
  });

  final ValueSetter<T> onChanged;
  final List<OptimusDropdownTile<T>> items;
  final bool isReversed;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final minHeight = items.length * itemMinHeight + tokens.spacing100 * 2;

    return SizedBox(
      height: min(minHeight, maxHeight),
      child: ListView.builder(
        reverse: isReversed,
        padding: EdgeInsets.symmetric(vertical: tokens.spacing100),
        itemCount: items.length,
        itemBuilder:
            (context, index) => DropdownItem(
              width: AnchoredOverlay.of(context)?.width,
              height: itemMinHeight,
              onTap: () {
                onChanged(items[index].value);
                DropdownTapInterceptor.of(context)?.onTap();
              },
              child: items[index],
            ),
      ),
    );
  }
}
