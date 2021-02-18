import 'package:flutter/material.dart';
import 'package:storybook/stories/banner.dart';
import 'package:storybook/stories/button.dart';
import 'package:storybook/stories/card.dart';
import 'package:storybook/stories/checkbox.dart';
import 'package:storybook/stories/checkbox_group.dart';
import 'package:storybook/stories/dialog.dart';
import 'package:storybook/stories/dropdown_button.dart';
import 'package:storybook/stories/icon.dart';
import 'package:storybook/stories/icon_button.dart';
import 'package:storybook/stories/icon_list.dart';
import 'package:storybook/stories/input.dart';
import 'package:storybook/stories/nonmodal_wrapper.dart';
import 'package:storybook/stories/number_picker.dart';
import 'package:storybook/stories/radio.dart';
import 'package:storybook/stories/search_field.dart';
import 'package:storybook/stories/select.dart';
import 'package:storybook/stories/spacing.dart';
import 'package:storybook/stories/stack.dart';
import 'package:storybook/stories/tags.dart';
import 'package:storybook/stories/wide_banner.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        children: [
          buttonPreview,
          button,
          dropdownButton,
          iconButton,
          selectStory,
          checkbox,
          checkboxGroup,
          inputStory,
          searchFieldStory,
          numberPickerStory,
          spacingStory,
          tagStory,
          bannerStory,
          wideBannerStory,
          interactiveTagStory,
          iconStory,
          supplementaryIconStory,
          iconListStory,
          cardStory,
          nestedCardStory,
          radioStory,
          radioGroupStory,
          dialogStory,
          nonModalDialogStory,
          stackStory,
        ],
      );
}
