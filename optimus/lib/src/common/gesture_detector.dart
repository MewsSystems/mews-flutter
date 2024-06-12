import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class CustomRawGestureDetector extends RawGestureDetector {
  CustomRawGestureDetector({
    super.key,
    GestureTapCallback? onTap,
    super.child,
  }) : super(
          behavior: HitTestBehavior.opaque,
          gestures: <Type, GestureRecognizerFactory>{
            _AllowMultipleGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<
                    _AllowMultipleGestureRecognizer>(
              _AllowMultipleGestureRecognizer.new,
              (_AllowMultipleGestureRecognizer instance) =>
                  instance.onTap = onTap,
            ),
          },
        );
}

class _AllowMultipleGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) => acceptGesture(pointer);
}
