library optimus;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/typography/styles.dart';

export 'optimus_icons.dart';
export 'src/avatar.dart';
export 'src/badge.dart';
export 'src/border_side.dart';
export 'src/borders.dart';
export 'src/button.dart';
export 'src/card.dart';
export 'src/checkbox/checkbox.dart';
export 'src/checkbox/checkbox_group.dart';
export 'src/colors/color_options.dart';
export 'src/colors/colors.dart';
export 'src/common/content.dart';
export 'src/date_time_field.dart';
export 'src/dialog.dart';
export 'src/expansion/expansion_tile.dart';
export 'src/form/date_time_form_field.dart';
export 'src/form/input_form_field.dart';
export 'src/form/select_form_field.dart';
export 'src/group_item.dart';
export 'src/icon.dart';
export 'src/icon_list.dart';
export 'src/input_field.dart';
export 'src/lists/list_tile.dart';
export 'src/number_picker.dart';
export 'src/progress_spinner.dart';
export 'src/radio/radio.dart';
export 'src/radio/radio_group.dart';
export 'src/search/dropdown_tile.dart';
export 'src/search/search_field.dart';
export 'src/select.dart';
export 'src/slidable/slidable.dart';
export 'src/slidable/slide_action.dart';
export 'src/spacing.dart';
export 'src/tabs.dart';
export 'src/tag.dart';
export 'src/typography/caption.dart';
export 'src/typography/highlight.dart';
export 'src/typography/label.dart';
export 'src/typography/paragraph.dart';
export 'src/typography/subtitle.dart';
export 'src/typography/title.dart';
export 'src/typography/variation.dart';
export 'src/widget_size.dart';

final ThemeData mewsTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
  fontFamily: 'packages/optimus/Montserrat',
  textTheme: const TextTheme(
    headline1: baseTextStyle,
    headline2: baseTextStyle,
    headline3: baseTextStyle,
    headline4: baseTextStyle,
    headline5: baseTextStyle,
    headline6: baseTextStyle,
    bodyText1: baseTextStyle,
    bodyText2: baseTextStyle,
    subtitle1: baseTextStyle,
    subtitle2: baseTextStyle,
    caption: baseTextStyle,
    button: baseTextStyle,
    overline: baseTextStyle,
  ),
  cupertinoOverrideTheme: const CupertinoThemeData.raw(
    Brightness.light,
    Colors.blue,
    Colors.blue,
    CupertinoTextThemeData(),
    Colors.white,
    Colors.white,
  ),
);
