import 'package:flutter/widgets.dart';

extension ExcludeSemanticsExtension on Widget {
  Widget excludeSemantics({bool isExcluded = true}) =>
      ExcludeSemantics(excluding: isExcluded, child: this);
}
