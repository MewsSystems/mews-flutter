import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optimus/optimus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: OptimusTheme(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tokens = context.tokens;

            return Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OptimusTitleLarge(
                      child: Text(
                        'Welcome to the Mews Design System Widgetbook',
                      ),
                    ),
                    SizedBox(height: tokens.spacing200),
                    const OptimusTitleMedium(
                      child: Text(
                        'Presenting the components used across Mews products',
                      ),
                    ),
                    const OptimusLabel(
                      child: Text(
                        'Here, we showcase the fundamental building blocks—buttons, checkboxes, form elements, and more—that bring our products to life. These core components are designed without any specific business logic, ensuring flexibility and consistency across all Mews products.',
                      ),
                    ),
                    SizedBox(height: tokens.spacing200),
                    const OptimusTitleMedium(
                      child: Text('Core System\'s Role'),
                    ),
                    const OptimusLabel(
                      child: Text(
                        'The Core Design System serves as the foundation for building intuitive and elegant experiences. It\'s where designers and developers come together to create seamless user journeys, all powered by a shared set of components and design tokens. As our system evolves, we invite you to explore, test, and contribute to its growth.',
                      ),
                    ),
                    Row(
                      children: [
                        _Card(
                          link: _documentation,
                          image: const _CardImage(
                            variant: _CardImageVariant.docs,
                          ),
                          title: const Text('Documentation'),
                          description: const Text(
                            'The main source of truth for our Design System',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({
    required this.link,
    required this.image,
    required this.title,
    this.description,
  });

  final String link;
  final Widget image;
  final Widget title;
  final Widget? description;

  void _handleDocumentationTap() => launchUrl(Uri.parse(link));

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Padding(
      padding: EdgeInsets.all(tokens.spacing100),
      child: GestureDetector(
        onTap: _handleDocumentationTap,
        child: OptimusCard(
          child: Column(
            children: [
              SizedBox.square(dimension: tokens.sizing600, child: image),
              OptimusTitleMedium(child: title),
              if (description case final description?)
                OptimusCaption(child: description),
            ],
          ),
        ),
      ),
    );
  }
}

enum _CardImageVariant {
  docs('docs'),
  github('github'),
  storybook('storybook'),
  componentsStatus('components_status');

  const _CardImageVariant(this.fileName);
  final String fileName;
}

extension on _CardImageVariant {
  String get path => 'svg/$fileName.svg';
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.variant});

  final _CardImageVariant variant;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(variant.path);
}

const _documentation = 'https://mews.design';
const _github = 'https://github.com/MewsSystems/mews-flutter';
const _componentStatus = 'https://mews.design';
