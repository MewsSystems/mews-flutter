import 'package:flutter/widgets.dart';
import 'package:optimus/optimus_icons.dart';
import 'package:optimus/src/loader/loader.dart';
import 'package:optimus/src/stack.dart';
import 'package:optimus/src/theme/theme.dart';
import 'package:optimus/src/tooltip/tooltip_wrapper.dart';

class Suffix extends StatelessWidget {
  const Suffix({
    super.key,
    this.suffix,
    this.passwordButton,
    this.trailing,
    this.inlineError,
    this.clearAllButton,
    this.showLoader = false,
  });

  final Widget? suffix;
  final Widget? passwordButton;
  final Widget? trailing;
  final Widget? clearAllButton;
  final Widget? inlineError;
  final bool showLoader;

  OptimusCircleLoader get _loader => const OptimusCircleLoader(
        size: OptimusCircleLoaderSize.small,
        variant: OptimusCircleLoaderVariant.indeterminate(),
      );

  @override
  Widget build(BuildContext context) {
    final suffixWidget = suffix;
    final clearAllButtonWidget = clearAllButton;
    final passwordButtonWidget = passwordButton;
    final trailingWidget = trailing;

    return inlineError ??
        OptimusStack(
          direction: Axis.horizontal,
          spacing: OptimusStackSpacing.spacing100,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (suffixWidget != null) suffixWidget,
            if (showLoader) _loader,
            if (clearAllButtonWidget != null) clearAllButtonWidget,
            if (passwordButtonWidget != null)
              passwordButtonWidget
            else if (trailingWidget != null)
              trailingWidget,
          ],
        );
  }
}

class Prefix extends StatelessWidget {
  const Prefix({super.key, this.prefix, this.leading});

  final Widget? prefix;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final prefix = this.prefix;
    final leading = this.leading;

    return OptimusStack(
      direction: Axis.horizontal,
      spacing: OptimusStackSpacing.spacing100,
      mainAxisSize: MainAxisSize.min,
      children: [if (leading != null) leading, if (prefix != null) prefix],
    );
  }
}

class InlineErrorTooltip extends StatelessWidget {
  const InlineErrorTooltip({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) => OptimusTooltipWrapper(
        text: Text(error),
        child:
            Icon(OptimusIcons.error_circle, color: context.theme.colors.danger),
      );
}
