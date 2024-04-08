import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/loader/painter.dart';
import 'package:optimus/src/loader/spinning_container.dart';

part 'loader.freezed.dart';

enum OptimusCircleLoaderSize {
  /// Small loader is intended to be used inside of the components like inputs
  /// or buttons where the space is limited.
  small,

  /// Medium loader is intended to be used for loading content or
  /// elements of medium size, like cards or panels.
  medium,

  /// Large 56px loader is intended to be used for loading content or elements
  /// without space constraints like layouts or pages.
  large,
}

@freezed
class OptimusCircleLoaderVariant with _$OptimusCircleLoaderVariant {
  /// The default option represents the progress that cannot be precisely
  /// calculated or otherwise determined.
  const factory OptimusCircleLoaderVariant.indeterminate() = Indeterminate;

  /// Use this option if the progress can be precisely measured, calculated, or
  /// otherwise determined against the specific action. The value shows the
  /// progress of the operation ranging from 0 to 100 until it is finished.
  const factory OptimusCircleLoaderVariant.determinate(double progress) =
      Determinate;
}

enum OptimusCircleLoaderAppearance {
  /// The normal option uses the primary blue color, and it is designed to be
  /// used over light backgrounds.
  normal,

  /// The contrast option uses the neutral white color, and it is designed to
  /// be used over the colored backgrounds.
  contrast,
}

/// The loader gives the user immediate feedback of the action or event being
/// processed and in progress. It shows the events like processing, uploading,
/// or downloading, and others.
class OptimusCircleLoader extends StatelessWidget {
  const OptimusCircleLoader({
    super.key,
    required this.variant,
    this.size = OptimusCircleLoaderSize.medium,
    this.appearance = OptimusCircleLoaderAppearance.normal,
  });

  /// Controls variant of the loader.
  final OptimusCircleLoaderVariant variant;

  /// Controls size of the loader.
  final OptimusCircleLoaderSize size;

  /// Controls appearance of the loader.
  final OptimusCircleLoaderAppearance appearance;

  double _getLoaderSize(OptimusTokens tokens) => switch (size) {
        OptimusCircleLoaderSize.small => tokens.sizing300,
        OptimusCircleLoaderSize.medium => tokens.sizing500,
        OptimusCircleLoaderSize.large => tokens.sizing700,
      };

  Color _getIndicatorColor(OptimusTokens tokens) => switch (appearance) {
        OptimusCircleLoaderAppearance.normal => tokens.backgroundAccentPrimary,
        OptimusCircleLoaderAppearance.contrast =>
          tokens.backgroundInteractiveNeutralBoldActive,
      };

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final trackColor = tokens.backgroundInteractiveNeutralActive;
    final indicatorColor = _getIndicatorColor(tokens);
    final size = _getLoaderSize(tokens);

    return SizedBox(
      height: size,
      width: size,
      child: variant.map(
        indeterminate: (_) => SpinningLoader(
          progress: 25,
          trackColor: trackColor,
          indicatorColor: indicatorColor,
        ),
        determinate: (v) => CustomPaint(
          foregroundPainter: CirclePainter(
            trackColor: trackColor,
            indicatorColor: indicatorColor,
            progress: v.progress,
          ),
        ),
      ),
    );
  }
}
