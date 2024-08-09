import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storybook/stories/avatar.dart';
import 'package:storybook/stories/button/button.dart';
import 'package:storybook/stories/button/dropdown.dart';
import 'package:storybook/stories/button/icon.dart';
import 'package:storybook/stories/button/split.dart';
import 'package:storybook/stories/button/toggle.dart';
import 'package:storybook/stories/card.dart';
import 'package:storybook/stories/chat/bubble.dart';
import 'package:storybook/stories/chat/chat.dart';
import 'package:storybook/stories/checkbox.dart';
import 'package:storybook/stories/checkbox_group.dart';
import 'package:storybook/stories/checkbox_nested.dart';
import 'package:storybook/stories/date_input_field.dart';
import 'package:storybook/stories/date_input_form_field.dart';
import 'package:storybook/stories/date_time_field.dart';
import 'package:storybook/stories/dialog.dart';
import 'package:storybook/stories/divider.dart';
import 'package:storybook/stories/feedback/alert.dart';
import 'package:storybook/stories/feedback/badge.dart';
import 'package:storybook/stories/feedback/banner.dart';
import 'package:storybook/stories/feedback/chip.dart';
import 'package:storybook/stories/feedback/spinner.dart';
import 'package:storybook/stories/feedback/system_wide_banner.dart';
import 'package:storybook/stories/feedback/tags.dart';
import 'package:storybook/stories/form/form_story.dart';
import 'package:storybook/stories/form/password_form.dart';
import 'package:storybook/stories/form/text_area.dart';
import 'package:storybook/stories/icon/icon.dart';
import 'package:storybook/stories/icon/icon_list.dart';
import 'package:storybook/stories/icon/icons.dart';
import 'package:storybook/stories/inline_dialog.dart';
import 'package:storybook/stories/input.dart';
import 'package:storybook/stories/link/inline_link.dart';
import 'package:storybook/stories/link/standalone_link.dart';
import 'package:storybook/stories/list/expanded_list.dart';
import 'package:storybook/stories/list/list_tile.dart';
import 'package:storybook/stories/list/nav_list_tile.dart';
import 'package:storybook/stories/logo.dart';
import 'package:storybook/stories/nested_overlays.dart';
import 'package:storybook/stories/nonmodal_wrapper.dart';
import 'package:storybook/stories/progress_indicator.dart';
import 'package:storybook/stories/radio.dart';
import 'package:storybook/stories/search_field.dart';
import 'package:storybook/stories/segmented_control.dart';
import 'package:storybook/stories/select_input.dart';
import 'package:storybook/stories/slidable.dart';
import 'package:storybook/stories/spacing.dart';
import 'package:storybook/stories/stack.dart';
import 'package:storybook/stories/stepper.dart';
import 'package:storybook/stories/tab/tab.dart';
import 'package:storybook/stories/tab/tabs.dart';
import 'package:storybook/stories/toggle.dart';
import 'package:storybook/stories/tooltip.dart';
import 'package:storybook/stories/tooltip_wrapper.dart';
import 'package:storybook/stories/typography/caption.dart';
import 'package:storybook/stories/typography/highlight.dart';
import 'package:storybook/stories/typography/label.dart';
import 'package:storybook/stories/typography/paragraph.dart';
import 'package:storybook/stories/typography/title.dart';
import 'package:storybook/stories/welcome.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _theme = _getThemeModeFromPreferences();

  Future<ThemeMode> _getThemeModeFromPreferences() async =>
      (await SharedPreferences.getInstance())
          .getString(_keyTheme)
          .toThemeMode();

  Future<void> _handleThemeChanged(ThemeMode themeMode) async =>
      (await SharedPreferences.getInstance())
          .setString(_keyTheme, themeMode.name);

  @override
  Widget build(BuildContext context) => FutureBuilder<ThemeMode>(
        future: _theme,
        builder: (context, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.none ||
          ConnectionState.waiting =>
            const CircularProgressIndicator(),
          ConnectionState.active || ConnectionState.done => Storybook(
              plugins: [
                ThemeModePlugin(
                  initialTheme: snapshot.data,
                  onThemeChanged: _handleThemeChanged,
                ),
                DeviceFramePlugin(),
              ],
              wrapperBuilder: (BuildContext _, Widget? child) => MaterialApp(
                theme: ThemeData.light()
                    .copyWith(scaffoldBackgroundColor: Colors.white),
                darkTheme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                home: Scaffold(body: Center(child: child)),
              ),
              initialStory: 'Forms/SelectionCard',
              stories: [
                welcomeStory,
                formStory,
                avatarStory,
                button,
                dividerStory,
                dropdownButton,
                iconButton,
                splitButton,
                selectInputStory,
                checkbox,
                checkboxGroup,
                checkboxNestedGroup,
                inputStory,
                searchFieldStory,
                dateInputStory,
                dateInputFormFieldStory,
                stepperStory,
                spacingStory,
                tagStory,
                bannerStory,
                alertStory,
                allIconsStory,
                iconStory,
                logoStory,
                iconListStory,
                cardStory,
                nestedCardStory,
                radioStory,
                radioGroupStory,
                dialogStory,
                nonModalDialogStory,
                inlineDialogStory,
                stackStory,
                progressIndicatorStory,
                badgeStory,
                listTileStory,
                navListTileStory,
                expandedListTileStory,
                tabStory,
                tabsStory,
                segmentedControlStory,
                slidableStory,
                nestedSelectStory,
                nestedSearchStory,
                nestedNonModalDialogStory,
                titleStory,
                paragraphStory,
                labelStory,
                captionStory,
                highlightStory,
                chatStory,
                chatBubbleStory,
                standaloneLink,
                inlineLink,
                dateTimeFieldStory,
                tooltipStory,
                tooltipWrapperStory,
                toggleStory,
                chipStory,
                spinnerStory,
                systemWideBannerStory,
                passwordStory,
                toggleButtonStory,
                textAreaStory,
              ],
            ),
        },
      );
}

extension on String? {
  ThemeMode toThemeMode() => ThemeMode.values
      .firstWhere((e) => e.name == this, orElse: () => ThemeMode.system);
}

const _keyTheme = 'themeMode';
