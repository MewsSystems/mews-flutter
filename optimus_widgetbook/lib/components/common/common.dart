import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

final List<IconData> allIcons = optimusIcons.map((e) => e.data).toList();

final List<IconData> exampleIcons = [
  OptimusIcons.chevron_left,
  OptimusIcons.chevron_right,
  OptimusIcons.delete,
  OptimusIcons.add_customer,
  OptimusIcons.calendar,
  OptimusIcons.assign,
];
final List<Alignment> alignments = [
  Alignment.center,
  Alignment.centerLeft,
  Alignment.centerRight,
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomLeft,
  Alignment.bottomRight,
];

final List<IconData?> exampleIconsWithNull = [...exampleIcons, null];
const longText = '''
Nascetur nec convallis tempor sagittis ligula. Mauris aenean curae vestibulum 
aenean fames posuere consequat turpis. Cursus lectus rutrum dolor condimentum 
rhoncus tincidunt rutrum. Hac amet class vivamus rhoncus condimentum; penatibus 
risus magnis. Penatibus nulla venenatis nulla praesent mauris. Morbi feugiat 
rhoncus ridiculus varius faucibus commodo tincidunt ipsum molestie. Volutpat 
semper aptent viverra facilisi nam nibh suscipit purus himenaeos. Himenaeos 
quisque ultrices condimentum mauris a diam.''';
