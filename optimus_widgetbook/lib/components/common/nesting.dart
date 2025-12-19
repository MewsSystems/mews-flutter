import 'package:flutter/material.dart';

class NestedWrapper extends StatelessWidget {
  const NestedWrapper(this.contentBuilder, {super.key});

  final WidgetBuilder contentBuilder;

  Route<dynamic> _handleGenerateRoute(RouteSettings settings) {
    late WidgetBuilder builder;
    if (settings.name case 'initialRoute') {
      builder = (context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: contentBuilder(context),
      );
    }

    return MaterialPageRoute<dynamic>(
      builder: builder,
      settings: settings,
      fullscreenDialog: true,
    );
  }

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .start,
    children: [
      const _Bar(),
      Expanded(
        child: Navigator(
          initialRoute: 'initialRoute',
          onGenerateRoute: _handleGenerateRoute,
        ),
      ),
      const _Bar(),
    ],
  );
}

class _Bar extends StatelessWidget {
  const _Bar();

  @override
  Widget build(BuildContext context) => Container(
    height: 100,
    color: Colors.lightBlue,
    child: const Center(
      child: Text('Widget outside of Navigator', textAlign: .center),
    ),
  );
}
