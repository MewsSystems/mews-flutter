import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optimus/src/colors/colors.dart';
import 'package:optimus/src/theme/optimus_tokens.dart';

export 'package:intl/intl.dart' show DateFormat;
export 'package:optimus_icons/optimus_icons.dart';

export 'src/avatar/avatar.dart';
export 'src/badge/badge.dart';
export 'src/badge/badge_variant.dart';
export 'src/borders.dart';
export 'src/breakpoint.dart';
export 'src/button/button.dart';
export 'src/button/button_variant.dart';
export 'src/button/dropdown.dart';
export 'src/button/icon.dart';
export 'src/button/split.dart';
export 'src/button/toggle.dart';
export 'src/card.dart';
export 'src/chat/bubble.dart';
export 'src/chat/chat.dart';
export 'src/chat/message.dart';
export 'src/checkbox/checkbox.dart';
export 'src/checkbox/checkbox_group.dart';
export 'src/checkbox/nested_checkbox.dart';
export 'src/chip.dart';
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
export 'src/dropdown/dropdown_group_separator.dart';
export 'src/dropdown/dropdown_tile.dart';
export 'src/dropdown/embedded_search.dart';
export 'src/enabled.dart';
export 'src/expansion/expansion_tile.dart';
export 'src/feedback/alert.dart';
export 'src/feedback/alert_overlay.dart';
export 'src/feedback/banner.dart';
export 'src/feedback/feedback_link.dart';
export 'src/feedback/feedback_variant.dart';
export 'src/feedback/system_wide_banner.dart';
export 'src/form/checkbox_form_field.dart';
export 'src/form/date_input_field.dart';
export 'src/form/date_input_form_field.dart';
export 'src/form/date_time_form_field.dart';
export 'src/form/drawer/drawer_multiselect_input.dart';
export 'src/form/drawer/drawer_select_input.dart';
export 'src/form/error_variant.dart';
export 'src/form/input_field.dart';
export 'src/form/input_form_field.dart';
export 'src/form/number_input/number_input.dart';
export 'src/form/number_input/number_input_form.dart';
export 'src/form/password_form_field.dart';
export 'src/form/select_form_field.dart';
export 'src/form/select_input_form_field.dart';
export 'src/form/stepper_form_field.dart';
export 'src/form/text_area.dart';
export 'src/icon.dart';
export 'src/icon_list.dart';
export 'src/link/inline_link.dart';
export 'src/link/link_variant.dart';
export 'src/link/standalone_link.dart';
export 'src/lists/font_variant.dart';
export 'src/lists/list_tile.dart';
export 'src/lists/nav_list_tile.dart';
export 'src/loader/spinner.dart';
export 'src/logo.dart';
export 'src/pictogram/pictogram.dart';
export 'src/pictogram/pictograms.dart';
export 'src/progress_indicator/progress_indicator.dart';
export 'src/progress_indicator/progress_indicator_item.dart';
export 'src/radio/radio.dart';
export 'src/radio/radio_group.dart';
export 'src/search/search_field.dart';
export 'src/segmented_control/segmented_control.dart';
export 'src/select.dart';
export 'src/select_input.dart';
export 'src/selection_card.dart';
export 'src/slidable/slidable.dart';
export 'src/slidable/slide_action.dart';
export 'src/stack.dart';
export 'src/tabs.dart';
export 'src/tag.dart';
export 'src/theme/optimus_tokens.dart';
export 'src/theme/theme.dart';
export 'src/theme/theme_data.dart';
export 'src/toggle.dart';
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

ThemeData createOptimusMaterialTheme(Brightness brightness) {
  final tokensTheme =
      brightness == Brightness.light ? OptimusTokens.light : OptimusTokens.dark;
  final baseTextStyle = tokensTheme.bodyMedium;

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: OptimusColors(brightness).background,
    primarySwatch: Colors.blue,
    fontFamily: tokensTheme.fontFamilyUi,
    package: 'optimus',
    textTheme: TextTheme(
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
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: brightness,
      primaryColor: Colors.blue,
      primaryContrastingColor: Colors.blue,
      textTheme: const CupertinoTextThemeData(),
      barBackgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
    ),
  );
}
