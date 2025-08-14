import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/theming/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Basic Override', type: OptimusButton)
Widget createThemeOverrideDemo(BuildContext _) => const _ThemeOverrideDemo();

class _ThemeOverrideDemo extends StatelessWidget {
  const _ThemeOverrideDemo();

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final tokens = context.tokens;

    // Token override knobs
    final primaryColor = k.color(
      label: 'Primary Background Color',
      initialValue: tokens.backgroundInteractivePrimaryDefault,
    );

    final primaryHoverColor = k.color(
      label: 'Primary Hover Color',
      initialValue: tokens.backgroundInteractivePrimaryHover,
    );

    final primaryActiveColor = k.color(
      label: 'Primary Active Color',
      initialValue: tokens.backgroundInteractivePrimaryActive,
    );

    final textColor = k.color(
      label: 'Text Color',
      initialValue: tokens.textStaticInverse,
    );

    final disabledColor = k.color(
      label: 'Disabled Color',
      initialValue: tokens.backgroundDisabled,
    );

    final borderRadius = k.double.slider(
      label: 'Border Radius',
      initialValue: tokens.borderRadius100.x,
      min: 0.0,
      max: 32.0,
    );

    final padding = k.double.slider(
      label: 'Padding',
      initialValue: tokens.spacing100,
      min: 8.0,
      max: 32.0,
    );

    // Button configuration knobs
    final buttonText = k.string(
      label: 'Button Text',
      initialValue: 'Theme Override Demo',
    );

    final variant = k.object.dropdown<OptimusButtonVariant>(
      label: 'Button Variant',
      options: OptimusButtonVariant.values,
      initialOption: OptimusButtonVariant.primary,
      labelBuilder: (value) => value.name,
    );

    final size = k.object.dropdown<OptimusWidgetSize>(
      label: 'Button Size',
      options: OptimusWidgetSize.values,
      initialOption: OptimusWidgetSize.large,
      labelBuilder: (value) => value.name,
    );

    final isEnabled = k.boolean(label: 'Enabled', initialValue: true);

    final isLoading = k.boolean(label: 'Loading', initialValue: false);

    final customTokens = tokens.copyWith(
      backgroundInteractivePrimaryDefault: primaryColor,
      backgroundInteractivePrimaryHover: primaryHoverColor,
      backgroundInteractivePrimaryActive: primaryActiveColor,
      textStaticInverse: textColor,
      backgroundDisabled: disabledColor,
      borderRadius100: Radius.circular(borderRadius),
      spacing100: padding,
    );

    final customTheme = OptimusThemeData(
      brightness: Theme.of(context).brightness,
      tokens: customTokens,
    );

    return OptimusTheme(
      lightTheme: customTheme,
      darkTheme: customTheme,
      child: Scaffold(
        backgroundColor: customTokens.backgroundStaticFlat,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Theme Override Demo', style: tokens.titleLargeStrong),
              const SizedBox(height: 16.0),
              Text(
                'This demo shows how to override Optimus design tokens using OptimusTheme. Adjust the knobs above to see how the button appearance changes.',
                style: tokens.bodyMedium,
              ),
              const SizedBox(height: 24.0),
              OptimusButton(
                onPressed: isEnabled ? () {} : null,
                variant: variant,
                size: size,
                isLoading: isLoading,
                child: Text(buttonText),
              ),
              const SizedBox(height: 32.0),
              _TokenDisplay(
                title: 'Applied Token Values',
                overriddenTokens: customTokens,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenDisplay extends StatelessWidget {
  const _TokenDisplay({required this.title, required this.overriddenTokens});

  final String title;
  final OptimusTokens overriddenTokens;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: tokens.titleMediumStrong),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: tokens.backgroundStaticRaised,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TokenDiff(
                label: 'Primary Background',
                originalValue: ColorBlock(
                  tokens.backgroundInteractivePrimaryDefault,
                ),
                value: ColorBlock(
                  overriddenTokens.backgroundInteractivePrimaryDefault,
                ),
              ),
              TokenDiff(
                label: 'Primary Hover',
                originalValue: ColorBlock(
                  tokens.backgroundInteractivePrimaryHover,
                ),
                value: ColorBlock(
                  overriddenTokens.backgroundInteractivePrimaryHover,
                ),
              ),
              TokenDiff(
                label: 'Primary Active',
                originalValue: ColorBlock(
                  tokens.backgroundInteractivePrimaryActive,
                ),
                value: ColorBlock(
                  overriddenTokens.backgroundInteractivePrimaryActive,
                ),
              ),
              TokenDiff(
                label: 'Text Color',
                originalValue: ColorBlock(tokens.textStaticInverse),
                value: ColorBlock(overriddenTokens.textStaticInverse),
              ),
              TokenDiff(
                label: 'Disabled Color',
                originalValue: ColorBlock(tokens.backgroundDisabled),
                value: ColorBlock(overriddenTokens.backgroundDisabled),
              ),
              TokenDiff(
                label: 'Border Radius',
                originalValue: TextBlock(
                  '${tokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
                value: TextBlock(
                  '${overriddenTokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
              ),
              TokenDiff(
                label: 'Padding',
                originalValue: TextBlock('${tokens.spacing100}px'),
                value: TextBlock('${overriddenTokens.spacing100}px'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
