# mews_pedantic

This package contains a sample `analysis_options.yaml` file that specifies lint rules and static analysis configuration we use in Mews.

This package is based on `flutter_lints`.

## Using the Lints

To use the lints add a dependency in your `pubspec.yaml`:

```yaml
dev_dependencies:
  mews_pedantic: ^0.3.0
```

then, add an include in your `analysis_options.yaml`:

```yaml
include: package:mews_pedantic/analysis_options.yaml
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/MewsSystems/mews-flutter/issues
