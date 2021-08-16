import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/loader/determined_painter.dart';
import 'package:optimus/src/loader/indeterminate_painter.dart';

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

enum OptimusCircleLoaderVariant {
  /// The default option represents the progress that cannot be precisely
  /// calculated or otherwise determined.
  indeterminate,

  /// Use this option if the progress can be precisely measured, calculated, or
  /// otherwise determined against the specific action. The value shows the
  /// progress of the operation ranging from 0 to 100 until it is finished.
  determinate,
}

enum OptimusCircleLoaderAppearance {
  /// The normal option uses the primary blue color, and it is designed to be
  /// used over light backgrounds.
  normal,

  /// The inverted option uses the neural white color, and it is designed to be
  /// used over the colored backgrounds.
  contrast,
}

/// The loader gives the user immediate feedback of the action or event being
/// processed and in progress. It shows the events like processing, uploading,
/// or downloading, and others.
class OptimusCircleLoader extends StatelessWidget {
  const OptimusCircleLoader({
    Key? key,
    this.progress,
    this.size = OptimusCircleLoaderSize.medium,
    this.variant = OptimusCircleLoaderVariant.indeterminate,
    this.appearance = OptimusCircleLoaderAppearance.normal,
  })  : assert(
          (progress == null &&
                  variant == OptimusCircleLoaderVariant.indeterminate) ||
              (progress != null &&
                  variant == OptimusCircleLoaderVariant.determinate),
          'indeterminate circle loader should not have defined progress',
        ),
        assert(
          progress == null || progress >= 0 && progress <= 100,
          'progress should either be null or in [0, 100] range',
        ),
        super(key: key);

  /// Controls progress of the loader.
  final double? progress;

  /// Controls size of the loader.
  final OptimusCircleLoaderSize size;

  /// Controls variant of the loader.
  final OptimusCircleLoaderVariant variant;

  /// Controls appearance of the loader.
  final OptimusCircleLoaderAppearance appearance;

  double get _loaderSize {
    switch (size) {
      case OptimusCircleLoaderSize.small:
        return 24;
      case OptimusCircleLoaderSize.medium:
        return 40;
      case OptimusCircleLoaderSize.large:
        return 56;
    }
  }

  Color _getIndicatorColor(OptimusThemeData theme) {
    switch (appearance) {
      case OptimusCircleLoaderAppearance.normal:
        return theme.colors.primary500;
      case OptimusCircleLoaderAppearance.contrast:
        return theme.colors.neutral0;
    }
  }

  Color _getTrackColor(OptimusThemeData theme) {
    switch (appearance) {
      case OptimusCircleLoaderAppearance.normal:
        return theme.colors.neutral50;
      case OptimusCircleLoaderAppearance.contrast:
        return theme.colors.neutral1000t32;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = OptimusTheme.of(context);

    return Container(
      height: _loaderSize,
      width: _loaderSize,
      child: CustomPaint(
        foregroundPainter: variant == OptimusCircleLoaderVariant.determinate
            ? DeterminedPainter(
                trackColor: _getTrackColor(theme),
                indicatorColor: _getIndicatorColor(theme),
                progress: progress!,
              )
            : IndeterminatePainter(),
      ),
    );
  }
}

extension on OptimusCircleLoaderAppearance {
  Color getIndicatorColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusCircleLoaderAppearance.normal:
        return theme.colors.primary500;
      case OptimusCircleLoaderAppearance.contrast:
        return theme.colors.neutral0;
    }
  }

  Color toTrackColor(OptimusThemeData theme) {
    switch (this) {
      case OptimusCircleLoaderAppearance.normal:
        return theme.colors.neutral50;
      case OptimusCircleLoaderAppearance.contrast:
        return theme.colors.neutral1000t32;
    }
  }
}
