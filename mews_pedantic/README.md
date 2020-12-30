# mews_pedantic

This package contains a sample `analysis_options.yaml` file that specifies lint rules and static analysis configuration we use in Mews.

For the sake of convenience, some rules are defined as "warnings" to allow compilation and hot reloading while you're developing and playing around with your code. E.g. you don't want to properly format the code or remove unused variables while you're just in the middle of development phase. At the same time, we recommend to set up you CI machine so that it fails the build if there are any errors or warning found.

## Using the Lints

To use the lints add a dependency in your `pubspec.yaml`:

```yaml
dev_dependencies:
  mews_pedantic: ^0.1.2
```

then, add an include in your `analysis_options.yaml`:

```yaml
include: package:mews_pedantic/analysis_options.yaml
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/MewsSystems/mews-flutter/issues
