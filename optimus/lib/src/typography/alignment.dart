import 'package:flutter/material.dart';

enum OptimusTypographyAlignment { left, right, center }

extension ToAlign on OptimusTypographyAlignment {
  TextAlign get textAlign {
    switch (this) {
      case OptimusTypographyAlignment.left:
        return TextAlign.left;
      case OptimusTypographyAlignment.right:
        return TextAlign.right;
      case OptimusTypographyAlignment.center:
        return TextAlign.center;
    }
  }
}
