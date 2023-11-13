import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final welcomeStory = Story(
  name: 'Welcome',
  builder: (context) => const Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OptimusPageTitle(
          align: TextAlign.center,
          child: Text('Welcome to the MEWS Mobile Design System Storybook'),
        ),
        OptimusCaption(
          align: TextAlign.center,
          child: Text(
            'Here you can find live examples of the design system components with most common modifiers to tune the component to your needs.',
          ),
        ),
        OptimusCaption(
          align: TextAlign.center,
          child: Text(
            'You can find the list of all components on the left side (or collapsed in to the bottom bar) and exposed controls on the right side.',
          ),
        ),
        OptimusLabel(
          align: TextAlign.center,
          child: Text('For more detailed documentation, please visit:'),
        ),
        OptimusStandaloneLink(
          text: Text('mews.design'),
          size: OptimusStandaloneLinkSize.large,
          isExternal: true,
          onPressed: _handlePressed,
        ),
      ],
    ),
  ),
);

Future<void> _handlePressed() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

final Uri _url = Uri.parse('https://mews.design');
