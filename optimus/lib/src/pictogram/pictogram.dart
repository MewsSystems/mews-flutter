import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimus/optimus.dart';

enum OptimusPictogramSize { small, medium, large }

/// Pictograms are a valuable tool for conveying information efficiently,
/// promoting interactivity, and simplifying complex concepts.
class OptimusPictogram extends StatelessWidget {
  const OptimusPictogram({
    super.key,
    required this.variant,
    this.size = OptimusPictogramSize.large,
    this.semanticsLabel,
  });

  /// The variant of the pictogram.
  final OptimusPictogramVariant variant;

  /// The size of the pictogram. Defaults to [OptimusPictogramSize.large]
  final OptimusPictogramSize size;

  /// The semantics label for the pictogram. Defaults to the english name of
  /// the pictogram variant. We suggest using a localized string for better
  /// accessibility.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    label: semanticsLabel ?? variant.name.replaceAll('_', ' '),
    child: SizedBox.square(
      dimension: size.getSize(context.tokens),
      child: SvgPicture.asset(
        variant.path(context.theme.brightness),
        package: 'optimus',
      ),
    ),
  );
}

extension on OptimusPictogramSize {
  double getSize(OptimusTokens tokens) => switch (this) {
    OptimusPictogramSize.small => tokens.sizing600,
    OptimusPictogramSize.medium => tokens.sizing800,
    OptimusPictogramSize.large => tokens.sizing1000,
  };
}
