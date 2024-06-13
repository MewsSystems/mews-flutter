import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_item.dart';
import 'package:optimus/src/theme/theme.dart';

class HorizontalProgressIndicator extends StatefulWidget {
  const HorizontalProgressIndicator({
    super.key,
    required this.layout,
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final Axis layout;
  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;

  @override
  State<HorizontalProgressIndicator> createState() =>
      _HorizontalProgressIndicatorState();
}

class _HorizontalProgressIndicatorState
    extends State<HorizontalProgressIndicator> with ThemeGetter {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final effectiveWidth = constraints.maxWidth;
          final itemWidth = effectiveWidth / widget.items.length;
          final firstRowHeight = tokens.sizing400;
          final firstRowItemSize = tokens.sizing300;
          final firstRowHorizontalPadding =
              itemWidth / 2 - firstRowItemSize / 2;

          return SizedBox(
            width: effectiveWidth,
            child: Stack(
              children: [
                if (widget.items.length > 1)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: firstRowHorizontalPadding,
                    ),
                    child: SizedBox(
                      height: firstRowHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.items
                            .intersperseWith(
                              itemBuilder: (_) =>
                                  SizedBox(width: firstRowItemSize),
                              separatorBuilder: (_, nextItem) => Expanded(
                                child: ProgressIndicatorSpacer(
                                  nextItemState: widget.items.getIndicatorState(
                                    item: nextItem,
                                    currentItem: widget.currentItem,
                                    maxItem: widget.maxItem,
                                  ),
                                  layout: Axis.horizontal,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                Row(
                  children: [
                    for (final item in widget.items)
                      SizedBox(
                        width: itemWidth,
                        height: constraints.maxHeight,
                        child: ProgressIndicatorItem(
                          state: widget.items.getIndicatorState(
                            item: item,
                            currentItem: widget.currentItem,
                            maxItem: widget.maxItem,
                          ),
                          text: widget.items.getIndicatorText(item),
                          label: item.label,
                          description: item.description,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
}
