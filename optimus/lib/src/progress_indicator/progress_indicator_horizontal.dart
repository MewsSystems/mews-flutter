import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/progress_indicator/progress_indicator_item.dart';
import 'package:optimus/src/theme/theme.dart';

class HorizontalProgressIndicator extends StatelessWidget {
  const HorizontalProgressIndicator({
    super.key,
    required this.items,
    required this.currentItem,
    this.maxItem,
  });

  final List<OptimusProgressIndicatorItem> items;
  final int currentItem;
  final int? maxItem;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final tokens = context.tokens;
          final effectiveWidth = constraints.maxWidth;
          final itemWidth = effectiveWidth / items.length;
          final firstRowHeight = tokens.sizing400;
          final firstRowItemSize = tokens.sizing300;
          final firstRowHorizontalPadding =
              itemWidth / 2 - firstRowItemSize / 2;

          return SizedBox(
            width: effectiveWidth,
            child: Stack(
              children: [
                if (items.length > 1)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: firstRowHorizontalPadding,
                    ),
                    child: SizedBox(
                      height: firstRowHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: items
                            .intersperseWith(
                              itemBuilder: (_) =>
                                  SizedBox(width: firstRowItemSize),
                              separatorBuilder: (_, nextItem) => Expanded(
                                child: ProgressIndicatorSpacer(
                                  nextItemState: items.getIndicatorState(
                                    item: nextItem,
                                    currentItem: currentItem,
                                    maxItem: maxItem,
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
                    for (final item in items)
                      SizedBox(
                        width: itemWidth,
                        height: constraints.maxHeight,
                        child: ProgressIndicatorItem(
                          state: items.getIndicatorState(
                            item: item,
                            currentItem: currentItem,
                            maxItem: maxItem,
                          ),
                          text: items.getIndicatorText(item),
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
