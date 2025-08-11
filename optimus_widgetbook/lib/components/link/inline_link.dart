import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Inline Link',
  type: OptimusInlineLink,
  path: '[Navigation]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final size = k.int.slider(
    label: 'Text size',
    initialValue: 16,
    min: 12,
    max: 20,
  );
  final allowInherit = k.boolean(label: 'Inherit', initialValue: false);
  final color = k.listOrNull(
    label: 'Colors',
    initialOption: null,
    options: _colors,
  );
  final onPressed = k.boolean(label: 'Enabled', initialValue: true)
      ? ignore
      : null;

  final TextStyle style = TextStyle(
    fontSize: size.toDouble(),
    color: color?.value,
  );

  final linkText = k.string(label: 'Link name', initialValue: 'Link');

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Some text before inline link. Inline ', style: style),
          OptimusInlineLink(
            text: Text(linkText),
            semanticLabel: linkText,
            semanticLinkUrl: Uri.parse('https://example.com'),
            shouldInherit: allowInherit,
            onPressed: onPressed,
            useStrong: k.boolean(label: 'Strong', initialValue: false),
            textStyle: allowInherit ? style : null,
            variant: k.list(
              label: 'Variant',
              initialOption: OptimusLinkVariant.primary,
              options: OptimusLinkVariant.values,
              labelBuilder: enumLabelBuilder,
            ),
          ),
          Text(' could be used inside text.', style: style),
        ],
      ),
    ),
  );
}

const _colors = [
  (label: 'none', value: null),
  (label: 'black', value: Colors.black),
  (label: 'green', value: Colors.green),
  (label: 'red', value: Colors.red),
];
