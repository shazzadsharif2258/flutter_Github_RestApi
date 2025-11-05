import 'package:flutter/material.dart';

class Responsive {
  static late MediaQueryData _mq;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mq = MediaQuery.of(context);
    screenWidth = _mq.size.width;
    screenHeight = _mq.size.height;
  }

  static double h(double percent) =>
      screenHeight * (percent / 100);

  static double w(double percent) =>
      screenWidth * (percent / 100);

  static bool get isTablet => screenWidth >= 600;

  static double get safeTop => _mq.padding.top;
  static double get safeBottom => _mq.padding.bottom;
}
