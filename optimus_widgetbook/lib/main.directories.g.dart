// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:optimus_widgetbook/components/buttons/button.dart' as _i2;
import 'package:optimus_widgetbook/components/buttons/dropdown.dart' as _i3;
import 'package:optimus_widgetbook/components/buttons/icon.dart' as _i4;
import 'package:optimus_widgetbook/components/buttons/split.dart' as _i5;
import 'package:optimus_widgetbook/components/buttons/toggle.dart' as _i6;
import 'package:optimus_widgetbook/components/chat/bubble.dart' as _i23;
import 'package:optimus_widgetbook/components/chat/chat.dart' as _i22;
import 'package:optimus_widgetbook/components/data_display/nonmodal_wrapper.dart'
    as _i7;
import 'package:optimus_widgetbook/components/data_display/tooltip.dart'
    as _i13;
import 'package:optimus_widgetbook/components/data_display/tooltip_wrapper.dart'
    as _i14;
import 'package:optimus_widgetbook/components/feedback/alert.dart' as _i15;
import 'package:optimus_widgetbook/components/feedback/badge.dart' as _i16;
import 'package:optimus_widgetbook/components/feedback/banner.dart' as _i17;
import 'package:optimus_widgetbook/components/feedback/chip.dart' as _i18;
import 'package:optimus_widgetbook/components/feedback/spinner.dart' as _i19;
import 'package:optimus_widgetbook/components/feedback/system_wide_banner.dart'
    as _i20;
import 'package:optimus_widgetbook/components/feedback/tags.dart' as _i21;
import 'package:optimus_widgetbook/components/forms/checkbox.dart' as _i24;
import 'package:optimus_widgetbook/components/forms/checkbox_group.dart'
    as _i25;
import 'package:optimus_widgetbook/components/forms/checkbox_nested.dart'
    as _i26;
import 'package:optimus_widgetbook/components/forms/date_input_field.dart'
    as _i28;
import 'package:optimus_widgetbook/components/forms/date_input_form_field.dart'
    as _i29;
import 'package:optimus_widgetbook/components/forms/date_time_field.dart'
    as _i30;
import 'package:optimus_widgetbook/components/forms/drawer_select_input.dart'
    as _i31;
import 'package:optimus_widgetbook/components/forms/form_story.dart' as _i27;
import 'package:optimus_widgetbook/components/forms/input.dart' as _i32;
import 'package:optimus_widgetbook/components/forms/number_input.dart' as _i33;
import 'package:optimus_widgetbook/components/forms/number_input_form.dart'
    as _i34;
import 'package:optimus_widgetbook/components/forms/password_form.dart' as _i35;
import 'package:optimus_widgetbook/components/forms/radio.dart' as _i36;
import 'package:optimus_widgetbook/components/forms/search_field.dart' as _i37;
import 'package:optimus_widgetbook/components/forms/segmented_control.dart'
    as _i38;
import 'package:optimus_widgetbook/components/forms/select_input.dart' as _i39;
import 'package:optimus_widgetbook/components/forms/selection_card.dart'
    as _i40;
import 'package:optimus_widgetbook/components/forms/stepper.dart' as _i41;
import 'package:optimus_widgetbook/components/forms/text_area.dart' as _i42;
import 'package:optimus_widgetbook/components/forms/toggle.dart' as _i43;
import 'package:optimus_widgetbook/components/helpers/slidable.dart' as _i44;
import 'package:optimus_widgetbook/components/icon/icon.dart' as _i52;
import 'package:optimus_widgetbook/components/icon/icon_list.dart' as _i53;
import 'package:optimus_widgetbook/components/icon/icons.dart' as _i51;
import 'package:optimus_widgetbook/components/layout/card.dart' as _i45;
import 'package:optimus_widgetbook/components/layout/dialog.dart' as _i47;
import 'package:optimus_widgetbook/components/layout/divider.dart' as _i49;
import 'package:optimus_widgetbook/components/layout/inline_dialog.dart'
    as _i48;
import 'package:optimus_widgetbook/components/layout/spacing.dart' as _i46;
import 'package:optimus_widgetbook/components/layout/stack.dart' as _i50;
import 'package:optimus_widgetbook/components/link/inline_link.dart' as _i57;
import 'package:optimus_widgetbook/components/link/standalone_link.dart'
    as _i59;
import 'package:optimus_widgetbook/components/list/expanded_list.dart' as _i8;
import 'package:optimus_widgetbook/components/list/list_tile.dart' as _i9;
import 'package:optimus_widgetbook/components/list/nav_list_tile.dart' as _i10;
import 'package:optimus_widgetbook/components/media/avatar.dart' as _i54;
import 'package:optimus_widgetbook/components/media/logo.dart' as _i55;
import 'package:optimus_widgetbook/components/media/pictogram.dart' as _i56;
import 'package:optimus_widgetbook/components/navigation/progress_indicator.dart'
    as _i58;
import 'package:optimus_widgetbook/components/tab/tab.dart' as _i11;
import 'package:optimus_widgetbook/components/tab/tabs.dart' as _i12;
import 'package:optimus_widgetbook/components/typography/caption.dart' as _i62;
import 'package:optimus_widgetbook/components/typography/highlight.dart'
    as _i60;
import 'package:optimus_widgetbook/components/typography/label.dart' as _i61;
import 'package:optimus_widgetbook/components/typography/paragraph.dart'
    as _i64;
import 'package:optimus_widgetbook/components/typography/title.dart' as _i63;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookCategory(
    name: 'Buttons',
    children: [
      _i1.WidgetbookFolder(
        name: 'Button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default Style',
              builder: _i2.createDefaultStyle,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Dropdown Button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusDropDownButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Dropdown Button',
              builder: _i3.createDefaultStyle,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Icon Button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusIconButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Icon Button',
              builder: _i4.createDefaultStyle,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Split Button',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusSplitButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Split Button',
              builder: _i5.createDefaultStyle,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Toggle',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusToggleButton',
            useCase: _i1.WidgetbookUseCase(
              name: 'Toggle',
              builder: _i6.createDefaultStyle,
            ),
          )
        ],
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Data Display',
    children: [
      _i1.WidgetbookFolder(
        name: 'Dialog',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusDialog',
            useCase: _i1.WidgetbookUseCase(
              name: 'Non-modal Dialog',
              builder: _i7.createDefaultStyle,
            ),
          )
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'List',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusExpansionTile',
            useCase: _i1.WidgetbookUseCase(
              name: 'Expanded List Tile',
              builder: _i8.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusListTile',
            useCase: _i1.WidgetbookUseCase(
              name: 'List Tile',
              builder: _i9.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusNavListTile',
            useCase: _i1.WidgetbookUseCase(
              name: 'Navigation List Tile',
              builder: _i10.createDefaultStyle,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTab',
        useCase: _i1.WidgetbookUseCase(
          name: 'Tab',
          builder: _i11.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTabBar',
        useCase: _i1.WidgetbookUseCase(
          name: 'Tab Bar',
          builder: _i12.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTooltip',
        useCase: _i1.WidgetbookUseCase(
          name: 'Tooltip',
          builder: _i13.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTooltipWrapper',
        useCase: _i1.WidgetbookUseCase(
          name: 'Tooltip Wrapper',
          builder: _i14.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Feedback',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'OptimusAlert',
        useCase: _i1.WidgetbookUseCase(
          name: 'Alert',
          builder: _i15.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusBadge',
        useCase: _i1.WidgetbookUseCase(
          name: 'Badge',
          builder: _i16.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusBanner',
        useCase: _i1.WidgetbookUseCase(
          name: 'Banner',
          builder: _i17.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusChip',
        useCase: _i1.WidgetbookUseCase(
          name: 'Chip',
          builder: _i18.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSpinner',
        useCase: _i1.WidgetbookUseCase(
          name: 'Spinner',
          builder: _i19.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSystemWideBanner',
        useCase: _i1.WidgetbookUseCase(
          name: 'System Wide Banner',
          builder: _i20.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTag',
        useCase: _i1.WidgetbookUseCase(
          name: 'Tag',
          builder: _i21.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Forms',
    children: [
      _i1.WidgetbookFolder(
        name: 'Chat',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusChat',
            useCase: _i1.WidgetbookUseCase(
              name: '',
              builder: _i22.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusChatBubble',
            useCase: _i1.WidgetbookUseCase(
              name: '',
              builder: _i23.createDefaultStyle,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Checkbox',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusCheckbox',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default Style',
              builder: _i24.defaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusCheckboxGroup<int>',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default Style',
              builder: _i25.defaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusNestedCheckboxGroup',
            useCase: _i1.WidgetbookUseCase(
              name: 'Nested Checkbox Group',
              builder: _i26.defaultStyle,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'Form',
        useCase: _i1.WidgetbookUseCase(
          name: 'Form',
          builder: _i27.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusDateInputField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Date Input Field',
          builder: _i28.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusDateInputFormField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Date Input Form Field',
          builder: _i29.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusDateTimeField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Date Time Field',
          builder: _i30.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusDrawerSelectInput',
        useCase: _i1.WidgetbookUseCase(
          name: 'Drawer Select Input',
          builder: _i31.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusInputField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Input',
          builder: _i32.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusNumberInput',
        useCase: _i1.WidgetbookUseCase(
          name: 'NumberInput',
          builder: _i33.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusNumberInputFormField',
        useCase: _i1.WidgetbookUseCase(
          name: 'NumberInputForm',
          builder: _i34.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusPasswordFormField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Password',
          builder: _i35.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusRadio',
        useCase: _i1.WidgetbookUseCase(
          name: 'Radio',
          builder: _i36.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusRadioGroup',
        useCase: _i1.WidgetbookUseCase(
          name: 'Radio Group',
          builder: _i36.createRadioGroup,
        ),
      ),
      _i1.WidgetbookComponent(
        name: 'OptimusSearch',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Nested Search Field',
            builder: _i37.createNestedStyle,
          ),
          _i1.WidgetbookUseCase(
            name: 'Search Field',
            builder: _i37.createDefaultStyle,
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSegmentedControl',
        useCase: _i1.WidgetbookUseCase(
          name: 'Segmented Control',
          builder: _i38.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookComponent(
        name: 'OptimusSelectInput',
        useCases: [
          _i1.WidgetbookUseCase(
            name: 'Nested Select',
            builder: _i39.createNestedStyle,
          ),
          _i1.WidgetbookUseCase(
            name: 'Select Input',
            builder: _i39.createDefaultStyle,
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSelectionCard',
        useCase: _i1.WidgetbookUseCase(
          name: 'Selection Card',
          builder: _i40.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusStepperFormField',
        useCase: _i1.WidgetbookUseCase(
          name: 'Stepper',
          builder: _i41.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusTextArea',
        useCase: _i1.WidgetbookUseCase(
          name: 'Text Area',
          builder: _i42.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusToggle',
        useCase: _i1.WidgetbookUseCase(
          name: 'Toggle',
          builder: _i43.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Helpers',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSlideAction',
        useCase: _i1.WidgetbookUseCase(
          name: 'Slidable',
          builder: _i44.createDefaultStyle,
        ),
      )
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Layout',
    children: [
      _i1.WidgetbookFolder(
        name: 'Cards',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusCard',
            useCase: _i1.WidgetbookUseCase(
              name: 'Card',
              builder: _i45.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusNestedCard',
            useCase: _i1.WidgetbookUseCase(
              name: 'Nested Card',
              builder: _i45.createNestedCard,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'Column',
        useCase: _i1.WidgetbookUseCase(
          name: 'Spacing',
          builder: _i46.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookFolder(
        name: 'Dialog',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusDialog',
            useCase: _i1.WidgetbookUseCase(
              name: 'Modal Dialog',
              builder: _i47.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusInlineDialog',
            useCase: _i1.WidgetbookUseCase(
              name: 'Inline Dialog',
              builder: _i48.createDefaultStyle,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusDivider',
        useCase: _i1.WidgetbookUseCase(
          name: 'Divider',
          builder: _i49.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusStack',
        useCase: _i1.WidgetbookUseCase(
          name: 'Stack',
          builder: _i50.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Media',
    children: [
      _i1.WidgetbookFolder(
        name: 'Icons',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'GridView',
            useCase: _i1.WidgetbookUseCase(
              name: 'All Icons',
              builder: _i51.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusIcon',
            useCase: _i1.WidgetbookUseCase(
              name: 'Icon',
              builder: _i52.createDefaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusIconList',
            useCase: _i1.WidgetbookUseCase(
              name: 'Icon List',
              builder: _i53.createDefaultStyle,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusAvatar',
        useCase: _i1.WidgetbookUseCase(
          name: 'Avatar',
          builder: _i54.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusMewsLogo',
        useCase: _i1.WidgetbookUseCase(
          name: 'Logo',
          builder: _i55.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusPictogram',
        useCase: _i1.WidgetbookUseCase(
          name: 'Pictogram',
          builder: _i56.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Navigation',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'OptimusInlineLink',
        useCase: _i1.WidgetbookUseCase(
          name: 'Inline Link',
          builder: _i57.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusProgressIndicator',
        useCase: _i1.WidgetbookUseCase(
          name: 'Progress Indicator',
          builder: _i58.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusStandaloneLink',
        useCase: _i1.WidgetbookUseCase(
          name: 'Standalone Link',
          builder: _i59.createDefaultStyle,
        ),
      ),
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Typography',
    children: [
      _i1.WidgetbookFolder(
        name: 'Highlight',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusHighlightLarge',
            useCase: _i1.WidgetbookUseCase(
              name: 'Highlight Large',
              builder: _i60.createHighlightLarge,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusHighlightMedium',
            useCase: _i1.WidgetbookUseCase(
              name: 'Highlight Medium',
              builder: _i60.createHighlightMedium,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusHighlightSmall',
            useCase: _i1.WidgetbookUseCase(
              name: 'Highlight Small',
              builder: _i60.createHighLightSmall,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Label',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusLabel',
            useCase: _i1.WidgetbookUseCase(
              name: 'Label',
              builder: _i61.createLabel,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusLabelSmall',
            useCase: _i1.WidgetbookUseCase(
              name: 'Label Small',
              builder: _i61.createSmallLabel,
            ),
          ),
        ],
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusCaption',
        useCase: _i1.WidgetbookUseCase(
          name: 'Caption',
          builder: _i62.createDefaultStyle,
        ),
      ),
      _i1.WidgetbookLeafComponent(
        name: 'OptimusSubtitle',
        useCase: _i1.WidgetbookUseCase(
          name: 'Subtitle',
          builder: _i63.createLabel,
        ),
      ),
      _i1.WidgetbookFolder(
        name: 'Paragraph',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusParagraph',
            useCase: _i1.WidgetbookUseCase(
              name: 'Paragraph',
              builder: _i64.createLabel,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusParagraphSmall',
            useCase: _i1.WidgetbookUseCase(
              name: 'Paragraph Small',
              builder: _i64.createParagraphSmall,
            ),
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'Title',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusTitleLarge',
            useCase: _i1.WidgetbookUseCase(
              name: 'Title Large',
              builder: _i63.createTitleLarge,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusTitleMedium',
            useCase: _i1.WidgetbookUseCase(
              name: 'Title Medium',
              builder: _i63.createTitleMedium,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusTitleSmall',
            useCase: _i1.WidgetbookUseCase(
              name: 'Title Small',
              builder: _i63.createTitleSmall,
            ),
          ),
        ],
      ),
    ],
  ),
];
