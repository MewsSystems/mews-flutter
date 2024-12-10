[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)

## mews-flutter

This repository contains Flutter and Dart open-source packages maintained by [Mews](https://mews.com):

- [mews_pedantic](mews_pedantic): Dart and Flutter static analysis and lint rules.
- [optimus](optimus): Design system for mobile platforms (and experimental web).
- [optimus_icons](optimus_icons): Design system icons.
- [optimus_widgetbook](optimus_widgetbook): Showcase of the Optimus library.
- [kiosk_mode](kiosk_mode): Kiosk mode plugin.

## Releasing a new version

- Create a new branch. Any name will be ok, but recommended pattern is `release-{DATE}`, e.g. `release-2021-05-05`.
- Run `melos version` in root directory. It will create a new commit with updated changelog and version based on
  previous commits.
- Push this commit and create a new PR. Don't forget to push tags as well, e.g. with `git push --tags`.
- PR should be merged, not squashed (otherwise tag will not be merged into master).
- After PR is merged, publish a new version to `pub.dev` using `melos publish` command in master branch (it can be only
  done locally).
