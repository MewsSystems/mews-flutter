# Adding/Updating icons in `optimus`

- Download all icons from [Figma](https://www.figma.com/file/azIbClGgKgD41yyc5UwYIg/Visual-Assets-Library) (you can export everything using the shortcut `cmd+shift+e` on macOS).
- Select 16x16 (`_16.svg`) icons
- Open [Fluttericon.com](https://www.fluttericon.com/)
- Import all icons there
- Change name to `OptimusIcons`
- Download the package
- Export everything
- Replace font `OptimusIcons.ttf` file
- Replace `optimus_icons.dart` file (generated file needs to be renamed)
- Replace `config.json` in fonts/config
- Check if the naming of the newly generated file is consistent and is not breaking old conventions
- Generate a new story with all icons running `melos gen_icons`
- Double-check for errors
- Check story **All icons** story for any icons misplacement
- Push and create a PR (don't forget to mark it as **breaking** if any icon was removed/renamed)
