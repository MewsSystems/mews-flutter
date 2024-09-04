// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:optimus_widgetbook/components/chip.dart' as _i2;
import 'package:optimus_widgetbook/components/forms/checkbox.dart' as _i3;
import 'package:optimus_widgetbook/components/forms/checkbox_group.dart' as _i4;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'Feedback',
    children: [
      _i1.WidgetbookLeafComponent(
        name: 'OptimusChip',
        useCase: _i1.WidgetbookUseCase(
          name: 'Default Style',
          builder: _i2.defaultStyle,
        ),
      )
    ],
  ),
  _i1.WidgetbookCategory(
    name: 'Forms',
    children: [
      _i1.WidgetbookFolder(
        name: 'Checkbox',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'OptimusCheckbox',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default Style',
              builder: _i3.defaultStyle,
            ),
          ),
          _i1.WidgetbookLeafComponent(
            name: 'OptimusCheckboxGroup<int>',
            useCase: _i1.WidgetbookUseCase(
              name: 'Default Style',
              builder: _i4.defaultStyle,
            ),
          ),
        ],
      )
    ],
  ),
];
