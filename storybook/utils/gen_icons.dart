/// Copyright (c) 2020, Mike Hoolehan, StarHeight Media
/// All rights reserved.

/// Redistribution and use in source and binary forms, with or without
/// modification, are permitted provided that the following conditions are met:
///     * Redistributions of source code must retain the above copyright
///       notice, this list of conditions and the following disclaimer.
///     * Redistributions in binary form must reproduce the above copyright
///       notice, this list of conditions and the following disclaimer in the
///       documentation and/or other materials provided with the distribution.
///     * Neither the name of the StarHeight Media nor the
///       names of its contributors may be used to endorse or promote products
///       derived from this software without specific prior written permission.

/// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
/// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
/// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
/// ARE DISCLAIMED. IN NO EVENT SHALL HOOLEHAN OR STARHEIGHT MEDIA BE LIABLE FOR
/// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
/// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
/// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
/// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
/// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
/// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
/// DAMAGE.

/// Generates icons list from fluttericon config
/// dart ./gen_examples.dart ../../optimus/lib/ ../lib

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';

void main(List<String> arguments) {
  final inputDir = Directory(arguments.first);
  final outputDir = Directory(arguments[1]);
  final List<FileSystemEntity> directoryEntities =
      inputDir.listSync(followLinks: false).toList();

  for (final entity in directoryEntities) {
    if (entity is File && entity.path.endsWith('.json')) {
      final Map<String, dynamic> fontConfig =
          json.decode(entity.readAsStringSync()) as Map<String, dynamic>;
      final fontFamilyName = fontConfig['name'].toString();

      final List<dynamic> icons = fontConfig['glyphs'] as List<dynamic>;
      final buffer = StringBuffer()
        ..writeAll(
          [
            '',
            "import 'package:flutter/widgets.dart';",
            "import 'package:optimus/optimus_icons.dart';",
            '',
            '// NB: DO NOT EDIT! This file is auto-generated. See utils/gen_icons.dart',
            '',
            'class IconDetails {',
            'const IconDetails(this.data, this.name);',
            'final IconData data;',
            'final String name;',
            '}',
          ],
          '\n',
        )
        ..writeln('const optimusIcons = <IconDetails>[');

      for (int i = 0; i < icons.length; i++) {
        final Map<String, dynamic> glyps = icons[i] as Map<String, dynamic>;
        final glyphName = convertGlyphName(glyps['css'].toString());
        buffer.writeln(
          "    IconDetails($fontFamilyName.$glyphName, '$glyphName'),",
        );
      }

      buffer.writeln('];');

      File(join(outputDir.path, dartFileName))
          .writeAsStringSync(buffer.toString());
    }
  }
}

String convertGlyphName(String name) {
  String out = name.replaceAll(_glyphNameRegex, '_');
  for (final r in dartReserved) {
    if (out == r) {
      out = '${out}_icon';
      break;
    }
  }

  return out;
}

final _glyphNameRegex = RegExp(r'[^A-Za-z0-9_]');
const dartReserved = [
  'abstract',
  'deferred',
  'if',
  'super',
  'as ',
  'do',
  'implements',
  'switch',
  'assert',
  'dynamic',
  'import',
  'sync',
  'async',
  'else',
  'in',
  'this',
  'enum',
  'is',
  'throw',
  'await',
  'export',
  'library',
  'true',
  'break',
  'external',
  'new',
  'try',
  'case',
  'extends',
  'null',
  'typedef',
  'catch',
  'factory',
  'operator',
  'var',
  'class',
  'false',
  'part',
  'void',
  'const',
  'final',
  'rethrow',
  'while',
  'continue',
  'finally',
  'return',
  'with',
  'covariant',
  'for',
  'set',
  'yield',
  'default',
  'get',
  'static',
  'yield',
];
const dartFileName = 'icons_list.dart';
