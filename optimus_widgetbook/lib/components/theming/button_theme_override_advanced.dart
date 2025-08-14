import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:optimus_widgetbook/components/theming/common.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Advanced Override', type: OptimusButton)
Widget createAdvancedThemeOverrideDemo(BuildContext _) =>
    const _AdvancedThemeOverrideDemo();

class _AdvancedThemeOverrideDemo extends StatelessWidget {
  const _AdvancedThemeOverrideDemo();

  @override
  Widget build(BuildContext context) {
    final k = context.knobs;
    final tokens = context.tokens;

    final primaryColor = k.color(
      label: 'Primary Background',
      initialValue: tokens.backgroundInteractivePrimaryDefault,
    );

    final secondaryColor = k.color(
      label: 'Secondary Background',
      initialValue: tokens.backgroundInteractiveSecondaryDefault,
    );

    final dangerColor = k.color(
      label: 'Danger Background',
      initialValue: tokens.backgroundInteractiveDangerDefault,
    );

    final successColor = k.color(
      label: 'Success Background',
      initialValue: tokens.backgroundInteractiveSuccessDefault,
    );

    final textColor = k.color(
      label: 'Text Color',
      initialValue: tokens.textStaticInverse,
    );

    final secondaryTextColor = k.color(
      label: 'Secondary Text Color',
      initialValue: tokens.textStaticSecondary,
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

    final size = k.object.dropdown(
      label: 'Button Size',
      options: OptimusWidgetSize.values,
      initialOption: OptimusWidgetSize.large,
      labelBuilder: (value) => value.name,
    );

    final isEnabled = k.boolean(label: 'Enabled', initialValue: true);
    final isLoading = k.boolean(label: 'Loading', initialValue: false);

    final customTokens = tokens.copyWith(
      backgroundInteractivePrimaryDefault: primaryColor,
      backgroundInteractiveSecondaryDefault: secondaryColor,
      backgroundInteractiveDangerDefault: dangerColor,
      backgroundInteractiveSuccessDefault: successColor,
      textStaticInverse: textColor,
      textStaticSecondary: secondaryTextColor,
      backgroundDisabled: disabledColor,
      borderRadius100: Radius.circular(borderRadius),
      spacing100: padding,
    );

    final customThemeData = OptimusThemeData(
      brightness: Theme.of(context).brightness,
      tokens: customTokens,
    );

    return OptimusTheme(
      lightTheme: customThemeData,
      darkTheme: customThemeData,
      child: Scaffold(
        backgroundColor: customTokens.backgroundStaticFlat,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(tokens.spacing200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Advanced Theme Override Demo',
                style: customTokens.titleLargeStrong,
              ),
              SizedBox(height: tokens.spacing200),
              Text(
                'This demo shows comprehensive theme overrides for all button variants. Adjust the knobs above to see how different button variants change.',
                style: customTokens.bodyMedium,
              ),
              SizedBox(height: tokens.spacing300),
              Container(
                padding: EdgeInsets.all(tokens.spacing200),
                decoration: BoxDecoration(
                  color: customTokens.backgroundAlertWarningSecondary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(tokens.borderRadius100.x),
                  ),
                  border: Border.all(color: customTokens.borderAlertWarning),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const OptimusIcon(
                          iconData: OptimusIcons.alert_circle_24,
                        ),
                        SizedBox(width: tokens.spacing100),
                        Text(
                          'Warning: Breaking Changes',
                          style: customTokens.titleSmallStrong,
                        ),
                      ],
                    ),
                    SizedBox(height: tokens.spacing100),
                    Text(
                      'Overriding design tokens may break the visual consistency of your application. Use this feature carefully and test thoroughly across all components. Alternatively, use the smaller scope for the override.',
                      style: customTokens.bodySmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: tokens.spacing300),
              Text('Button Variants', style: customTokens.titleMediumStrong),
              SizedBox(height: tokens.spacing200),
              Wrap(
                spacing: tokens.spacing100,
                runSpacing: tokens.spacing100,
                children: OptimusButtonVariant.values
                    .map(
                      (variant) => OptimusButton(
                        onPressed: isEnabled ? ignore : null,
                        variant: variant,
                        size: size,
                        isLoading: isLoading,
                        child: Text('${variant.name} Button'),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: tokens.spacing300),
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
                value: ColorBlock(
                  overriddenTokens.backgroundInteractivePrimaryDefault,
                ),
                originalValue: ColorBlock(
                  tokens.backgroundInteractivePrimaryDefault,
                ),
              ),
              TokenDiff(
                label: 'Secondary Background',
                value: ColorBlock(
                  overriddenTokens.backgroundInteractiveSecondaryDefault,
                ),
                originalValue: ColorBlock(
                  tokens.backgroundInteractiveSecondaryDefault,
                ),
              ),
              TokenDiff(
                label: 'Danger Background',
                value: ColorBlock(
                  overriddenTokens.backgroundInteractiveDangerDefault,
                ),
                originalValue: ColorBlock(
                  tokens.backgroundInteractiveDangerDefault,
                ),
              ),
              TokenDiff(
                label: 'Success Background',
                value: ColorBlock(
                  overriddenTokens.backgroundInteractiveSuccessDefault,
                ),
                originalValue: ColorBlock(
                  tokens.backgroundInteractiveSuccessDefault,
                ),
              ),
              TokenDiff(
                label: 'Text Color',
                value: ColorBlock(overriddenTokens.textStaticInverse),
                originalValue: ColorBlock(tokens.textStaticInverse),
              ),
              TokenDiff(
                label: 'Secondary Text',
                value: ColorBlock(overriddenTokens.textStaticSecondary),
                originalValue: ColorBlock(tokens.textStaticSecondary),
              ),
              TokenDiff(
                label: 'Disabled Color',
                value: ColorBlock(overriddenTokens.backgroundDisabled),
                originalValue: ColorBlock(tokens.backgroundDisabled),
              ),
              TokenDiff(
                label: 'Border Radius',
                value: TextBlock(
                  '${overriddenTokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
                originalValue: TextBlock(
                  '${tokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
              ),
              TokenDiff(
                label: 'Padding',
                value: TextBlock('${overriddenTokens.spacing100}px'),
                originalValue: TextBlock('${tokens.spacing100}px'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
