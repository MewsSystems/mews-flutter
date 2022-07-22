import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/src/link/base_link.dart';

class OptimusInlineLink extends StatelessWidget {
  const OptimusInlineLink({
    Key? key,
    required this.text,
    required this.textStyle,
    this.color,
    this.onPressed,
    this.overflow,
    this.inherit = false,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final Widget text;
  final TextStyle textStyle;
  final Color? color;
  final bool inherit;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) => BaseLink(
        text: text,
        textStyle: textStyle.copyWith(fontWeight: FontWeight.w600),
        color: color,
        inherit: inherit,
        onPressed: onPressed,
        overflow: overflow,
      );
}
