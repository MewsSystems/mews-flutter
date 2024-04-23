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
    this.counter,
    this.showLoader = false,
  });

  final Widget? suffix;
  final Widget? passwordButton;
  final Widget? trailing;
  final Widget? clearAllButton;
  final Widget? inlineError;
  final bool showLoader;
  final Widget? counter;

  OptimusCircleLoader get _loader => const OptimusCircleLoader(
        size: OptimusCircleLoaderSize.small,
        variant: OptimusCircleLoaderVariant.indeterminate(),
      );

  @override
  Widget build(BuildContext context) => OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (counter case final counter?) counter,
          if (suffix case final suffix?) suffix,
          if (showLoader) _loader,
          if (clearAllButton case final clearAllButton?) clearAllButton,
          if (passwordButton case final passwordButton?) passwordButton,
          if (trailing case final trailing?) trailing,
          if (inlineError case final inlineError?) inlineError,
        ],
      );
}

class Prefix extends StatelessWidget {
  const Prefix({super.key, this.prefix, this.leading});

  final Widget? prefix;
  final Widget? leading;

  @override
  Widget build(BuildContext context) => OptimusStack(
        direction: Axis.horizontal,
        spacing: OptimusStackSpacing.spacing100,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) leading,
          if (prefix case final prefix?) prefix,
        ],
      );
}

class InlineErrorTooltip extends StatelessWidget {
  const InlineErrorTooltip({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) => OptimusTooltipWrapper(
        text: Text(error),
        child: Icon(
          OptimusIcons.error_circle,
          color: context.tokens.textAlertDanger,
        ),
      );
}
