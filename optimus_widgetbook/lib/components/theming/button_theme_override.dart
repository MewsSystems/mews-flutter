import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Theming', path: 'Theming', type: OptimusButton)
Widget createThemeOverrideDemo(BuildContext _) =>
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
      borderRadius100: .circular(borderRadius),
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
          padding: .all(tokens.spacing200),
          child: Column(
            crossAxisAlignment: .start,
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
                padding: .all(tokens.spacing200),
                decoration: BoxDecoration(
                  color: customTokens.backgroundAlertWarningSecondary,
                  borderRadius: .all(.circular(tokens.borderRadius100.x)),
                  border: .all(color: customTokens.borderAlertWarning),
                ),
                child: Column(
                  crossAxisAlignment: .start,
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
                originalTokens: tokens,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TokenDisplay extends StatelessWidget {
  const _TokenDisplay({required this.title, required this.originalTokens});

  final String title;
  final OptimusTokens originalTokens;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(title, style: tokens.titleMediumStrong),
        const SizedBox(height: 8.0),
        Container(
          padding: const .all(12.0),
          decoration: BoxDecoration(
            color: tokens.backgroundStaticRaised,
            borderRadius: const .all(.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              TokenDiff(
                label: 'Primary Background',
                value: _ColorBlock(tokens.backgroundInteractivePrimaryDefault),
                originalValue: _ColorBlock(
                  originalTokens.backgroundInteractivePrimaryDefault,
                ),
              ),
              TokenDiff(
                label: 'Secondary Background',
                value: _ColorBlock(
                  tokens.backgroundInteractiveSecondaryDefault,
                ),
                originalValue: _ColorBlock(
                  originalTokens.backgroundInteractiveSecondaryDefault,
                ),
              ),
              TokenDiff(
                label: 'Danger Background',
                value: _ColorBlock(tokens.backgroundInteractiveDangerDefault),
                originalValue: _ColorBlock(
                  originalTokens.backgroundInteractiveDangerDefault,
                ),
              ),
              TokenDiff(
                label: 'Success Background',
                value: _ColorBlock(tokens.backgroundInteractiveSuccessDefault),
                originalValue: _ColorBlock(
                  originalTokens.backgroundInteractiveSuccessDefault,
                ),
              ),
              TokenDiff(
                label: 'Text Color',
                value: _ColorBlock(tokens.textStaticInverse),
                originalValue: _ColorBlock(originalTokens.textStaticInverse),
              ),
              TokenDiff(
                label: 'Secondary Text',
                value: _ColorBlock(tokens.textStaticSecondary),
                originalValue: _ColorBlock(originalTokens.textStaticSecondary),
              ),
              TokenDiff(
                label: 'Disabled Color',
                value: _ColorBlock(tokens.backgroundDisabled),
                originalValue: _ColorBlock(originalTokens.backgroundDisabled),
              ),
              TokenDiff(
                label: 'Border Radius',
                value: _TextBlock(
                  '${tokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
                originalValue: _TextBlock(
                  '${originalTokens.borderRadius100.x.toStringAsFixed(1)}px',
                ),
              ),
              TokenDiff(
                label: 'Padding',
                value: _TextBlock('${tokens.spacing100}px'),
                originalValue: _TextBlock('${originalTokens.spacing100}px'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ColorBlock extends StatelessWidget {
  const _ColorBlock(this.value);

  final Color value;

  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: value,
      border: .all(color: Colors.grey),
      borderRadius: const .all(.circular(2)),
    ),
  );
}

class _TextBlock extends StatelessWidget {
  const _TextBlock(this.text);

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: context.tokens.bodySmall);
}

class TokenDiff extends StatelessWidget {
  const TokenDiff({
    super.key,
    required this.label,
    required this.value,
    required this.originalValue,
  });

  final String label;
  final Widget value;
  final Widget originalValue;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const .symmetric(vertical: 2.0),
    child: Row(
      children: [
        _TextBlock(label),
        const SizedBox(width: 8.0),
        originalValue,
        const SizedBox(width: 8.0),
        Text('→', style: context.tokens.bodySmall),
        const SizedBox(width: 8.0),
        value,
      ],
    ),
  );
}
