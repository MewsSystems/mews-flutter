import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimus/src/pictogram/pictograms.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/widget_size.dart';

/// Pictograms are a valuable tool for conveying information efficiently,
/// promoting interactivity, and simplifying complex concepts.
class OptimusPictogram extends StatelessWidget {
  const OptimusPictogram({
    super.key,
    required this.variant,
    this.size = OptimusWidgetSize.large,
  });

  /// The variant of the pictogram.
  final OptimusPictogramVariant variant;

  /// The size of the pictogram. Defaults to [OptimusWidgetSize.large]
  final OptimusWidgetSize size;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size.getValue(context.tokens),
        height: size.getValue(context.tokens),
        child: SvgPicture.asset(
          variant.path(context.theme.brightness),
          package: 'optimus',
        ),
      );
}
