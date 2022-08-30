import 'package:flutter/material.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/nonmodal_wrapper.dart';
import 'package:storybook/stories/search_field.dart';
import 'package:storybook/stories/select_input.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nestedSelectStory = Story(
  name: 'Nested overlays/Nested Select',
  builder: (context) => _Content((_) => SelectInputStory(context.knobs)),
);

final Story nestedSearchStory = Story(
  name: 'Nested overlays/Nested Search',
  builder: (context) => _Content((_) => SearchStory(context.knobs)),
);

final Story nestedNonModalDialogStory = Story(
  name: 'Nested overlays/Nested Non-modal dialog',
  builder: (context) => _Content(
    (_) => Center(
      child: DialogWrapper(child: NonModalDialogStory(context.knobs)),
    ),
  ),
);

class _Content extends StatelessWidget {
  const _Content(this.contentBuilder, {Key? key}) : super(key: key);

  final WidgetBuilder contentBuilder;

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    late WidgetBuilder builder;
    switch (settings.name) {
      case 'initialRoute':
        builder = (context) => ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: contentBuilder(context),
            );
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: builder,
      settings: settings,
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _Bar(),
          Expanded(
            child: Navigator(
              initialRoute: 'initialRoute',
              onGenerateRoute: _onGenerateRoute,
            ),
          ),
          const _Bar(),
        ],
      );
}

class _Bar extends StatelessWidget {
  const _Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: 100,
        color: Colors.lightBlue,
        child: const Center(
          child: Text(
            'Widget outside of Navigator',
            textAlign: TextAlign.center,
          ),
        ),
      );
}
