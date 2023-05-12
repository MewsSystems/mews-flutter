library optimus;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/typography/presets.dart';

export 'package:intl/intl.dart' show DateFormat;

export 'optimus_icons.dart';
export 'src/avatar.dart';
export 'src/badge.dart';
export 'src/banner.dart';
export 'src/border_radius.dart';
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
export 'src/checkbox/nested_checkbox.dart';
export 'src/colors/brand_colors.dart';
export 'src/colors/color_options.dart';
export 'src/colors/colors.dart';
export 'src/common/content.dart';
export 'src/common/field_wrapper.dart';
export 'src/common/group_item.dart';
export 'src/common/scroll.dart';
export 'src/date_time_field.dart';
export 'src/dialogs/dialog.dart';
export 'src/dialogs/dialog_size.dart';
export 'src/dialogs/dialog_wrapper.dart';
export 'src/dialogs/inline_dialog.dart';
export 'src/divider.dart';
export 'src/dropdown/dropdown.dart';
export 'src/dropdown/dropdown_tile.dart';
export 'src/dropdown/embedded_search.dart';
export 'src/enabled.dart';
export 'src/expansion/expansion_tile.dart';
export 'src/form/checkbox_form_field.dart';
export 'src/form/date_input_field.dart';
export 'src/form/date_input_form_field.dart';
export 'src/form/date_time_form_field.dart';
export 'src/form/input_field.dart';
export 'src/form/input_form_field.dart';
export 'src/form/select_form_field.dart';
export 'src/form/select_input_form_field.dart';
export 'src/form/styled_input_controller.dart';
export 'src/icon.dart';
export 'src/icon_list.dart';
export 'src/link/inline_link.dart';
export 'src/link/standalone_link.dart';
export 'src/lists/font_variant.dart';
export 'src/lists/list_tile.dart';
export 'src/lists/nav_list_tile.dart';
export 'src/loader/loader.dart';
export 'src/logo.dart';
export 'src/notification/notification.dart';
export 'src/notification/notification_overlay.dart';
export 'src/number_picker/number_picker.dart';
export 'src/progress_spinner.dart';
export 'src/radio/radio.dart';
export 'src/radio/radio_group.dart';
export 'src/search/search_field.dart';
export 'src/segmented_control/segmented_control.dart';
export 'src/select.dart';
export 'src/select_input.dart';
export 'src/slidable/slidable.dart';
export 'src/slidable/slide_action.dart';
export 'src/spacing.dart';
export 'src/stack.dart';
export 'src/step_bar/step_bar.dart';
export 'src/step_bar/step_bar_compact.dart';
export 'src/step_bar/step_bar_item.dart';
export 'src/tabs.dart';
export 'src/tag.dart';
export 'src/theme/theme.dart';
export 'src/theme/theme_data.dart';
export 'src/tooltip/tooltip.dart';
export 'src/tooltip/tooltip_wrapper.dart';
export 'src/typography/caption.dart';
export 'src/typography/fonts.dart';
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
      fontFamily: 'packages/optimus/Inter',
      textTheme: const TextTheme(
        displayLarge: baseTextStyle,
        displayMedium: baseTextStyle,
        displaySmall: baseTextStyle,
        headlineMedium: baseTextStyle,
        headlineSmall: baseTextStyle,
        titleLarge: baseTextStyle,
        bodyLarge: baseTextStyle,
        bodyMedium: baseTextStyle,
        titleMedium: baseTextStyle,
        titleSmall: baseTextStyle,
        bodySmall: baseTextStyle,
        labelLarge: baseTextStyle,
        labelSmall: baseTextStyle,
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
