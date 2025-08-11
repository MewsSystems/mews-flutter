import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/utils.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Standalone Link',
  type: OptimusStandaloneLink,
  path: '[Navigation]',
)
Widget createDefaultStyle(BuildContext context) {
  final k = context.knobs;

  final linkText = k.string(label: 'Link Name', initialValue: 'Link');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: OptimusStandaloneLinkSize.values
          .map(
            (size) => Padding(
              padding: const EdgeInsets.all(8),
              child: OptimusStandaloneLink(
                onPressed: k.isEnabledKnob ? ignore : null,
                text: Text(linkText),
                semanticLabel: linkText,
                semanticLinkUrl: Uri.parse('https://example.com'),
                size: size,
                isExternal: k.boolean(label: 'External', initialValue: false),
                useStrong: k.boolean(label: 'Strong', initialValue: false),
                variant: k.list(
                  label: 'Variant',
                  initialOption: OptimusLinkVariant.primary,
                  options: OptimusLinkVariant.values,
                  labelBuilder: enumLabelBuilder,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );
}
