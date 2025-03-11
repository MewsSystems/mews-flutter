import 'package:flutter/widgets.dart';
import 'package:optimus/optimus.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'All Icons', type: GridView, path: '[Media]/Icons')
Widget createDefaultStyle(BuildContext _) => GridView.builder(
  itemCount: optimusIcons.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 5,
  ),
  itemBuilder:
      (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            OptimusIcon(iconData: optimusIcons[index].data),
            Text(optimusIcons[index].name, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
);
