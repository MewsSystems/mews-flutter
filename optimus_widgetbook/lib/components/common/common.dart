import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';

final List<IconDetails> exampleIcons = optimusIcons.take(10).toList();
final List<(Alignment, String)> alignments = [
  (Alignment.center, 'Center'),
  (Alignment.centerLeft, 'Center Left'),
  (Alignment.centerRight, 'Center Right'),
  (Alignment.topLeft, 'Top Left'),
  (Alignment.topRight, 'Top Right'),
  (Alignment.bottomLeft, 'Bottom Left'),
  (Alignment.bottomRight, 'Bottom Right'),
];

const longText = '''
Nascetur nec convallis tempor sagittis ligula. Mauris aenean curae vestibulum 
aenean fames posuere consequat turpis. Cursus lectus rutrum dolor condimentum 
rhoncus tincidunt rutrum. Hac amet class vivamus rhoncus condimentum; penatibus 
risus magnis. Penatibus nulla venenatis nulla praesent mauris. Morbi feugiat 
rhoncus ridiculus varius faucibus commodo tincidunt ipsum molestie. Volutpat 
semper aptent viverra facilisi nam nibh suscipit purus himenaeos. Himenaeos 
quisque ultrices condimentum mauris a diam.''';
