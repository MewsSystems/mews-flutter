import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:storybook/stories/nonmodal_wrapper.dart';
import 'package:storybook/stories/search_field.dart';
import 'package:storybook/stories/select_input.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final Story nestedSelectStory = Story(
  section: 'Nested overlays',
  name: 'Nested Select',
  builder: (_, k) => _Content(SelectInputStory(k)),
);

final Story nestedSearchStory = Story(
  section: 'Nested overlays',
  name: 'Nested Search',
  builder: (_, k) => _Content(SearchStory(k)),
);

final Story nestedNonModalDialogStory = Story(
  section: 'Nested overlays',
  name: 'Nested Non-modal dialog',
  builder: (_, k) => _Content(
    Center(child: NonModalWrapper(child: NonModalDialogStory(k))),
  ),
);

class _Content extends StatelessWidget {
  const _Content(this.child, {Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const _Bar(),
          Expanded(
            child: Navigator(
              initialRoute: 'initialRoute',
              onGenerateRoute: (settings) {
                late WidgetBuilder builder;
                switch (settings.name) {
                  case 'initialRoute':
                    builder = (context) => ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 400),
                          child: child,
                        );
                    break;
                }

                return MaterialPageRoute<dynamic>(
                  builder: builder,
                  settings: settings,
                  fullscreenDialog: true,
                );
              },
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
