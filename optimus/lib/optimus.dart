library optimus;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/typography/presets.dart';

export 'optimus_icons.dart';
export 'src/avatar.dart';
export 'src/badge.dart';
export 'src/banner.dart';
export 'src/borders.dart';
export 'src/breakpoint.dart';
export 'src/button/button.dart';
export 'src/button/dropdown.dart';
export 'src/button/icon.dart';
export 'src/button/split.dart';
export 'src/card.dart';
export 'src/chat/bubble.dart';
export 'src/chat/chat.dart';
export 'src/chat/message.dart';
export 'src/checkbox/checkbox.dart';
export 'src/checkbox/checkbox_group.dart';
export 'src/colors/brand_colors.dart';
export 'src/colors/color_options.dart';
export 'src/colors/colors.dart';
export 'src/common/content.dart';
export 'src/common/field_wrapper.dart';
export 'src/common/group_item.dart';
export 'src/common/scroll.dart';
export 'src/date_time_field.dart';
export 'src/dialogs/dialog.dart';
export 'src/dialogs/non_modal_wrapper.dart';
export 'src/enabled.dart';
export 'src/expansion/expansion_tile.dart';
export 'src/form/checkbox_form_field.dart';
export 'src/form/date_time_form_field.dart';
export 'src/form/input_form_field.dart';
export 'src/form/select_form_field.dart';
export 'src/form/select_input_form_field.dart';
export 'src/icon.dart';
export 'src/icon_list.dart';
export 'src/input_field.dart';
export 'src/lists/list_tile.dart';
export 'src/loader/loader.dart';
export 'src/logo.dart';
export 'src/notification/notification.dart';
export 'src/notification/notification_manager.dart';
export 'src/number_picker/number_picker.dart';
export 'src/progress_spinner.dart';
export 'src/radio/radio.dart';
export 'src/radio/radio_group.dart';
export 'src/search/dropdown_tile.dart';
export 'src/search/search_field.dart';
export 'src/segmented_control/segmented_control.dart';
export 'src/select.dart';
export 'src/select_input.dart';
export 'src/slidable/slidable.dart';
export 'src/slidable/slide_action.dart';
export 'src/spacing.dart';
export 'src/stack.dart';
export 'src/standalone_link.dart';
export 'src/step_bar.dart';
export 'src/tabs.dart';
export 'src/tag.dart';
export 'src/theme/theme.dart';
export 'src/theme/theme_data.dart';
export 'src/typography/caption.dart';
export 'src/typography/highlight.dart';
export 'src/typography/label.dart';
export 'src/typography/paragraph.dart';
export 'src/typography/title.dart';
export 'src/typography/variation.dart';
export 'src/widget_size.dart';

ThemeData createOptimusMaterialTheme(Brightness brightness) => ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: OptimusColors(brightness).background,
      primarySwatch: Colors.blue,
      fontFamily: 'packages/optimus/OpenSans',
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
      cupertinoOverrideTheme: CupertinoThemeData.raw(
        brightness,
        Colors.blue,
        Colors.blue,
        const CupertinoTextThemeData(),
        Colors.white,
        Colors.white,
      ),
    );
