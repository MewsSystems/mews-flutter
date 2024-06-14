import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class AllowMultipleRawGestureDetector extends RawGestureDetector {
  AllowMultipleRawGestureDetector({
    super.key,
    GestureTapCallback? onTap,
    super.child,
  }) : super(
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            AllowMultipleGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    AllowMultipleGestureRecognizer>(
              AllowMultipleGestureRecognizer.new,
              (AllowMultipleGestureRecognizer instance) =>
                  instance.onTap = onTap,
            ),
          },
        );
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);
}
