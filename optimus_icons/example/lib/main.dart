import 'package:flutter/material.dart';
import 'package:optimus_icons/optimus_icons.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimus Icons Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatelessWidget {
  const ExampleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(OptimusIcons.accounting_ledger),
              Icon(OptimusIcons.rebate),
              Icon(OptimusIcons.delete),
              Icon(OptimusIcons.checkbox_empty),
              Icon(OptimusIcons.chevron_down),
            ],
          ),
        ),
      ),
    );
  }
}
