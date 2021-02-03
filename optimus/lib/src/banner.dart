import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus/src/typography/styles.dart';

enum OptimusBannerVariant { primary, success, warning, error }

class OptimusBanner extends StatelessWidget {
  const OptimusBanner({
    Key key,
    @required this.content,
    this.variant = OptimusBannerVariant.primary,
    this.showIcon = false,
    this.additionalDescription,
    this.dismissible = false,
    this.onDismiss,
  }) : super(key: key);

  final Widget content;
  final OptimusBannerVariant variant;
  final bool showIcon;
  final String additionalDescription;
  final bool dismissible;
  final VoidCallback onDismiss;

  @override
  Widget build(Object context) => Container(
        decoration: BoxDecoration(color: _backgroundColor, borderRadius: _borderRadius),
        child: Stack(
          children: [
            Padding(
              padding: _padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showIcon)
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Icon(_icon, size: 20, color: _iconColor),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle.merge(child: content, style: _textStyle),
                      if (additionalDescription.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: spacing50),
                          child: Text(
                            additionalDescription,
                            style: preset200m.merge(const TextStyle(fontWeight: FontWeight.normal)),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (dismissible)
              Positioned(
                right: 6,
                top: 8,
                child: GestureDetector(
                  onTap: () => onDismiss,
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(OptimusIcons.cross_close, size: 12, color: OptimusColors.basic),
                  ),
                ),
              ),
          ],
        ),
      );

  BorderRadius get _borderRadius => const BorderRadius.all(Radius.circular(4));

  EdgeInsets get _padding =>
      EdgeInsets.fromLTRB(showIcon ? 18.0 : spacing200, 9, onDismiss != null ? spacing100 : spacing400, spacing200);

  TextStyle get _textStyle {
    if (additionalDescription != null) {
      return preset200m;
    } else {
      return preset300m;
    }
  }

  // ignore: missing_return
  IconData get _icon {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusIcons.info;
      case OptimusBannerVariant.success:
        return OptimusIcons.done_circle;
      case OptimusBannerVariant.warning:
        return OptimusIcons.disable; // TODO(MM) add warning icon
      case OptimusBannerVariant.error:
        return OptimusIcons.disable; // TODO(MM) update icon
    }
  }

  // ignore: missing_return
  Color get _iconColor {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusColors.primary500;
      case OptimusBannerVariant.success:
        return OptimusColors.success500;
      case OptimusBannerVariant.warning:
        return OptimusColors.warning500;
      case OptimusBannerVariant.error:
        return OptimusColors.danger500;
    }
  }

  // ignore: missing_return
  Color get _backgroundColor {
    switch (variant) {
      case OptimusBannerVariant.primary:
        return OptimusColors.primary500t8;
      case OptimusBannerVariant.success:
        return OptimusColors.success500t8;
      case OptimusBannerVariant.warning:
        return OptimusColors.warning500t8;
      case OptimusBannerVariant.error:
        return OptimusColors.danger500t8;
    }
  }
}
