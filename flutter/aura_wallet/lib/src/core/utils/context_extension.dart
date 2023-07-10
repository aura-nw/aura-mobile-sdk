import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get query => MediaQuery.of(this);

  Size get size => query.size;

  double get w => size.width;

  double get h => size.height;

  double get bodyHeight => h - kToolbarHeight;

  double get statusBar => query.padding.top;

  double get ratio => query.devicePixelRatio;
}
