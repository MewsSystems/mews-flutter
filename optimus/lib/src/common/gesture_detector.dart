import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class AllowMultipleRawGestureDetector extends RawGestureDetector {
  AllowMultipleRawGestureDetector({
    super.key,
    GestureTapCallback? onTap,
    GestureTapDownCallback? onTapDown,
    super.behavior = HitTestBehavior.opaque,
    super.child,
  }) : super(
          gestures: <Type, GestureRecognizerFactory>{
            AllowMultipleGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    AllowMultipleGestureRecognizer>(
              AllowMultipleGestureRecognizer.new,
              (AllowMultipleGestureRecognizer instance) {
                instance
                  ..onTap = onTap
                  ..onTapDown = onTapDown;
              },
            ),
          },
        );
}

class AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);
}
